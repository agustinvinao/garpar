namespace :data do
  desc 'Restore data for a user'
  task :restore, %i[user_email filename] => :environment do |_task_name, args|
    p args
    unless args.user_email || args.filename
      Rails.logger.error('no email and/or file')
      exit
    end
    puts "args.filename: #{args.filename}"
    if user = User.find_by(email: args.user_email)
      ActiveRecord::Base.connection.execute('SET FOREIGN_KEY_CHECKS = 0;')
      %w[companies clients periods invoice_entries expense_entries].each do |table_name|
        ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name}")
      end
      ActiveRecord::Base.connection.execute('SET FOREIGN_KEY_CHECKS = 1;')

      # user.companies.each { |company| company.clients.delete_all }
      # user.companies.delete_all

      # currencies = Currency.all.reduce({}) do |currency|
      #   [currency.name] => currency
      # end

      filename = Rails.root.join(args.filename)
      data = ActiveSupport::JSON.decode(File.read(filename))
      # companies
      data.each do |company_data|
        company_data_address = company_data['address']
        company = Company.create!(
          name: company_data['name'],
          vat_number: company_data['vatNumber'],
          number: company_data['number'],
          email: company_data['contact']['email'],
          phone: company_data['contact']['phone'],
          address: Address.new(
            apartment: company_data_address['apartment'],
            line1: company_data_address['line1'],
            line2: company_data_address['line2'],
            line3: company_data_address['line3'],
            postal_code: company_data_address['postalCode'],
            state: company_data_address['state'],
            country: company_data_address['country']
          ),
          user: user
        )
        puts "[company added]: #{company.name}" # Rails.logger.info

        # bank accounts
        BankAccount.create!(
          name: company_data['account']['bank'],
          sort_code: company_data['account']['sortCode'],
          account_number: company_data['account']['nro'],
          iban: company_data['account']['IBAN'],
          bic: company_data['account']['BIC'],
          company: company
        )

        # clients
        company_data['clients'].each do |client_data|
          client_data_address = client_data['address']
          client = Client.new(
            name: client_data['name'],
            contact: client_data['contact'],
            address: Address.new(
              apartment: client_data_address['apartment'],
              line1: client_data_address['line1'],
              line2: client_data_address['line2'],
              line3: client_data_address['line3'],
              postal_code: client_data_address['postalCode'],
              state: client_data_address['state'],
              country: client_data_address['country']
            )
          )
          company.clients << client
          puts "[client added]: #{client.name}" # Rails.logger.info

          # items
          client_data['items'].each do |item|
            p "item['due'].to_date: #{item['due'].to_date}"
            period = Period.new(
              due: item['due'].to_date,
              year: item['id'].split('-')[0][0..3].to_i,
              month: item['id'].split('-')[0][4..5].to_i,
              number: item['id'].split('-')[1] ? item['id'].split('-')[1].to_i : 1
            )
            client.periods << period

            # invoices
            invoice_items_data = item['invoiceItems']
            invoice_items_data.each do |invoice_entry|
              invoice_entry = InvoiceEntry.new(
                description: invoice_entry['description'],
                amount: invoice_entry['amount'].to_f,
                rate: invoice_entry['rate'].to_f,
                currency: Currency.find_by(name: invoice_entry['currency']),
                vat: invoice_entry['vat'].to_f
              )
              period.invoice_entries << invoice_entry
            end

            # expenses
            expense_items_data = item['expenseItems']
            expense_items_data.each do |expense_entry|
              expense_entry = ExpenseEntry.new(
                description: expense_entry['description'],
                amount: expense_entry['amount'].to_f,
                currency: Currency.find_by(name: expense_entry['currency']),
                claim_percentage: expense_entry['claimPercentage'].to_f
              )
              period.expense_entries << expense_entry
            end
          end
          client.save!

          # # Rails.logger.info("[item added]: #{client.name}")
          # puts "[client added]: #{client.name}"
        end
      end
    end
  end
end
