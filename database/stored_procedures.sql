#A function that takes a course, a class and a faculty as arguments in order
#to get the average attendance rate of the specific class for the specific course 
#Pseudo Query: ”select avg(getStudentLectureAttendanceRate(student.id,1)) from student  
#where class_id=1”
DROP PROCEDURE IF EXISTS get_average_class_attendance_rate;
DELIMITER $$
CREATE PROCEDURE get_average_class_attendance_rate(
    student_id_arg INT,
    course_id_arg INT,
	class_id_arg INT
)
BEGIN 
	SELECT AVG(getStudentLectureAttendanceRate(student_id_arg, course_id_arg)) AS class_attendance_rate
    FROM student
    WHERE class_id = class_id_arg;
END $$
DELIMITER ;