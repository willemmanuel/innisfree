#Installation Plan

##Overview
This is a work in progress. Currently we're working with Monika to get BlueHost credentials. Once we have the credentials, we will configure Rails on the server, upload our app and deploy it using this [guide](https://my.bluehost.com/cgi/help/rails) and this [guide](http://www.dotkam.com/2009/02/01/deploy-rails-application-on-bluehost/).

##Steps:
1. Get BlueHost credentials
2. Create subdomain (here named scheduling)
2. Using BlueHost's FTP tools, copy zipped code to BlueHost (place it in the home directory for now)
3. SSH to BlueHost
  0. Make a new directory named rails ```mkdir ~/rails```
  1. ```cd rails```
  1. Install Rails: ```gem install rails -v 4.1.1 --no-rdoc --no-ri```
  2. Install Rake: ```gem install rake -v '10.4.2' --no-rdoc --no-ri```
  7. Edit .bash.rc file as described in first guide
  3. Create Rails app: ```rails new innisfree -d mysql```
  4. Unzip application code: ```unzip ~/innisfree.zip````
  6. ```cd innisfree```
  5. Install missing gems ```bundle install --path vendor/bundle```
  6. Create __app__ .htaccess file (e.g. ```~/rails/innisfree/public/.htaccess```) as described in first guide
    - Change the second to last line to ```SetEnv GEM_HOME /home2/voluntf8/ruby/gems```
  5. Link subdomain and application directory as described in first guide
    - Create symbolic link from domain to app: ```ln -s ~/rails/innisfree/public ~/public_html/scheduling```
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
6. The server may issue a Sprockets::CircularDependency issue. If so, delete the application.css file: ```rm ~/rails/innisfree/app/assets/stylesheets/application.css```
