-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema role_call_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema role_call_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `role_call_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `role_call_db` ;

-- -----------------------------------------------------
-- Table `role_call_db`.`network`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`network` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ssid` VARCHAR(45) NOT NULL,
  `ip_address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`faculty` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `network_id` INT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_faculty_network1_idx` (`network_id` ASC),
  CONSTRAINT `fk_faculty_network`
    FOREIGN KEY (`network_id`)
    REFERENCES `role_call_db`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`class`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`class` (
  `name` VARCHAR(45) NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`name`, `faculty_id`),
  INDEX `fk_faculty_id_idx` (`faculty_id` ASC),
  CONSTRAINT `fk_class_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `role_call_db`.`faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`gps_coordinates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`gps_coordinates` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `latitude` DECIMAL(10,8) NOT NULL,
  `longitude` DECIMAL(11,8) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`student` (
  `email_address` VARCHAR(100) NOT NULL,
  `class_name` VARCHAR(45) NOT NULL,
  `class_faculty_id` INT UNSIGNED NOT NULL,
  `network_id` INT UNSIGNED NULL,
  `gps_id` INT UNSIGNED NULL,
  `forename` VARCHAR(45) BINARY NOT NULL,
  `surename` VARCHAR(45) BINARY NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  PRIMARY KEY (`email_address`),
  INDEX `fk_student_class1_idx` (`class_name` ASC, `class_faculty_id` ASC),
  INDEX `fk_student_network1_idx` (`network_id` ASC),
  INDEX `fk_student_gps_coordinates_idx` (`gps_id` ASC),
  CONSTRAINT `fk_student_class`
    FOREIGN KEY (`class_name` , `class_faculty_id`)
    REFERENCES `role_call_db`.`class` (`name` , `faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_network`
    FOREIGN KEY (`network_id`)
    REFERENCES `role_call_db`.`network` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_gps_coordinates`
    FOREIGN KEY (`gps_id`)
    REFERENCES `role_call_db`.`gps_coordinates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`course` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `ects` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`city` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `zip_code` SMALLINT(4) UNSIGNED NOT NULL,
  `city_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`address` (
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
    REFERENCES `role_call_db`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`campus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`campus` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_id` INT UNSIGNED NOT NULL,
  `faculty_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_campus_faculty_idx` (`faculty_id` ASC),
  INDEX `fk_campus_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_campus_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `role_call_db`.`faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campus_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `role_call_db`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`classroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`classroom` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `campus_id` INT UNSIGNED NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_classroom_campus_idx` (`campus_id` ASC),
  CONSTRAINT `fk_classroom_campus`
    FOREIGN KEY (`campus_id`)
    REFERENCES `role_call_db`.`campus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`lecture` (
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
    REFERENCES `role_call_db`.`course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lecture_classroom`
    FOREIGN KEY (`classroom_id`)
    REFERENCES `role_call_db`.`classroom` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`attendance_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`attendance_record` (
  `student_id` VARCHAR(100) NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  `is_attending` TINYINT NOT NULL,
  `registred_at` DATETIME NOT NULL,
  INDEX `fk_ar_student_idx` (`student_id` ASC),
  INDEX `fk_ar_lecture_idx` (`lecture_id` ASC),
  PRIMARY KEY (`student_id`, `lecture_id`),
  CONSTRAINT `fk_ar_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `role_call_db`.`student` (`email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ar_lecture`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `role_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`teacher` (
  `email_address` VARCHAR(100) NOT NULL,
  `gps_coordinates_id` INT UNSIGNED NULL,
  `forename` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(10) NULL,
  PRIMARY KEY (`email_address`),
  INDEX `fk_teacher_gps_coordinates1_idx` (`gps_coordinates_id` ASC),
  CONSTRAINT `fk_teacher_gps_coordinates`
    FOREIGN KEY (`gps_coordinates_id`)
    REFERENCES `role_call_db`.`gps_coordinates` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`teacher_lectures`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`teacher_lectures` (
  `teacher_id` INT UNSIGNED NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  INDEX `fk_tl_teacher_idx` (`teacher_id` ASC, `lecture_id` ASC),
  PRIMARY KEY (`teacher_id`, `lecture_id`),
  CONSTRAINT `fk_tl_teacher`
    FOREIGN KEY (`teacher_id` , `lecture_id`)
    REFERENCES `role_call_db`.`teacher` (`email_address` , `email_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tl_lecture`
    FOREIGN KEY ()
    REFERENCES `role_call_db`.`lecture` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `role_call_db`.`class_lecture`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `role_call_db`.`class_lecture` (
  `class_id` VARCHAR(45) NOT NULL,
  `lecture_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`class_id`, `lecture_id`),
  INDEX `fk_cl_lecture_idx` (`lecture_id` ASC),
  CONSTRAINT `fk_cl_class`
    FOREIGN KEY (`class_id`)
    REFERENCES `role_call_db`.`class` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cl_lecture`
    FOREIGN KEY (`lecture_id`)
    REFERENCES `role_call_db`.`lecture` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
