-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema roll_call_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema roll_call_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `roll_call_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `roll_call_db` ;

-- -----------------------------------------------------
-- Table `roll_call_db`.`network`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`network` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ssid` VARCHAR(45) NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`faculty` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `network_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_faculty_network1_idx` (`network_id` ASC),
  CONSTRAINT `fk_faculty_network`
    FOREIGN KEY (`network_id`)
    REFERENCES `roll_call_db`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`class` (
  `name` VARCHAR(45) NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`name`, `faculty_id`),
  INDEX `fk_faculty_id_idx` (`faculty_id` ASC),
  CONSTRAINT `fk_class_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `roll_call_db`.`faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`gps_coordinates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`gps_coordinates` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`student` (
  `email_address` VARCHAR(100) NOT NULL,
  `class_name` VARCHAR(45) NOT NULL,
  `class_faculty_id` INT UNSIGNED NOT NULL,
  `network_id` INT UNSIGNED NULL,
  `gps_id` INT UNSIGNED NULL,
  `forename` VARCHAR(45) BINARY NOT NULL,
  `surname` VARCHAR(45) BINARY NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  PRIMARY KEY (`email_address`),
  INDEX `fk_student_class1_idx` (`class_name` ASC, `class_faculty_id` ASC),
  INDEX `fk_student_network1_idx` (`network_id` ASC),
  INDEX `fk_student_gps_coordinates_idx` (`gps_id` ASC),
  CONSTRAINT `fk_student_class`
    FOREIGN KEY (`class_name` , `class_faculty_id`)
    REFERENCES `roll_call_db`.`class` (`name` , `faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_network`
    FOREIGN KEY (`network_id`)
    REFERENCES `roll_call_db`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_gps_coordinates`
    FOREIGN KEY (`gps_id`)
    REFERENCES `roll_call_db`.`gps_coordinates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`course` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `ects` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`city` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `zip_code` SMALLINT(4) UNSIGNED NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `city_id` INT UNSIGNED NOT NULL,
  `street_name` VARCHAR(45) NOT NULL,
  `street_number` INT NOT NULL,
  `registered_on` DATETIME NOT NULL,
  `additional_details` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_city_idx` (`city_id` ASC),
  CONSTRAINT `fk_address_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `roll_call_db`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`campus` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT UNSIGNED NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campus_faculty_idx` (`faculty_id` ASC),
  INDEX `fk_campus_address1_idx` (`address_id` ASC),
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


