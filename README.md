# Group5 - Databases for Developers
## Members:
- Immanuel Storm Lokzinsky
- Jeppe Nannestad Dyekjær
- Andrian Bogdanov Vangelov

## This repository has:
- Database
- Backend

The folders are separated as:
- Database - `database` directory has:
    - `README.md` file - explains the purpose and gives instructions on how to use the artifacts in this directory.
    - `design` directory - it holds all files explaining the design decisions behind the implementation of the database.
    - `.mwb` file - this file is the main entry point for managing the MySQL database. Read the `README.md` file inside the `database` directory for information on how to use it.
    - `*.sql` files - check the `README.md` file inside the `database` directory for more information on their purpose and how to use them.

- Backend - `appication` directory has:
    - the Spring Boot project
    - `design` directory - diagrams and artifacts related to the backend server

- Frontend - `application` directory has:
	- the React project

## Consumer Front-End + API - Java application
You can access the consumer frontend and backend applications on https://rollcallfrontend.azurewebsites.net/ and https://rollcallapp.azurewebsites.net/swagger-ui-custom.html respectively. You could also attempt to install everything locally. An installation guide is provided below.
Installation guide
Required software:
-Java Runtime Environment, get it here: https://www.java.com/en/download/manual.jsp
-Docker Desktop, get it here: https://www.docker.com/products/docker-desktop
-Postman, get it here: https://www.postman.com/downloads/
-MySQL workbench, get it here: https://dev.mysql.com/downloads/workbench/
-Node.js and NPM, get it here: https://nodejs.org/en/    

Docker/MySQL: Setting up Docker and MySQL
First step is to set up a local database. One way of doing it is by setting up a docker container with the MySQL image. Open a command line interface and confirm that docker is installed by entering “docker -v ”. Create a container by running the command “docker run -p 3307:3306 --name my-mysql -e MYSQL_ROOT_PASSWORD=root -d mysql/mysql-server:latest”. Now we need to interact with the container bash. Run “docker exec -it my-mysql /bin/bash”. Login using “root” as the username and password by running the command “mysql -uroot -p -A”. Run the following SQL statement: “update mysql.user set host=’%’ where user=’root’; ”. Follow this by running “flush privileges;”. This should allow us to access the database from outside the container.

MySQL Workbench: Setting Up the Database schema
Now it’s time to open up “mysql workbench”. Click the + icon next to MySQL connections. The connection name can be whatever you like. Set hostname to localhost, port to 3307 and username to “root”. Click on “test connection” and enter “root” as the password. Click on the newly added connection and query tab will appear. Copy the contents of the roll_call_db_forward_engineered.sql file into the query tab and execute it by clicking on the lightning button. That’s it for the database setup.

Running the REST Api
Next you need to run the spring application. To do this simply run the  “java -jar TARGET” command in a command line with TARGET being the “roll-call-system-demo.jar” file provided.
You should now be able to interact with the REST api using Postman. Look at “Description of important endpoints for references”.

Running the Frontend application. 
Simply navigate to application\frontend_roll_call_system\roll-call-app and run “npm start” on the command line. The application will run on localhost:3000.
If no lectures are displayed under “active lectures” after logging in, execute the following query on your database: “UPDATE `roll_call_db`.`lecture` SET `date` = NOW() + INTERVAL 3 HOUR WHERE (id>0);”.
