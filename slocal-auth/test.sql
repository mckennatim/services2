select * from users;

delete from users where id=438;

ALTER TABLE `users` CHANGE `lids` `lids` VARCHAR(260) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '[]';
