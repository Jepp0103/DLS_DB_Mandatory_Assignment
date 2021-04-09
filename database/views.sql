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