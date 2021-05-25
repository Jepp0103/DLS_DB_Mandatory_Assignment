-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema roll_call_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema roll_call_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `roll_call_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
SHOW WARNINGS;
USE `roll_call_db` ;

-- -----------------------------------------------------
-- Table `roll_call_db`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`faculty` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`network`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`network` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ssid` VARCHAR(45) NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_network_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_network_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `roll_call_db`.`faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`gps_coordinates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`gps_coordinates` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  `range` DECIMAL(6,5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`class` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_faculty_id_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `roll_call_db`.`faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`student` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_id` INT UNSIGNED NOT NULL,
  `network_id` INT UNSIGNED NULL,
  `gps_coordinates_id` INT UNSIGNED NULL,
  `forename` VARCHAR(45) BINARY NOT NULL,
  `surname` VARCHAR(45) BINARY NOT NULL,
  `email_address` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_student_network1_idx` (`network_id` ASC) VISIBLE,
  INDEX `fk_student_gps_coordinates_idx` (`gps_coordinates_id` ASC) VISIBLE,
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  INDEX `fk_student_class1_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_network`
    FOREIGN KEY (`network_id`)
    REFERENCES `roll_call_db`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_gps_coordinates`
    FOREIGN KEY (`gps_coordinates_id`)
    REFERENCES `roll_call_db`.`gps_coordinates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `roll_call_db`.`class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`course` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `ects` SMALLINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`city` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `zip_code` SMALLINT(4) UNSIGNED NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `city_id` INT UNSIGNED NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `street_number` INT NOT NULL,
  `registered_on` DATETIME(3) NOT NULL,
  `additional_details` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_city_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_address_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `roll_call_db`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`campus` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT UNSIGNED NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campus_faculty_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_campus_address1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_campus_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `roll_call_db`.`faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campus_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `roll_call_db`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`classroom` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus_id` INT UNSIGNED NULL,
  `name` VARCHAR(45) NOT NULL,
  `is_available` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_classroom_campus_idx` (`campus_id` ASC) VISIBLE,
  CONSTRAINT `fk_classroom_campus`
    FOREIGN KEY (`campus_id`)
    REFERENCES `roll_call_db`.`campus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`lecture` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` INT UNSIGNED NOT NULL,
  `classroom_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date` DATETIME(3) NOT NULL,
  `time_start` TIME NOT NULL,
  `time_end` TIME NOT NULL,
  `time_zone` INT NOT NULL,
  `length` INT NOT NULL,
  `code` VARCHAR(45) NULL,
  `registration_deadline` DATETIME(3) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lecture_course_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_lecture_classroom1_idx` (`classroom_id` ASC) VISIBLE,
  CONSTRAINT `fk_lecture_course`
    FOREIGN KEY (`course_id`)
    REFERENCES `roll_call_db`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lecture_classroom`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `roll_call_db`.`classroom` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`attendance_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`attendance_record` (
  `student_id` INT UNSIGNED NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  `is_attending` TINYINT NOT NULL,
  `registred_at` DATETIME(3) NOT NULL,
  INDEX `fk_ar_lecture_idx` (`lecture_id` ASC) VISIBLE,
  PRIMARY KEY (`student_id`, `lecture_id`),
  CONSTRAINT `fk_ar_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `roll_call_db`.`student` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ar_lecture`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `roll_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`teacher` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gps_coordinates_id` INT UNSIGNED NULL,
  `forename` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  INDEX `fk_teacher_gps_coordinates1_idx` (`gps_coordinates_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_gps_coordinates`
    FOREIGN KEY (`gps_coordinates_id`)
    REFERENCES `roll_call_db`.`gps_coordinates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`teacher_lectures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`teacher_lectures` (
  `teacher_id` INT UNSIGNED NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`teacher_id`, `lecture_id`),
  INDEX `fk_teacher_has_lecture_lecture1_idx` (`lecture_id` ASC) VISIBLE,
  INDEX `fk_teacher_has_lecture_teacher1_idx` (`teacher_id` ASC) VISIBLE,
  CONSTRAINT `fk_teacher_has_lecture_teacher1`
    FOREIGN KEY (`teacher_id`)
    REFERENCES `roll_call_db`.`teacher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_has_lecture_lecture1`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `roll_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `roll_call_db`.`class_lectures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`class_lectures` (
  `class_id` INT UNSIGNED NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`class_id`, `lecture_id`),
  INDEX `fk_class_has_lecture_lecture1_idx` (`lecture_id` ASC) VISIBLE,
  INDEX `fk_class_has_lecture_class1_idx` (`class_id` ASC) VISIBLE,
  CONSTRAINT `fk_class_has_lecture_class1`
    FOREIGN KEY (`class_id`)
    REFERENCES `roll_call_db`.`class` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_class_has_lecture_lecture1`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `roll_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
USE `roll_call_db` ;

-- -----------------------------------------------------
-- Placeholder table for view `roll_call_db`.`get_gps_coordinates_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`get_gps_coordinates_student` (`latitude` INT, `longitude` INT, `student` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `roll_call_db`.`get_gps_coordinates_teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`get_gps_coordinates_teacher` (`latitude` INT, `longitude` INT, `teacher` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure get_average_class_attendance_rate
-- -----------------------------------------------------

DELIMITER $$
USE `roll_call_db`$$
CREATE PROCEDURE get_average_class_attendance_rate(
    course_id_arg INT,
	class_id_arg INT
)
BEGIN 
	SELECT AVG(getStudentLectureAttendanceRate(student.id, course_id_arg)) AS class_attendance_rate
    FROM student
    WHERE class_id = class_id_arg;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure register_student_gps
-- -----------------------------------------------------

DELIMITER $$
USE `roll_call_db`$$
#A stored procedure, which will insert network and GPS records for a student (or only GPS for a teacher), 
#once they are successfully retrieved from the front-end, 
#a request will be sent to the back-end and the back-end 
#will call this stored procedure providing the correct parameters. 
#What could be returned is if the student is within the range of the 
#teacher’s registered GPS coordinates.
CREATE PROCEDURE register_student_gps(
	IN student_id INT,
    IN teacher_id INT,
    IN student_latitude DECIMAL(10,8),
    IN student_longitude DECIMAL(11,8),
	OUT within_range CHAR(1)
)
BEGIN 
	#DECLARE added_gps_id INT;
    DECLARE teacher_latitude DECIMAL(10,8);
    DECLARE teacher_longitude DECIMAL(11,8);
    DECLARE lat_deg_dist DECIMAL(10,3);
    DECLARE long_deg_dist DECIMAL(8,3);
    DECLARE teacher_gps_coordinates_id INT;
    
    SET teacher_gps_coordinates_id = (SELECT gps_coordinates_id FROM teacher t
											WHERE t.id = teacher_id);

	#Getting latitude and longitude values for a teacher.
	SET teacher_latitude = (SELECT latitude FROM gps_coordinates gc
								JOIN teacher t ON gc.id = t.gps_coordinates_id
								WHERE t.id = teacher_id);
						   
	SET teacher_longitude = (SELECT longitude FROM gps_coordinates gc
								JOIN teacher t ON gc.id = t.gps_coordinates_id
								WHERE t.id = teacher_id);
   
	#Source for calculating distance - https://www.usgs.gov/faqs/how-much-distance-does-a-degree-minute-and-second-cover-your-maps?qt-news_science_products=0#qt-news_science_products
	SET lat_deg_dist = 111033.736; #Distance for one latitude degree in meters
	SET long_deg_dist = 87870.182; #Distance for one longitude degree in meters
	
	#Comparing gps values for teacher and student meter distance and returning within range value. 
	IF  (teacher_latitude = student_latitude AND teacher_longitude = student_longitude) #When student gps values are equal to teacher gps values
	THEN
		CALL update_student_gps(student_id, teacher_gps_coordinates_id);
		SELECT 'y' INTO within_range;
		
	ELSEIF (teacher_latitude > student_latitude OR teacher_longitude > student_longitude) #When gps values are higher for a teacher than a student but still within 9.99999 meters range
		AND ((teacher_latitude * lat_deg_dist) - (student_latitude * lat_deg_dist)) <= 9.99999 
		AND ((teacher_longitude * long_deg_dist) - (student_longitude * long_deg_dist)) <= 9.99999
	THEN
		CALL update_student_gps(student_id, teacher_gps_coordinates_id);
		SELECT 'y' INTO within_range;
		
	ELSEIF (student_latitude > teacher_latitude OR student_longitude > teacher_longitude) #When gps values are higher for a student than a teacher but still within 9.99999 meters range 
	AND ((student_latitude * lat_deg_dist) - (teacher_latitude * lat_deg_dist)) <= 9.99999 
	AND ((student_longitude * long_deg_dist) - (teacher_longitude * long_deg_dist)) <= 9.99999 
	THEN
		CALL update_student_gps(student_id, teacher_gps_coordinates_id);
		SELECT 'y' INTO within_range;
	ELSE 
		SELECT 'n' INTO within_range; 
	END IF;   

END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- function getStudentLectureAttendanceRate
-- -----------------------------------------------------

DELIMITER $$
USE `roll_call_db`$$
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

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- function getLectureParticipationRate
-- -----------------------------------------------------

DELIMITER $$
USE `roll_call_db`$$
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
    
	SET amountOfTotalAttendances = (select count(*) from student where class_id IN (SELECT class_id FROM class_lectures where lecture_id=lecture_id_arg));

	SET lectureParticipationRate = amountOfParticipators/amountOfTotalAttendances*100;
                                        
	RETURN (lectureParticipationRate);
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure update_student_gps
-- -----------------------------------------------------

DELIMITER $$
USE `roll_call_db`$$
CREATE PROCEDURE update_student_gps(
	student_id INT,
    teacher_gps_coordinates_id INT
)
BEGIN
	UPDATE student 
		SET 
			gps_coordinates_id = teacher_gps_coordinates_id
		WHERE
			id = student_id;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- procedure register_student_network
-- -----------------------------------------------------

DELIMITER $$
USE `roll_call_db`$$
CREATE PROCEDURE register_student_network(
	IN student_id INT,
    IN student_ip_address VARCHAR(45), 
    IN teaching_network_id INT, #Network id teaching is taking place.
	OUT is_connected CHAR(1)
)
BEGIN 
	#DECLARE added_student_network_id INT;
    DECLARE teaching_ip_address VARCHAR(45);

    SET teaching_ip_address = (SELECT ip_address FROM network 
										WHERE id = teaching_network_id);
                                        

	#Validating network of a student compared to a network where teaching is taking place
    IF (student_ip_address = teaching_ip_address ) 
	THEN 
		#Updating student with the inserted network
		UPDATE student 
			SET 
				network_id = teaching_network_id 
			WHERE 
				id = student_id;
                
		SELECT 'y' INTO is_connected;
	ELSE 
		SELECT 'n' INTO is_connected;
	END IF;
END$$

DELIMITER ;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `roll_call_db`.`get_gps_coordinates_student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roll_call_db`.`get_gps_coordinates_student`;
SHOW WARNINGS;
USE `roll_call_db`;
CREATE OR REPLACE VIEW `get_gps_coordinates_student` AS
SELECT latitude, longitude, concat(s.forename, " ", s.surname) as student
FROM gps_coordinates g
    JOIN student s ON g.id = s.gps_coordinates_id;
SELECT * FROM `get_gps_coordinates_student`;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `roll_call_db`.`get_gps_coordinates_teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roll_call_db`.`get_gps_coordinates_teacher`;
SHOW WARNINGS;
USE `roll_call_db`;
CREATE OR REPLACE VIEW `get_gps_coordinates_teacher` AS
SELECT latitude, longitude, concat(t.forename, " ", t.surname) as teacher
FROM gps_coordinates g
    JOIN teacher t ON g.id = t.gps_coordinates_id;
SHOW WARNINGS;
USE `roll_call_db`;

DELIMITER $$
SHOW WARNINGS$$
USE `roll_call_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `roll_call_db`.`student_BEFORE_INSERT` BEFORE INSERT ON `student` FOR EACH ROW
BEGIN
	SET NEW.email_address = LOWER(NEW.email_address);
END$$

SHOW WARNINGS$$

DELIMITER ;
CREATE USER 'manager' IDENTIFIED BY 'password';

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE `roll_call_db`.`classroom` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`faculty` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`teacher` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`city` TO 'manager';
GRANT SELECT, INSERT, DELETE, UPDATE ON TABLE `roll_call_db`.`class` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`teacher_lectures` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`lecture` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`class_lectures` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`address` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`network` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`campus` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`student` TO 'manager';
SHOW WARNINGS;
CREATE USER 'mainuser' IDENTIFIED BY 'password';

GRANT SELECT ON TABLE `roll_call_db`.`address` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`class` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`class_lectures` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`classroom` TO 'mainuser';
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE `roll_call_db`.`attendance_record` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`campus` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`course` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`city` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`faculty` TO 'mainuser';
GRANT SELECT, UPDATE ON TABLE `roll_call_db`.`lecture` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`network` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`student` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`teacher` TO 'mainuser';
GRANT INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`gps_coordinates` TO 'mainuser';
GRANT SELECT ON TABLE `roll_call_db`.`teacher_lectures` TO 'mainuser';
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'security_setup.sql'
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `student_id` int unsigned DEFAULT NULL,
  `teacher_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `teacher_id_UNIQUE` (`teacher_id`),
  KEY `fk_individual_student` (`student_id`),
  CONSTRAINT `fk_individual_student` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`),
  CONSTRAINT `fk_individual_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `authorities` (
  `username` varchar(50) NOT NULL,
  `authority` varchar(50) NOT NULL,
  KEY `fk_authorities_users` (`username`),
  CONSTRAINT `fk_authorities_users` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`users` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`authorities` TO 'manager';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`users` TO 'mainuser';
GRANT DELETE, INSERT, SELECT, UPDATE ON TABLE `roll_call_db`.`authorities` TO 'mainuser';

DROP TRIGGER IF EXISTS `roll_call_db`.`teacher_AFTER_INSERT`;

DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `teacher_AFTER_INSERT` AFTER INSERT ON `teacher` FOR EACH ROW BEGIN
INSERT INTO `roll_call_db`.`users` (`username`, `password`, `enabled`,`teacher_id`) VALUES (new.email_address, '$2a$10$hGko1F1s45iCEpzioDvQiuui6QabjjA4ob8y3AIvSk8Ocv5Jg.hWK.hWK', '1',NEW.id);
INSERT INTO `roll_call_db`.`authorities` (`username`, `authority`) VALUES (new.email_address, 'ROLE_TEACHER');

END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `roll_call_db`.`student_AFTER_INSERT`;

DELIMITER $$
CREATE DEFINER=CURRENT_USER TRIGGER `student_AFTER_INSERT` AFTER INSERT ON `student` FOR EACH ROW BEGIN
INSERT INTO `roll_call_db`.`users` (`username`, `password`, `enabled`,`student_id`) VALUES (new.email_address, '$2a$10$hGko1F1s45iCEpzioDvQiuui6QabjjA4ob8y3AIvSk8Ocv5Jg.hWK', '1',NEW.id);
INSERT INTO `roll_call_db`.`authorities` (`username`, `authority`) VALUES (new.email_address, 'ROLE_STUDENT');

END$$
DELIMITER ;


-- end attached script 'security_setup.sql'
-- begin attached script 'test_data'
INSERT INTO `city` (`zip_code`, `city_name`) VALUES ('2200', 'København N');
INSERT INTO `address` (`city_id`, `street_name`, `street_number`, `registered_on`, `additional_details`) VALUES ('1', 'Lygten', '16', '2021-02-23 20:02:21.550', 'Kea digital 2');
INSERT INTO `address` (`city_id`, `street_name`, `street_number`, `registered_on`, `additional_details`) VALUES ('1', 'Lygten', '37', '2021-02-23 20:02:21.550', 'Details');
INSERT INTO `faculty` (`name`) VALUES ('KEA - Københavns Erhvervsakademi');
INSERT INTO `faculty` (`name`) VALUES ('KU - Københavns Universitet');
INSERT INTO `faculty` (`name`) VALUES ('DTU - Danmarks Tekniske Universitet');
INSERT INTO `faculty` (`name`) VALUES ('CBS - Copenhagen Business School');

INSERT INTO `network` (`faculty_id`, `ssid`, `ip_address`) VALUES (1, 'KEANET', '193.29.107.196');
INSERT INTO `network` (`faculty_id`, `ssid`, `ip_address`) VALUES (2, 'KU NET', '193.29.108.197');
INSERT INTO `network` (`faculty_id`, `ssid`, `ip_address`) VALUES (3, 'DTU NET', '193.29.109.198');
INSERT INTO `network` (`faculty_id`, `ssid`, `ip_address`) VALUES (4, 'CBS NET', '193.29.103.199');


INSERT INTO `campus` (`address_id`, `faculty_id`, `name`) VALUES ('1', '1', 'Lygten 37');
INSERT INTO `campus` (`address_id`, `faculty_id`, `name`) VALUES ('2', '1', 'Lygten 16');

INSERT INTO `class` (`name`, `faculty_id`) VALUES ('SD21w1', '1');
INSERT INTO `class` (`name`, `faculty_id`) VALUES ('SD21w2', '1');

INSERT INTO `gps_coordinates` (`latitude`, `longitude`, `range`) VALUES ('55.70392118', '12.537521047',7.55555);
INSERT INTO `gps_coordinates` (`latitude`, `longitude`, `range`) VALUES ('60.70392118', '22.537521047',7.55555);
INSERT INTO `gps_coordinates` (`latitude`, `longitude`, `range`) VALUES ('34.70392118', '90.537521047',7.55555);

#Test data for coordinates student views
INSERT INTO `student` (`email_address`, `class_id`,  `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Karl@stud.kea.dk', 1, 1, 'Karl', 'Johnson', '11111121');
INSERT INTO `student` (`email_address`, `class_id`,  `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Line@stud.kea.dk', 1, 2, 'Line', 'Sørensen', '11111123');
INSERT INTO `student` (`email_address`, `class_id`,  `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Magnus@stud.kea.dk', 1, 2, 'Magnus', 'Andersen', '11111124');
INSERT INTO `student` (`email_address`, `class_id`,  `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Martinj@stud.kea.dk', 2, 3, 'Martin', 'Jorgensen', '11111126');
INSERT INTO `student` (`email_address`, `class_id`,  `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Cecilie@stud.kea.dk', 2, 2, 'Cecilie', 'Christensen', '11111128');
INSERT INTO `student` (`email_address`, `class_id`,  `gps_coordinates_id`, `forename`, `surname`, `phone_number`) VALUES ('Ole@stud.kea.dk', 1, 3, 'Ole', 'Olsen', '11111129');


INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Abul@stud.kea.dk', '1', 'Abul', 'Kasem Mohammed Omar Sharif', '11111111');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Albert-Ioan@stud.kea.dk', '1', 'Albert-Ioan', 'Dánilá', '11111113');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Anders@stud.kea.dk', '1', 'Anders', 'Genderskov Binder', '11111114');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Andrian@stud.kea.dk', '1', 'Andrian', 'Bogdanov Vangelov', '11111116');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Bartosz@stud.kea.dk', '1', 'Bartosz', 'Baginski', '11111118');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Carl@stud.kea.dk', '1', 'Carl', 'Emil Lilholm Michelsen', '11111119');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Frederik@stud.kea.dk', '1', 'Frederik', 'Lundbeck Jørgensen', '11111125');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Gheorghita@stud.kea.dk', '1', 'Gheorghita', 'Amalia Caldare', '11111126');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Immanuel@stud.kea.dk', '1', 'Immanuel', 'Storm Lokzinsky', '11111129');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Jasper@stud.kea.dk', '1', 'Jasper', 'Windahl Andersen', '11111132');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Jeppe@stud.kea.dk', '1', 'Jeppe', 'Nannestad Dyekjær', '11111133');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Joachim@stud.kea.dk', '1', 'Joachim', 'Grubbe Frank', '11111135');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('John@stud.kea.dk', '1', 'John', 'Philip Coyne', '11111136');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Jonas@stud.kea.dk', '1', 'Jonas', 'Kofoed Hansen', '11111137');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Madalina-Andreea@stud.kea.dk', '1', 'Madalina-Andreea', 'Pascariu', '11111139');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Mads@stud.kea.dk', '1', 'Mads', 'Bjørk Ohmsen', '11111140');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Malgorzata@stud.kea.dk', '1', 'Malgorzata', 'Weronika Witkowska', '11111141');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Maria@stud.kea.dk', '1', 'Maria', 'Zdravkova Ilieva', '11111142');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Matús@stud.kea.dk', '1', 'Matús', 'Kalanin', '11111143');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Oliver@stud.kea.dk', '1', 'Oliver', 'Levin Dehnfjeld', '11111145');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Plamena@stud.kea.dk', '1', 'Plamena', 'Plamenova Stefanova', '11111146');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Said@stud.kea.dk', '1', 'Said', 'Alisic', '11111147');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Tamas@stud.kea.dk', '1', 'Tamas', 'Majszlinger', '11111150');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Théo@stud.kea.dk', '1', 'Théo', 'Mathieu Maillard', '11111151');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Wajid@stud.kea.dk', '1', 'Wajid', 'Ahmad', '11111154');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Yewon@stud.kea.dk', '1', 'Yewon', 'Seo', '11111155');

INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Aisha@stud.kea.dk', '2', 'Aisha', 'Abdikadir Noor Rooble', '11111155');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Alexander@stud.kea.dk', '2', 'Alexander', 'Jørgensen', '11111156');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Alin@stud.kea.dk', '2', 'Alin', 'Plamadeala', '11111157');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Alper@stud.kea.dk', '2', 'Alper', 'Altay', '11111158');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Andreas@stud.kea.dk', '2', 'Andreas', 'Dan Petersen', '11111159');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Anton@stud.kea.dk', '2', 'Anton', 'Hulbæk Haastrup', '11111160');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('August@stud.kea.dk', '2', 'August', 'Hejberg', '11111161');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Bénédict@stud.kea.dk', '2', 'Bénédict', 'Paul J Marien', '11111162');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Botond@stud.kea.dk', '2', 'Botond', 'Zoltan Horvath', '11111163');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Cristina@stud.kea.dk', '2', 'Cristina', 'Doroftei', '11111164');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Gheorghe@stud.kea.dk', '2', 'Gheorghe', 'Marian Mocanu', '11111165');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Jacob@stud.kea.dk', '2', 'Jacob', 'Ibrahem Jabr', '11111166');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Krisztian@stud.kea.dk', '2', 'Krisztian', 'Szabo', '11111167');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Mads2@stud.kea.dk', '2', 'Mads', 'Rune Frederiksen', '11111168');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Mathias@stud.kea.dk', '2', 'Mathias', 'Møller Feldt', '11111169');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Max@stud.kea.dk', '2', 'Max', 'Michael Campbell', '11111170');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Oliver2@stud.kea.dk', '2', 'Oliver', 'Kramer Petersen', '11111171');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Osvald@stud.kea.dk', '2', 'Osvald', 'Fernández Vega Minddal', '11111172');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Pedro@stud.kea.dk', '2', 'Pedro', 'Miguel Cravide Palma', '11111173');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Radu-Mihai@stud.kea.dk', '2', 'Radu-Mihai', 'Onescu', '11111174');
INSERT INTO `student` (`email_address`, `class_id`, `forename`, `surname`, `phone_number`) VALUES ('Stefani@stud.kea.dk', '2', 'Stefani', 'Dimitrova Dimitrova', '11111175');

INSERT INTO `teacher` (`email_address`, `forename`, `surname`, `phone_number`,`gps_coordinates_id`) VALUES ('Tomas@kea.dk', 'Tomas', 'Pesek', '22222222',1);
INSERT INTO `teacher` (`email_address`, `forename`, `surname`, `phone_number`,`gps_coordinates_id`) VALUES ('Morten@kea.dk', 'Morten', 'Christiansen', '77777777',2);
INSERT INTO `teacher` (`email_address`, `forename`, `surname`, `phone_number`,`gps_coordinates_id`) VALUES ('Andrea@kea.dk', 'Andrea', 'Corradini', '44444444',3);

INSERT INTO `classroom` (`campus_id`, `is_available`, `name`) VALUES ('1', 1, 'B235');
INSERT INTO `classroom` (`campus_id`, `is_available`, `name`) VALUES ('1', 1, 'B219 ');

INSERT INTO `course` (`name`, `ects`) VALUES ('Databases for developers', '10');
INSERT INTO `course` (`name`, `ects`) VALUES ('Testing', '10');
INSERT INTO `course` (`name`, `ects`) VALUES ('Development of large systems', '10');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '1', 'DB lecture', '2021-03-15 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_lectures` (`teacher_id`, `lecture_id`) VALUES (1, '1');
INSERT INTO `class_lectures` (`class_id`, `lecture_id`) VALUES ('1', '1');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (1, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (2, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (3, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (4, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (5, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (6, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (7, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (8, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (9, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (10, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (11, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (12, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (13, 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (14, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (15, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (16, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (17, 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (18, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (19, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (20, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (21, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (22, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (23, 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (24, 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (25, 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (26, 1, 1, '2021-03-15 08:25:00');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '2', 'DB lecture 2', '2021-03-17 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_lectures` (`teacher_id`, `lecture_id`) VALUES (1, '2');
INSERT INTO `class_lectures` (`class_id`, `lecture_id`) VALUES ('2', '2');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (27, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (28, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (29, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (30, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (31, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (32, 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (33, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (34, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (35, 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (36, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (37, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (38, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (39, 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (40, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (41, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (42, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (43, 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (44, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (45, 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (46, 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (47, 2, 0, '2021-03-17 08:25:00');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('2', '1', 'test lecture', '2021-03-18 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_lectures` (`teacher_id`, `lecture_id`) VALUES (2, '3');
INSERT INTO `class_lectures` (`class_id`, `lecture_id`) VALUES ('1', '3');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (1, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (2, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (3, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (4, 3, 0, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (5, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (6, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (7, 3, 0, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (8, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (9, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (10, 3, 0, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (11, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (12, 3, 0, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (13, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (14, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (15, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (16, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (17, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (18, 3, 0, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (19, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (20, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (21, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (22, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (23, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (24, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (25, 3, 1, '2021-03-18 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (26, 3, 1, '2021-03-18 08:25:00');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('2', '2', 'test lecture2', '2021-03-16 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_lectures` (`teacher_id`, `lecture_id`) VALUES (2, '4');
INSERT INTO `class_lectures` (`class_id`, `lecture_id`) VALUES ('2', '4');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (27, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (28, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (29, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (30, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (31, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (32, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (33, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (34, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (35, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (36, 4, 0, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (37, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (38, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (39, 4,01, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (40, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (41, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (42, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (43, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (44, 4, 0, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (45, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (46, 4, 1, '2021-03-16 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (47, 4, 1, '2021-03-16 08:25:00');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('3', '1', 'DLS lecture', '2021-03-19 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_lectures` (`teacher_id`, `lecture_id`) VALUES (3, '5');
INSERT INTO `class_lectures` (`class_id`, `lecture_id`) VALUES ('1', '5');
INSERT INTO `class_lectures` (`class_id`, `lecture_id`) VALUES ('2', '5');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (1, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (2, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (3, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (4, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (5, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (6, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (7, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (8, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (9, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (10, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (11, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (12, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (13, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (14, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (15, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (16, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (17, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (18, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (19, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (20, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (21, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (22, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (23, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (24, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (25, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (26, 5, 1, '2021-03-19 08:25:00');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (27, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (28, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (29, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (30, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (31, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (32, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (33, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (34, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (35, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (36, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (37, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (38, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (39, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (40, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (41, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (42, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (43, 5, 0, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (44, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (45, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (46, 5, 1, '2021-03-19 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES (47, 5, 1, '2021-03-19 08:25:00');
-- end attached script 'test_data'
