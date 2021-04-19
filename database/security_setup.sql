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

DROP TRIGGER IF EXISTS `roll_call_db`.`teacher_AFTER_INSERT`;

DELIMITER $$
CREATE DEFINER=`root`@`%` TRIGGER `teacher_AFTER_INSERT` AFTER INSERT ON `teacher` FOR EACH ROW BEGIN
INSERT INTO `roll_call_db`.`users` (`username`, `password`, `enabled`,`teacher_id`) VALUES (new.email_address, '$2a$10$hGko1F1s45iCEpzioDvQiuui6QabjjA4ob8y3AIvSk8Ocv5Jg.hWK.hWK', '1',NEW.id);
INSERT INTO `roll_call_db`.`authorities` (`username`, `authority`) VALUES (new.email_address, 'ROLE_TEACHER');

END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `roll_call_db`.`student_AFTER_INSERT`;

DELIMITER $$
CREATE DEFINER=`root`@`%` TRIGGER `student_AFTER_INSERT` AFTER INSERT ON `student` FOR EACH ROW BEGIN
INSERT INTO `roll_call_db`.`users` (`username`, `password`, `enabled`,`student_id`) VALUES (new.email_address, '$2a$10$hGko1F1s45iCEpzioDvQiuui6QabjjA4ob8y3AIvSk8Ocv5Jg.hWK', '1',NEW.id);
INSERT INTO `roll_call_db`.`authorities` (`username`, `authority`) VALUES (new.email_address, 'ROLE_STUDENT');

END$$
DELIMITER ;

