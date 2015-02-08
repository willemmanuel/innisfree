# Runs the test server
# Uses production mode to connect to sqlite3 db as pegasus needs dev env.

bundle install --path vendor/bundle
bundle exec rake db:migrate
rails server
