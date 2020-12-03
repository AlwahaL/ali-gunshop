USE `es_extended`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_ammu','Gunshop',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_ammu','Gunshop',1)
;
INSERT INTO `datastore` (name, label, shared) VALUES
	('society_ammu', 'Gunshop', 1)
;
INSERT INTO `jobs` (name, label) VALUES
	('ammu','Gunshop')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('ammu',0,'recruit','Çırak',10,'{}','{}'),
	('ammu',1,'novice','Eleman',25,'{}','{}'),
	('ammu',2,'experienced','Tecrübeli Eleman',40,'{}','{}'),
	('ammu',3,'boss','Patron',0,'{}','{}')
;
