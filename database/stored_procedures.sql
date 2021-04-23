#A function that takes a course, a class and a faculty as arguments in order
#to get the average attendance rate of the specific class for the specific course 
#Pseudo Query: ”select avg(getStudentLectureAttendanceRate(student.id,1)) from student  
#where class_id=1”
DROP PROCEDURE IF EXISTS get_average_class_attendance_rate;
DELIMITER $$
CREATE PROCEDURE get_average_class_attendance_rate(
    course_id_arg INT,
	class_id_arg INT
)
BEGIN 
	SELECT AVG(getStudentLectureAttendanceRate(student.id, course_id_arg)) AS class_attendance_rate
    FROM student
    WHERE class_id = class_id_arg;
END $$
DELIMITER ;

#A stored procedure, which will insert network and GPS records for a student (or only GPS for a teacher), 
#once they are successfully retrieved from the front-end, 
#a request will be sent to the back-end and the back-end 
#will call this stored procedure providing the correct parameters. 
#What could be returned is if the student is within the range of the 
#teacher’s registered GPS coordinates.
DROP PROCEDURE IF EXISTS get_average_class_attendance_rate;
DELIMITER $$
CREATE PROCEDURE get_average_class_attendance_rate(
    course_id_arg INT,
	class_id_arg INT
)
BEGIN 
	SELECT AVG(getStudentLectureAttendanceRate(student.id, course_id_arg)) AS class_attendance_rate
    FROM student
    WHERE class_id = class_id_arg;
END $$
DELIMITER ;

#A stored procedure, which will insert network and GPS records for a student (or only GPS for a teacher), 
#once they are successfully retrieved from the front-end, 
#a request will be sent to the back-end and the back-end 
#will call this stored procedure providing the correct parameters. 
#What could be returned is if the student is within the range of the 
#teacher’s registered GPS coordinates.
DROP PROCEDURE IF EXISTS register_student_gps;
DELIMITER $$
CREATE PROCEDURE register_student_gps(
	IN student_id INT,
    IN teacher_id INT,
    IN student_latitude DECIMAL(10,8),
    IN student_longitude DECIMAL(11,8),
    IN gps_range DECIMAL(6,5),
	OUT within_range CHAR(1)
)
BEGIN 
	DECLARE added_gps_id INT;
    DECLARE teacher_latitude DECIMAL(10,8);
    DECLARE teacher_longitude DECIMAL(11,8);
    DECLARE lat_deg_dist DECIMAL(10,3);
    DECLARE long_deg_dist DECIMAL(8,3);
			    
	INSERT INTO `gps_coordinates` (`latitude`, `longitude`, `range`) VALUES (student_latitude, student_longitude, gps_range);
	SELECT LAST_INSERT_ID() INTO added_gps_id;

	#Updating student with the inserted gps coordinates
	UPDATE student 
		SET 
			gps_coordinates_id = added_gps_id
		WHERE
			id = student_id;

	#Getting latitude and longitude values for a teacher.
	SET teacher_latitude = (SELECT latitude FROM gps_coordinates gc
								JOIN teacher t ON gc.id = t.gps_coordinates_id
								WHERE t.id = teacher_id);
						   
	SET teacher_longitude = (SELECT longitude FROM gps_coordinates gc
								JOIN teacher t ON gc.id = t.gps_coordinates_id
								WHERE t.id = teacher_id);
   
	#Source for calculating distance - https://www.usgs.gov/faqs/how-much-distance-does-a-degree-minute-and-second-cover-your-maps?qt-news_science_products=0#qt-news_science_products
	SET lat_deg_dist = 111033.736; #Distance for one latitude degree in meters
	SET long_deg_dist = 87870.182; #Distance for one longitude degree in meters
	
	#Comparing gps values for teacher and student meter distance and returning within range value. 
	IF  (teacher_latitude = student_latitude AND teacher_longitude = student_longitude) #When student gps values are equal to teacher gps values
	THEN
		SELECT 'y' INTO within_range;
		
	ELSEIF (teacher_latitude > student_latitude OR teacher_longitude > student_longitude) #When gps values are higher for a teacher than a student but still within 9.99999 meters range
		AND ((teacher_latitude * lat_deg_dist) - (student_latitude * lat_deg_dist)) <= 9.99999 
		AND ((teacher_longitude * long_deg_dist) - (student_longitude * long_deg_dist)) <= 9.99999
	THEN
		SELECT 'y' INTO within_range;
		
	ELSEIF (student_latitude > teacher_latitude OR student_longitude > teacher_longitude) #When gps values are higher for a student than a teacher but still within 9.99999 meters range 
	AND ((student_latitude * lat_deg_dist) - (teacher_latitude * lat_deg_dist)) <= 9.99999 
	AND ((student_longitude * long_deg_dist) - (teacher_longitude * long_deg_dist)) <= 9.99999 
	THEN
		SELECT 'y' INTO within_range;
	ELSE 
		SELECT 'n' INTO within_range; 
	END IF;   

END $$
DELIMITER ;


