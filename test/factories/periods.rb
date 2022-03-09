# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :period do
    due_date = Faker::Date.between(
      from: '2018-12-01',
      to: Time.zone.today
    )
    due { due_date }
    year { due_date.year }
    month { due_date.month }
    sequence(:number) { |n| n }
    client
  end
end
