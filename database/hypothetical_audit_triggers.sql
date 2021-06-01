DROP TRIGGER IF EXISTS `roll_call_db`.`lecture_AFTER_UPDATE`;
DELIMITER $$
USE `roll_call_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `roll_call_db`.`lecture_AFTER_UPDATE` AFTER UPDATE ON `lecture` FOR EACH ROW
BEGIN
INSERT INTO `roll_call_db`.`RevisionInfo` (`timestamp`,`author`,`method`)
VALUES (UNIX_TIMESTAMP(),"authorvarible","update");

INSERT INTO `roll_call_db`.`lecture_AUD` (`id`,`REV`,`code`,`date`,`registration_deadline`,`name`)
VALUES (new.id,LAST_INSERT_ID(),new.code,new.date,new.registration_deadline,new.name);
END
$$
DELIMITER ;