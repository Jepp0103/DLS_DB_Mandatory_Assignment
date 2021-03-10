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
	DECLARE StudentAttendanceRate INT(11);
	SET StudentAttendanceRate = #what to do from here?


#COUNT(registred_at);
