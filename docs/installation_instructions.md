#Installation Plan

##Overview
This is a work in progress. Currently we're working with Monika to get BlueHost credentials. Once we have the credentials, we will configure Rails on the server, upload our app and deploy it using this [guide](https://my.bluehost.com/cgi/help/rails) and this [guide](http://www.dotkam.com/2009/02/01/deploy-rails-application-on-bluehost/).


Need to re-write to take advantage of BlueHost's tools for Rails apps
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
2. Using BlueHost's FTP tools, copy zipped code to BlueHost (place it in the home directory for now)
3. SSH to BlueHost
  4. Change to the ```rails_app``` directory: ```cd ~/rails_app``` 
  1. Install Rails: ```gem install rails -v 4.1.1 --no-rdoc --no-ri```
  2. Install Rake: ```gem install rake -v '10.4.2' --no-rdoc --no-ri```
  7. Edit .bash.rc file as described in first guide
  4. Unzip application code: ```unzip ~/innisfree.zip````
    - Type ```A``` when prompted to overwrite all common files
  6. ```cd innisfree```
  7. Uncomment line containing ```gem 'therubyracer'``` in Gemfile
  5. Install missing gems ```bundle install --path vendor/bundle```
  6. Create __app__ .htaccess file (e.g. ```~/rails_app/innisfree/public/.htaccess```) as described in first guide
    - Change the second to last line to ```SetEnv GEM_HOME /home2/voluntf8/ruby/gems```
  5. Link subdomain and application directory as described in first guide
    - Create symbolic link from domain to app: ```ln -s ~/rails_app/innisfree/public ~/public_html/scheduling```
4. Create config/database.yml from config/database.yml.template so production entry points to BlueHost SQL server:

        
        production:
          adapter: mysql2
          pool: 5
          timeout: 5000
          username: $USER_NAME
          password: $PASSWORD
          database: $DATABASE_NAME
          host: localhost
        
5. Run ```rake db:migrate```
6. Delete the application.css file: ```rm ~/rails_app/innisfree/app/assets/stylesheets/application.css```
