# Runs the test server
# Uses production mode to connect to sqlite3 db as pegasus needs dev env.

bundle install --path vendor/bundle
rake db:migrate RAILS_ENV=production
rails server -e production