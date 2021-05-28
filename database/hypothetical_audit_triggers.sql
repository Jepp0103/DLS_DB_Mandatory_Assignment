CREATE DEFINER=CURRENT_USER TRIGGER `lecture_AFTER_UPDATE` AFTER UPDATE ON `lecture` FOR EACH ROW BEGIN
INSERT INTO `roll_call_db`.`RevisionInfo` (`timestamp`,`author`) VALUES (UNIX_TIMESTAMP(),"authorvarible");
INSERT INTO `roll_call_db`.`lecture_AUD` (`id`,`REV`,`code`) VALUES (new.id,LAST_INSERT_ID(),new.code);
END