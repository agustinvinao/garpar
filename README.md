> This application provides a simple workflow to create invoices and expenses document for bookkeeping.

### tech info

- Ruby version: 3.1.1

- System dependencies

- Configuration
  There is two files that require to be renamed:

  - db/seed.db.sample => db/seed.db (even you won't add any seed data in order to have db:seed command available)
  - data/data.json.sample => data/data.json (this is used to import a json data file with company/client/invoices/expenses data)

- Database creation

- Database initialization
  As any ohter RoR project:

  ```
  rails db:setup
  ```

- How to run the test suite
  ````
  docker-compose run -e "RAILS_ENV=test" test bundle exec rails test
  ```
  ````

  ```
  docker-compose run -e "RAILS_ENV=test" test bundle exec rails test
  ```

```
docker-compose -f docker-compose.yaml -f docker-compose.test.yaml exec web bundle exec rails test

docker-compose run -e "RAILS_ENV=test" test bundle exec rails test
docker-compose run -e "RAILS_ENV=test" test bundle exec rails db:drop
```

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

## short term roadman

- adding invoices/expenses
- adding repetitive invoices/expenses
- reminders for creating monthly bookkeeping
- export/import data.json as backup capability
