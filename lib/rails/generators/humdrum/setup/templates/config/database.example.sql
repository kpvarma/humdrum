development:
  adapter: <%= dbase %>
  encoding: unicode
  reconnect: false
  database: <%= dbase_name %>_development
  pool: 5
  username: <user>
  password: <password>
  host: localhost
  port: 5432

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: <%= dbase %>
  encoding: unicode
  reconnect: false
  database: <%= dbase_name %>_test
  pool: 5
  username: <user>
  password: <password>
  host: localhost
  port: 5432

staging:
  adapter: <%= dbase %>
  encoding: unicode
  reconnect: false
  database: <%= dbase_name %>_staging
  pool: 5
  username: <username>
  password: <password>
  host: localhost
  port: 5432

demo:
  adapter: <%= dbase %>
  encoding: unicode
  reconnect: false
  database: <%= dbase_name %>_demo
  pool: 5
  username: <username>
  password: <password>
  host: localhost
  port: 5432

production:
  adapter: <%= dbase %>
  encoding: unicode
  reconnect: false
  database: <%= dbase_name %>_demo
  pool: 5
  username: <username>
  password: <password>
  host: localhost
  port: 5432


