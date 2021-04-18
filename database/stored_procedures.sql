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
DROP PROCEDURE IF EXISTS registerStudentGps;
DELIMITER $$
CREATE PROCEDURE registerStudentGps(
	IN student_id INT,
    IN gps_latitude DECIMAL(10,8),
    IN gps_longitude DECIMAL(11,8),
    IN gps_range DECIMAL(6,5),
    OUT within_range CHAR(1)
)
BEGIN 
	INSERT INTO `gps_coordinates` (`latitude`, `longitude`, `range`) VALUES (gps_latitude, gps_longitude, gps_range);
    
END $$
DELIMITER ;
    
    
#INSERT INTO `gps_coordinates` (`latitude`, `longitude`, `range`) VALUES ('60.70392118', '22.537521047',7.55555);
