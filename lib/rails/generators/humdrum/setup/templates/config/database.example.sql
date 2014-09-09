default: &default
  adapter: <%= dbase %>
  encoding: unicode
  reconnect: false
  pool: 5
  timeout: 5000
  host: localhost
  port: 5432

development:
  <<: *default
  database: <%= dbase_name %>_development
  username: <user>
  password: <password>

test: &test
  <<: *default
  database: <%= dbase_name %>_test
  username: <user>
  password: <password>

staging:
  <<: *default
  database: <%= dbase_name %>_staging
  username: <user>
  password: <password>

production:
  <<: *default
  database: <%= dbase_name %>_production
  username: <user>
  password: <password>

cucumber:
  <<: *test

