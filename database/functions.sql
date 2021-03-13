#1. A function that takes a student and a course as arguments and gets the attendance rate 
#for that student and that course. If course is null then get the attendance rate for the 
#student across all lectures regardless of course.

#Test data for the function
#Adding extra lectures to attendance rate for function
INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '1', 'DB lecture', '2021-03-15 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '2', 'DB lecture 2', '2021-03-17 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '2', 'DB lecture 3', '2021-03-18 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '2', 'DB lecture 4', '2021-03-19 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '2', 'DB lecture 5', '2021-03-20 08:15:00', '08:15:00', '13:30:00', '0', '0');

#Extra attendances for Jeppe to test function
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 2, 1, '2021-04-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 3, 0, '2021-02-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 4, 0, '2021-01-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 8, 1, '2021-07-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 9, 0, '2021-07-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 10, 1, '2021-03-15 08:25:00');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 2, 0, '2021-04-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 3, 0, '2021-02-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 4, 0, '2021-01-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 8, 1, '2021-07-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 9, 0, '2021-07-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 10, 1, '2021-03-15 08:25:00');


SELECT * FROM attendance_record
	WHERE student_id = 'Jeppe@stud.kea.dk';

SELECT * FROM attendance_record
	WHERE student_id = 'Immanuel@stud.kea.dk';

SELECT * FROM lecture 
	WHERE course_id = 1;

#THE FUNCTION
DROP FUNCTION IF EXISTS getStudentLectureAttendanceRate;
DELIMITER $$
CREATE FUNCTION getStudentLectureAttendanceRate(
	arg_student_id VARCHAR(100),
    arg_course_id INT
)
RETURNS DECIMAL
DETERMINISTIC
BEGIN
	DECLARE studentLectureAttendanceRate DECIMAL;
	DECLARE amountOfAttendances INT;
	DECLARE amountOfLecturesForCourse INT;

    
    SET amountOfAttendances = (SELECT count(is_attending) FROM attendance_record ar
								JOIN lecture l ON ar.lecture_id = l.id
								JOIN course c ON l.course_id = c.id
								WHERE is_attending = 1 AND student_id = arg_student_id AND c.id = arg_course_id);
    
	SET amountOfLecturesForCourse = (SELECT count(*) FROM lecture l
										JOIN course c ON l.course_id = c.id
										WHERE c.id = arg_course_id);
    
	SET studentLectureAttendanceRate = amountOfAttendances/amountOfLecturesForCourse;
                                        
	RETURN (CAST(studentLectureAttendanceRate AS DECIMAL));
END$$


#TESTING THE FUNCTION
SELECT getStudentLectureAttendanceRate('Jeppe@stud.kea.dk', 1);  
SELECT getStudentLectureAttendanceRate('Immanuel@stud.kea.dk', 1); 
    
#-------------------------------------------------------------------------------
