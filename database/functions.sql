
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
	DECLARE class VARCHAR(100);
    
    set @classname =(select class.name from student join class on student.class_faculty_id=class.faculty_id and student.class_name=class.name where student.email_address=arg_student_id);

    
    
    SET amountOfAttendances = (SELECT count(is_attending) FROM attendance_record ar
								JOIN lecture l ON ar.lecture_id = l.id
								JOIN course c ON l.course_id = c.id
								WHERE is_attending = 1 AND student_id = arg_student_id AND c.id like if(arg_course_id>0,arg_course_id,"%"));
    
	SET amountOfLecturesForCourse = (SELECT count(*) FROM lecture l
										JOIN course c ON l.course_id = c.id join class_lecture as cl on l.id = cl.lecture_id
										WHERE c.id like if(arg_course_id>0,arg_course_id,"%") and cl.class_id=@classname);
    
	SET studentLectureAttendanceRate = amountOfAttendances/amountOfLecturesForCourse*100;
                                        
	RETURN (CAST(studentLectureAttendanceRate AS DECIMAL));
END$$
