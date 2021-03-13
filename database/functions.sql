#1. A function that takes a student and a course as arguments and gets the attendance rate 
#for that student and that course. If course is null then get the attendance rate for the 
#student across all lectures regardless of course.
DELIMITER $$
CREATE FUNCTION getStudentAttendanceRate(
	forename VARCHAR(20),
    surname VARCHAR(20),
    course_name VARCHAR(20)
)
RETURNS INT(11)
DETERMINISTIC
BEGIN
	DECLARE studentLectureAttendanceRate DECIMAL;
	DECLARE amountOfAttendances INT;
    
    SET amountOfAttendances = (SELECT count(is_attending) FROM attendance_record ar
								JOIN lecture l ON ar.lecture_id = l.id
								JOIN course c ON l.course_id = c.id
								WHERE is_attending = 1 AND student_id = arg_student_id AND c.id = arg_course_id);
    
	SET studentLectureAttendanceRate = (SELECT count(*) FROM lecture l
										JOIN course c ON l.course_id = c.id
										WHERE c.id = arg_course_id)/amountOfAttendances;
	RETURN (studentLectureAttendanceRate);

END$$
