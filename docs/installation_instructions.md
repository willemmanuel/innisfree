#Installation Plan

##Overview
Steps based on this [guide](https://my.bluehost.com/cgi/help/rails) and this [guide](http://www.dotkam.com/2009/02/01/deploy-rails-application-on-bluehost/).

##Steps:
1. Get BlueHost credentials
2. Create subdomain (here named scheduling)
  - Click ```Subdomain``` button in cPanel
  - ![Figure 1](https://farm8.staticflickr.com/7427/16378275440_42a5df42bc_b.jpg)
  - Fill out subdomain information
  - ![Figure 2](https://farm8.staticflickr.com/7439/16378275400_46d87c62e8_b.jpg)
3. Create Ruby on Rails application through cPanel
  - Click ```Ruby on Rails``` button in cPanel
  - ![Figure 3](https://farm8.staticflickr.com/7307/16539726066_d8bcd8999e_b.jpg)
  - Fill out application information
  - ![Figure 4](https://farm8.staticflickr.com/7287/16378275470_028f177cc7_b.jpg)
4. Create a MySQL database for the scheduling application, and add a user to it
2. Using BlueHost's File Manager tool, copy zipped code to BlueHost (place it in the home directory for now)
  - Alternatively, you can skip this step and pull the code from GitHub later
3. SSH to BlueHost using putty or a similar tool
  4. Change to the ```rails_apps``` directory: ```cd ~/rails_apps``` 
  1. Install Rails: ```gem install rails -v 4.1.1 --no-rdoc --no-ri```
  2. Install Rake: ```gem install rake -v '10.4.2' --no-rdoc --no-ri```
  7. Edit .bash.rc file as described in the first [guide](https://my.bluehost.com/cgi/help/rails)
  4. Unzip application code: ```unzip ~/innisfree.zip````
    - Type ```A``` when prompted to overwrite all common files
    - If you chose to instead pull the code from GitHub, do that now: ```git clone https://github.com/uva-slp/innisfree```
  6. ```cd innisfree```
  7. Uncomment line containing ```gem 'therubyracer'``` in Gemfile
  5. Install missing gems ```bundle install --path vendor/bundle```
  6. Create __app__ .htaccess file (e.g. ```~/rails_app/innisfree/public/.htaccess```) as described in the first [guide](https://my.bluehost.com/cgi/help/rails)
    - Change the second to last line to ```SetEnv GEM_HOME /home2/voluntf8/ruby/gems```
  5. Delete the subdomain directory: ```rm -rf ~/public_html/scheduling```
  5. Link subdomain and application directory as described in the first [guide](https://my.bluehost.com/cgi/help/rails)
    - Create symbolic link from domain to app: ```ln -s ~/rails_apps/innisfree/public ~/public_html/scheduling```
4. Create config/database.yml from config/database.yml.template (in the Rails application directory) so production entry points to BlueHost SQL server:

        
        production:
          adapter: mysql2
          pool: 5
          port: 3306
          database: $DATABASE_NAME
          username: $USER_NAME
          password: $PASSWORD
          host: localhost
        
5. Run ```rake db:migrate```
6. Delete the application.css file, if it exists: ```rm ~/rails_app/innisfree/app/assets/stylesheets/application.css```


## Sample files
#### Sample config/database.yml
    
    # SQLite version 3.x
    #   gem install sqlite3
    #
    #   Ensure the SQLite 3 gem is defined in your Gemfile
    #   gem 'sqlite3'
    #
    default: &default
    
    development:
      adapter: mysql2
      pool: 5
      port: 3306
      database: $DEV_DATABASE_NAME
      username: $USER_NAME
      password: $PASSWORD
      host: localhost
    
    # Warning: The database defined as "test" will be erased and
    # re-generated from your development database when you run "rake".
    # Do not set this db to the same as development or production.
    test:
      adapter: sqlite3
      pool: 5
      timeout: 5000
      database: db/test.sqlite3
    
    production:
      adapter: mysql2
      pool: 5
      port: 3306
      database: $DATABASE_NAME
      username: $USER_NAME
      password: $PASSWORD
      host: localhost
    
#### Sample public/.htaccess file
    <IfModule mod_passenger.c>
      Options -MultiViews
      PassengerResolveSymlinksInDocumentRoot on
      #Set this to whatever environment (development, production) you'll be running in
      RailsEnv production
      RackBaseURI /
      SetEnv GEM_HOME /home2/voluntf8/ruby/gems
    </IfModule>
