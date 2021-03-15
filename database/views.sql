#Test data for coordinates students
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `gps_id`, `forename`, `surname`, `phone_number`) VALUES ('Carl@stud.kea.dk', 'SD21w1', '1', 1, 'Carl', 'Johnson', '11111121');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `gps_id`, `forename`, `surname`, `phone_number`) VALUES ('Line@stud.kea.dk', 'SD21w1', '1', 2, 'Line', 'Sørensen', '11111123');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `gps_id`, `forename`, `surname`, `phone_number`) VALUES ('Magnus@stud.kea.dk', 'SD21w1', '1', 2, 'Magnus', 'Andersen', '11111124');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `gps_id`, `forename`, `surname`, `phone_number`) VALUES ('Martinj@stud.kea.dk', 'SD21w1', '1', 3, 'Martin', 'Jorgensen', '11111126');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `gps_id`, `forename`, `surname`, `phone_number`) VALUES ('Cecilie@stud.kea.dk', 'SD21w1', '1', 2, 'Cecilie', 'Christensen', '11111128');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `gps_id`, `forename`, `surname`, `phone_number`) VALUES ('Ole@stud.kea.dk', 'SD21w1', '1', 3, 'Ole', 'Olsen', '11111129');

#Test data for teacher coordinates
INSERT INTO `teacher` (`email_address`, `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Ejner@kea.dk', 1, 'Ejner', 'Hansen', '22222292');
INSERT INTO `teacher` (`email_address`, `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Kaj@kea.dk', 2, 'Kaj', 'Sørensen', '44444434');
INSERT INTO `teacher` (`email_address`, `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Sven@kea.dk', 3, 'Sven', 'Olsen', '77777787');

CREATE OR REPLACE VIEW `get_gps_coordinates_student` AS
SELECT latitude, longitude, concat(s.forename, " ", s.surname) as student
FROM gps_coordinates g
    JOIN student s ON g.id = s.gps_id;
    
SELECT * FROM `get_gps_coordinates_student`;

CREATE OR REPLACE VIEW `get_gps_coordinates_teacher` AS
SELECT latitude, longitude, concat(t.forename, " ", t.surname) as teacher
FROM gps_coordinates g
    JOIN teacher t ON g.id = t.gps_coordinates_id;
    
SELECT * FROM `get_gps_coordinates_teacher`;


