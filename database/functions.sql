#1. A function that takes a student and a course as arguments and gets the attendance rate 
#for that student and that course. If course is null then get the attendance rate for the 
#student across all lectures regardless of course.
DELIMITER $$
CREATE FUNCTION getStudentLectureAttendanceRate(
	arg_student_id INT,
    arg_course_id INT
)
RETURNS DECIMAL
DETERMINISTIC
BEGIN
	DECLARE studentLectureAttendanceRate DECIMAL;
	DECLARE amountOfAttendances INT;
    
    SET amountOfAttendances = (SELECT count(is_attending) FROM attendance_record ar
								JOIN lecture l ON ar.lecture_id = l.id
								JOIN course c ON l.course_id = c.id
								WHERE is_attending = 1 AND c.id = arg_course_id);
    
	#SET studentLectureAttendanceRate = (SELECT count(*) FROM lecture l
	#										JOIN course c ON 
	#										WHERE )/amountOfAttendances;


END$$

#COUNT(registred_at);
