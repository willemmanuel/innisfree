#Innisfree Village Appointment Scheduling
---

###Testing
To run the code on your local machine, execute the run_test_server.sh script
This starts the server in production mode (necessary since Pegasus server is configured to run in development mode)

###Notes on Development & Production modes
Since Professor Bloomfield has configured the course server to run in development mode, we use production mode for local testing. This is set to use SQLite3 for the database storage and has some changes made to config/environments/production.rb to allow for debugging similar to config/environments/development.rb (useful error pages if something crashes, better logging). Changes were also made to config/secrets.yml and config/secrets.yml.template to hide the development secret key, since that's on the public server, and use a pre-defined key for production, since that's local.
