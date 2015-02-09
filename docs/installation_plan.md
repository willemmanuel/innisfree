#Installation Plan

##Overview
This is a work in progress. Currently we're working with Monika to get BlueHost credentials. Once we have the credentials, we will configure Rails on the server, upload our app and deploy it using this [guide](https://my.bluehost.com/cgi/help/rails) and this [guide](http://www.dotkam.com/2009/02/01/deploy-rails-application-on-bluehost/).

##Steps:
1. Get BlueHost credentials
2. Using BlueHost's FTP tools, copy zipped code to BlueHost
3. SSH to BlueHost
  1. Create subdomain
  2. Install Rails: ```gem install rails - v 4.1.1 --no-rdoc --no-ri``
  3. Create Rails app: ```rails new ~/innisfree -d mysql```
  4. Unzip application code to application directory: ```unzip innisfree.zip ~/innisfree/```
  5. Link subdomain and application directory as described in first guide
    - Create symbolic link from domain to app: ```ln -s ~/APPNAME/public ~/public_html/APPNAME```
  6. Edit __app__ .htaccess file (e.g. ```~/innisfree/public/.htaccess```) as described in first guide
  7. Edit .bash.rc file as described in first guide
4. Edit config/database.yml so production entry points to BlueHost SQL server:

        
        production:
          adapter: mysql2
          pool: 5
          timeout: 5000
          username: $USER_NAME
          password: $PASSWORD
          database: $DATABASE_NAME
          host: localhost
        
5. Run ```rake db:migrate```
