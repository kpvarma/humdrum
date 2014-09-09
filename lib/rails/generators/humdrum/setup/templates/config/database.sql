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
  username: <%= db_username %>
  password: <%= db_password %>

test: &test
  <<: *default
  database: <%= dbase_name %>_test
  username: <%= db_username %>
  password: <%= db_password %>

staging:
  <<: *default
  database: <%= dbase_name %>_staging
  username: <%= db_username %>
  password: <%= db_password %>

production:
  <<: *default
  database: <%= dbase_name %>_production
  username: <%= db_username %>
  password: <%= db_password %>

cucumber:
  <<: *test


