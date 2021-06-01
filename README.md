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
- Required software:
	- Java Runtime Environment, get it here: https://www.java.com/en/download/manual.jsp
	- Docker Desktop, get it here: https://www.docker.com/products/docker-desktop
	- Postman, get it here: https://www.postman.com/downloads/
	- MySQL workbench, get it here: https://dev.mysql.com/downloads/workbench/
	- Node.js and NPM, get it here: https://nodejs.org/en/    

- Docker/MySQL Setting up Docker and MySQL:
	<br/>
	First step is to set up a local database. One way of doing it is by setting up a docker container with the MySQL image. Open a command line interface and confirm that docker is installed by entering “docker -v ”. Create a container by running the command “docker run -p 3307:3306 --name my-mysql -e MYSQL_ROOT_PASSWORD=root -d mysql/mysql-server:latest”. Now we need to interact with the container bash. Run “docker exec -it my-mysql /bin/bash”. Login using “root” as the username and password by running the command “mysql -uroot -p -A”. Run the following SQL statement: “update mysql.user set host=’%’ where user=’root’; ”. Follow this by running “flush privileges;”. This should allow us to access the database from outside the container.

- MySQL Workbench: Setting Up the Database schema:
	<br/>
	Now it’s time to open up “mysql workbench”. Click the + icon next to MySQL connections. The connection name can be whatever you like. Set hostname to localhost, port to 3307 and username to “root”. Click on “test connection” and enter “root” as the password. Click on the newly added connection and query tab will appear. Copy the contents of the roll_call_db_forward_engineered.sql file into the query tab and execute it by clicking on the lightning button. That’s it for the database setup.

- Running the REST Api:
	<br/>
	Next you need to run the spring application. To do this simply run the  “java -jar TARGET” command in a command line with TARGET being the “roll-call-system-demo.jar” file provided.
	You should now be able to interact with the REST api using Postman. Look at “Description of important endpoints for references”.

- Running the Frontend application:
	<br/>
	Simply navigate to application\frontend_roll_call_system\roll-call-app and run “npm start” on the command line. The application will run on localhost:3000.
	If no lectures are displayed under “active lectures” after logging in, execute the following query on your database: “UPDATE `roll_call_db`.`lecture` SET `date` = NOW() + INTERVAL 3 HOUR WHERE (id>0);”.


## How to run the roll call application

1.  First the application needs to run. It can either be done on the localhost by running the spring backend and the react frontend at the same time or by accessing the azure application on https://rollcallfrontend.azurewebsites.net/ and https://rollcallapp.azurewebsites.net/swagger-ui-custom.html. For the local applications go to localhost:3000 and localhost:8080.
2.  When the application runs, the first screen will be a sign in page where “Please login” is displayed. From the sign in page the user can either sign in as a teacher or a student. Below are two examples of credentials. A teacher and a student.
<br/>
Teacher:
<br/>
Username: tomas@kea.dk
Password: password
<br/>
Student:
Username: jeppe@stud.kea.dk
Password: password

3.  If a user signs in as a teacher the user will be redirected to the page /teacherhome where information about the teacher’s classes, active lectures and dates of the lectures are displayed. From there the teacher can click on the link texts of active lectures which then will display the lecture date, course, name, teachers and your coordinates.
4.  In the lower bottom of the teacherlecture/?lectureId page, a teacher can start a lecture registration by setting a specific amount of minutes which is how much time students have to register themselves as attending the given lecture.The code can be inputted or it will be automatically generated. During/after the registration the teacher has an overview of the attendance rate of the lecture by clicking the “view list” button. It will then display the full list of expected students for a lecture and if they are attending (marked with 1 next to the name of each student), not attending (marked with 0 or nothing next to the name of each student) and a calculation of the overall percentage attendance rate of the lecture in the title “Attendance rate”. This list should be updated as the timer counts down.
5.  If a student  signs in, the user will be redirected to the page /studenthome where information about the student’s classes, active lectures and stats of total participation in all courses and one specific course are displayed. At the bottom of the page, we’re displaying the participation rates of all the courses the student is enrolled in as well as the overall participation rate. From there the student can click on the link texts of active lectures which will display ip address, lecture course, lecture name, lecture teachers and current coordinates. The student can then enter the code in the code input field and clicking on “register attendance”. If the code is correct and either the coordinates or the ip is valid (equal to that of the teacher and one of the faculties networks respectively), the registration should be successful.
6.  In order to sign out of the system it can be done in the lower bottom of the page by pressing the link text: “Logout”.