-- -----------------------------------------------------
-- Table `roll_call_db`.`classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`classroom` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus_id` INT UNSIGNED NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_classroom_campus_idx` (`campus_id` ASC),
  CONSTRAINT `fk_classroom_campus`
    FOREIGN KEY (`campus_id`)
    REFERENCES `roll_call_db`.`campus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`lecture` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_id` INT UNSIGNED NOT NULL,
  `classroom_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `time_start` TIME NOT NULL,
  `time_end` TIME NOT NULL,
  `time_zone` INT NOT NULL,
  `length` INT NOT NULL,
  `code` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lecture_course_idx` (`course_id` ASC),
  INDEX `fk_lecture_classroom1_idx` (`classroom_id` ASC),
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


-- -----------------------------------------------------
-- Table `roll_call_db`.`attendance_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`attendance_record` (
  `student_id` VARCHAR(100) NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  `is_attending` TINYINT NOT NULL,
  `registred_at` DATETIME NOT NULL,
  INDEX `fk_ar_student_idx` (`student_id` ASC),
  INDEX `fk_ar_lecture_idx` (`lecture_id` ASC),
  PRIMARY KEY (`student_id`, `lecture_id`),
  CONSTRAINT `fk_ar_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `roll_call_db`.`student` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ar_lecture`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `roll_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`teacher` (
  `email_address` VARCHAR(100) NOT NULL,
  `gps_coordinates_id` INT UNSIGNED NULL,
  `forename` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  PRIMARY KEY (`email_address`),
  INDEX `fk_teacher_gps_coordinates1_idx` (`gps_coordinates_id` ASC),
  CONSTRAINT `fk_teacher_gps_coordinates`
    FOREIGN KEY (`gps_coordinates_id`)
    REFERENCES `roll_call_db`.`gps_coordinates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`class_lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`class_lecture` (
  `class_id` VARCHAR(45) NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`class_id`, `lecture_id`),
  INDEX `fk_cl_lecture_idx` (`lecture_id` ASC),
  CONSTRAINT `fk_cl_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `roll_call_db`.`class` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cl_lecture`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `roll_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roll_call_db`.`teacher_has_lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `roll_call_db`.`teacher_has_lecture` (
  `teacher_email_address` VARCHAR(100) NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`teacher_email_address`, `lecture_id`),
  INDEX `fk_teacher_has_lecture_lecture1_idx` (`lecture_id` ASC),
  INDEX `fk_teacher_has_lecture_teacher1_idx` (`teacher_email_address` ASC),
  CONSTRAINT `fk_teacher_has_lecture_teacher1`
    FOREIGN KEY (`teacher_email_address`)
    REFERENCES `roll_call_db`.`teacher` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teacher_has_lecture_lecture1`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `roll_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- begin attached script 'test_data'
use roll_call_db;

INSERT INTO `city` (`zip_code`, `city_name`) VALUES ('2200', 'København N');
INSERT INTO `address` (`city_id`, `street_name`, `street_number`, `registered_on`, `additional_details`) VALUES ('1', 'Lygten', '16', '2021-02-23 20:02:21.550', 'Kea digital 2');
INSERT INTO `address` (`city_id`, `street_name`, `street_number`, `registered_on`, `additional_details`) VALUES ('1', 'Lygten', '37', '2021-02-23 20:02:21.550', 'Details');
INSERT INTO `network` (`ssid`, `ip_address`) VALUES ('KEANET', '193.29.107.196');
INSERT INTO `faculty` (`network_id`, `name`) VALUES ('1', 'KEA - Københavns Erhvervsakademi');

INSERT INTO `campus` (`address_id`, `faculty_id`, `name`) VALUES ('1', '1', 'Lygten 37');
INSERT INTO `campus` (`address_id`, `faculty_id`, `name`) VALUES ('2', '1', 'Lygten 16');

INSERT INTO `class` (`name`, `faculty_id`) VALUES ('SD21W1', '1');
INSERT INTO `class` (`name`, `faculty_id`) VALUES ('SD21W2', '1');

INSERT INTO `gps_coordinates` (`latitude`, `longitude`) VALUES ('55.70392118', '12.537521047');
INSERT INTO `gps_coordinates` (`latitude`, `longitude`) VALUES ('60.70392118', '22.537521047');
INSERT INTO `gps_coordinates` (`latitude`, `longitude`) VALUES ('34.70392118', '90.537521047');

INSERT INTO `gps_coordinates` (`latitude`, `longitude`) VALUES ('55.70392118', '12.537521047');
INSERT INTO `gps_coordinates` (`latitude`, `longitude`) VALUES ('60.70392118', '22.537521047');
INSERT INTO `gps_coordinates` (`latitude`, `longitude`) VALUES ('34.70392118', '90.537521047');

INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Abul@stud.kea.dk', 'SD21W1', '1', 'Abul', 'Kasem Mohammed Omar Sharif', '11111111');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Albert-Ioan@stud.kea.dk', 'SD21W1', '1', 'Albert-Ioan', 'Dánilá', '11111113');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Anders@stud.kea.dk', 'SD21W1', '1', 'Anders', 'Genderskov Binder', '11111114');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Andrian@stud.kea.dk', 'SD21W1', '1', 'Andrian', 'Bogdanov Vangelov', '11111116');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Bartosz@stud.kea.dk', 'SD21W1', '1', 'Bartosz', 'Baginski', '11111118');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Carl@stud.kea.dk', 'SD21W1', '1', 'Carl', 'Emil Lilholm Michelsen', '11111119');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Frederik@stud.kea.dk', 'SD21W1', '1', 'Frederik', 'Lundbeck Jørgensen', '11111125');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Gheorghita@stud.kea.dk', 'SD21W1', '1', 'Gheorghita', 'Amalia Caldare', '11111126');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Immanuel@stud.kea.dk', 'SD21W1', '1', 'Immanuel', 'Storm Lokzinsky', '11111129');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Jasper@stud.kea.dk', 'SD21W1', '1', 'Jasper', 'Windahl Andersen', '11111132');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Jeppe@stud.kea.dk', 'SD21W1', '1', 'Jeppe', 'Nannestad Dyekjær', '11111133');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Joachim@stud.kea.dk', 'SD21W1', '1', 'Joachim', 'Grubbe Frank', '11111135');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('John@stud.kea.dk', 'SD21W1', '1', 'John', 'Philip Coyne', '11111136');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Jonas@stud.kea.dk', 'SD21W1', '1', 'Jonas', 'Kofoed Hansen', '11111137');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Madalina-Andreea@stud.kea.dk', 'SD21W1', '1', 'Madalina-Andreea', 'Pascariu', '11111139');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Mads@stud.kea.dk', 'SD21W1', '1', 'Mads', 'Bjørk Ohmsen', '11111140');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Malgorzata@stud.kea.dk', 'SD21W1', '1', 'Malgorzata', 'Weronika Witkowska', '11111141');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Maria@stud.kea.dk', 'SD21W1', '1', 'Maria', 'Zdravkova Ilieva', '11111142');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Matús@stud.kea.dk', 'SD21W1', '1', 'Matús', 'Kalanin', '11111143');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Oliver@stud.kea.dk', 'SD21W1', '1', 'Oliver', 'Levin Dehnfjeld', '11111145');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Plamena@stud.kea.dk', 'SD21W1', '1', 'Plamena', 'Plamenova Stefanova', '11111146');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Said@stud.kea.dk', 'SD21W1', '1', 'Said', 'Alisic', '11111147');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Tamas@stud.kea.dk', 'SD21W1', '1', 'Tamas', 'Majszlinger', '11111150');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Théo@stud.kea.dk', 'SD21W1', '1', 'Théo', 'Mathieu Maillard', '11111151');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Wajid@stud.kea.dk', 'SD21W1', '1', 'Wajid', 'Ahmad', '11111154');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Yewon@stud.kea.dk', 'SD21W1', '1', 'Yewon', 'Seo', '11111155');

INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Aisha@stud.kea.dk', 'SD21W2', '1', 'Aisha', 'Abdikadir Noor Rooble', '11111155');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Alexander@stud.kea.dk', 'SD21W2', '1', 'Alexander', 'Jørgensen', '11111156');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Alin@stud.kea.dk', 'SD21W2', '1', 'Alin', 'Plamadeala', '11111157');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Alper@stud.kea.dk', 'SD21W2', '1', 'Alper', 'Altay', '11111158');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Andreas@stud.kea.dk', 'SD21W2', '1', 'Andreas', 'Dan Petersen', '11111159');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Anton@stud.kea.dk', 'SD21W2', '1', 'Anton', 'Hulbæk Haastrup', '11111160');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('August@stud.kea.dk', 'SD21W2', '1', 'August', 'Hejberg', '11111161');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Bénédict@stud.kea.dk', 'SD21W2', '1', 'Bénédict', 'Paul J Marien', '11111162');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Botond@stud.kea.dk', 'SD21W2', '1', 'Botond', 'Zoltan Horvath', '11111163');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Cristina@stud.kea.dk', 'SD21W2', '1', 'Cristina', 'Doroftei', '11111164');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Gheorghe@stud.kea.dk', 'SD21W2', '1', 'Gheorghe', 'Marian Mocanu', '11111165');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Jacob@stud.kea.dk', 'SD21W2', '1', 'Jacob', 'Ibrahem Jabr', '11111166');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Krisztian@stud.kea.dk', 'SD21W2', '1', 'Krisztian', 'Szabo', '11111167');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Mads2@stud.kea.dk', 'SD21W2', '1', 'Mads', 'Rune Frederiksen', '11111168');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Mathias@stud.kea.dk', 'SD21W2', '1', 'Mathias', 'Møller Feldt', '11111169');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Max@stud.kea.dk', 'SD21W2', '1', 'Max', 'Michael Campbell', '11111170');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Oliver2@stud.kea.dk', 'SD21W2', '1', 'Oliver', 'Kramer Petersen', '11111171');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Osvald@stud.kea.dk', 'SD21W2', '1', 'Osvald', 'Fernández Vega Minddal', '11111172');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Pedro@stud.kea.dk', 'SD21W2', '1', 'Pedro', 'Miguel Cravide Palma', '11111173');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Radu-Mihai@stud.kea.dk', 'SD21W2', '1', 'Radu-Mihai', 'Onescu', '11111174');
INSERT INTO `student` (`email_address`, `class_name`, `class_faculty_id`, `forename`, `surname`, `phone_number`) VALUES ('Stefani@stud.kea.dk', 'SD21W2', '1', 'Stefani', 'Dimitrova Dimitrova', '11111175');
INSERT INTO `teacher` (`email_address`, `forename`, `surname`, `phone_number`) VALUES ('Tomas@kea.dk', 'Tomas', 'Pesek', '22222222');
INSERT INTO `teacher` (`email_address`, `forename`, `surname`, `phone_number`) VALUES ('Andrea@kea.dk', 'Andrea', 'Corradini', '44444444');
INSERT INTO `teacher` (`email_address`, `forename`, `surname`, `phone_number`) VALUES ('Morten@kea.dk', 'Morten', 'Christiansen', '77777777');
INSERT INTO `classroom` (`campus_id`, `name`) VALUES ('1', 'B235');
INSERT INTO `classroom` (`campus_id`, `name`) VALUES ('1', 'B219 ');
INSERT INTO `course` (`name`, `ects`) VALUES ('Databases for developers', '10');
INSERT INTO `course` (`name`, `ects`) VALUES ('Testing', '10');
INSERT INTO `course` (`name`, `ects`) VALUES ('Development of large systems', '10');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '1', 'DB lecture', '2021-03-15 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_has_lecture` (`teacher_email_address`, `lecture_id`) VALUES ('Tomas@kea.dk', '1');
INSERT INTO `class_lecture` (`class_id`, `lecture_id`) VALUES ('SD21W1', '1');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Abul@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Albert-Ioan@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Anders@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Andrian@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Bartosz@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Carl@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Frederik@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Gheorghita@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Immanuel@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jasper@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jeppe@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Joachim@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('John@stud.kea.dk', 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jonas@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Madalina-Andreea@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Mads@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Malgorzata@stud.kea.dk', 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Maria@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Matús@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Oliver@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Plamena@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Said@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Tamas@stud.kea.dk', 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Théo@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Wajid@stud.kea.dk', 1, 0, '2021-03-15 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Yewon@stud.kea.dk', 1, 1, '2021-03-15 08:25:00');

INSERT INTO `lecture` (`course_id`, `classroom_id`, `name`, `date`, `time_start`, `time_end`, `time_zone`, `length`) VALUES ('1', '2', 'DB lecture 2', '2021-03-17 08:15:00', '08:15:00', '13:30:00', '0', '0');
INSERT INTO `teacher_has_lecture` (`teacher_email_address`, `lecture_id`) VALUES ('Tomas@kea.dk', '2');
INSERT INTO `class_lecture` (`class_id`, `lecture_id`) VALUES ('SD21W2', '2');

INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Aisha@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Alexander@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Alin@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Alper@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Andreas@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Anton@stud.kea.dk', 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('August@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Bénédict@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Botond@stud.kea.dk', 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Cristina@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Gheorghe@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Jacob@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Krisztian@stud.kea.dk', 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Mads2@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Mathias@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Max@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Oliver2@stud.kea.dk', 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Osvald@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Pedro@stud.kea.dk', 2, 0, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Radu-Mihai@stud.kea.dk', 2, 1, '2021-03-17 08:25:00');
INSERT INTO `attendance_record` (`student_id`, `lecture_id`, `is_attending`, `registred_at`) VALUES ('Stefani@stud.kea.dk', 2, 0, '2021-03-17 08:25:00');

-- end attached script 'test_data'