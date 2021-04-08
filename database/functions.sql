#Attendance rate function
DROP FUNCTION IF EXISTS getStudentLectureAttendanceRate;
DELIMITER $$
CREATE FUNCTION getStudentLectureAttendanceRate(
	arg_student_id INT,
    arg_course_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE studentLectureAttendanceRate INT;
	DECLARE amountOfAttendances INT;
	DECLARE amountOfLecturesForCourse INT;
    
    SET @chosen_class_id = (SELECT c.id FROM student s                       
								JOIN class c on s.class_id = c.id                         
								WHERE s.id=arg_student_id);
    
    SET amountOfAttendances = (SELECT count(is_attending) FROM attendance_record ar
								JOIN lecture l ON ar.lecture_id = l.id
								JOIN course c ON l.course_id = c.id
								WHERE is_attending = 1 AND student_id = arg_student_id AND c.id LIKE IF(arg_course_id>0,arg_course_id,"%"));
    
	SET amountOfLecturesForCourse = (SELECT count(*) FROM lecture l
										JOIN course c ON l.course_id = c.id JOIN class_lectures AS cl ON l.id = cl.lecture_id
										WHERE c.id LIKE IF(arg_course_id>0,arg_course_id,"%") AND cl.class_id= @chosen_class_id);
    
	SET studentLectureAttendanceRate = amountOfAttendances/amountOfLecturesForCourse*100;
                                        
	RETURN (studentLectureAttendanceRate);
END$$



#Participation rate function
DROP FUNCTION IF EXISTS getLectureParticipationRate;
DELIMITER $$
CREATE FUNCTION getLectureParticipationRate(
    lecture_id_arg INT
)
RETURNS INT

DETERMINISTIC
BEGIN
	DECLARE lectureParticipationRate INT;
	DECLARE amountOfParticipators INT;
    DECLARE amountOfTotalAttendances INT;
    
    SET amountOfParticipators = (SELECT COUNT(*) FROM attendance_record ar
		JOIN lecture l on ar.lecture_id = l.id
        WHERE l.id = lecture_id_arg AND is_attending = 1);
    
	SET amountOfTotalAttendances = (SELECT COUNT(*) FROM attendance_record ar
		JOIN lecture l on ar.lecture_id = l.id
        WHERE l.id = lecture_id_arg);
    
	SET lectureParticipationRate = amountOfParticipators/amountOfTotalAttendances*100;
                                        
	RETURN (lectureParticipationRate);
END$$