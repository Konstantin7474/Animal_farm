CREATE DATABASE Human_friends;

USE Human_friends;
CREATE TABLE animal_classes
(
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Class_name VARCHAR(20)
);

INSERT INTO animal_classes (Class_name)animal_classes
VALUES ('вьючные'),
('домашние');

CREATE TABLE packed_animals
(
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Genus_name VARCHAR (20),
        Class_id INT,
        FOREIGN KEY (Class_id) REFERENCES animal_classes (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO packed_animals (Genus_name, Class_id)
VALUES ('Лошади', 1),
('Ослы', 1),
('Верблюды', 1);

CREATE TABLE home_animals
(
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Genus_name VARCHAR (20),
        Class_id INT,
        FOREIGN KEY (Class_id) REFERENCES animal_classes (Id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO home_animals (Genus_name, Class_id)
VALUES ('Кошки', 2),
('Собаки', 2),
('Хомяки', 2);

CREATE TABLE cats
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR (20),
    Birthday DATE,
    Commands VARCHAR (50),
    Genus_id INT,
    FOREIGN KEY (Genus_id) REFERENCES home_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO cats (Name, Birthday, Commands, Genus_id)
VALUES ('Пуфик', '2012-01-12', 'кскскс', 1),
('Муфик', '2015-03-05', 'нельзя', 1),
('Чуфик', '2018-04-10', '   ', 1);

CREATE TABLE dogs
(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR (20),
    Birthday DATE,
    Commands VARCHAR (50),
    Genus_id INT,
    FOREIGN KEY (Genus_id) REFERENCES home_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    INSERT INTO dogs (Name, Birthday, Commands, Genus_id)
    VALUES ('Шарик', '2021-04-21', 'сидеть, лежать, дай_лапу, голос', 2),
    ('Петр', '2022-07-11', 'сидеть, рядом, комне', 2),
    ('Рекс', '2020-02-01', 'сидеть, лежать, рядом', 2),
    ('Песик', '2019-09-21', 'аппорт, лежать, сидеть', 2);
    
    CREATE TABLE hamsters
    (
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR (20),
        Birthday DATE,
        Commands VARCHAR (50),
        Genus_id INT,
        FOREIGN KEY (Genus_id) REFERENCES home_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
	);
    
    INSERT INTO hamsters (Name, Birthday, Commands, Genus_id)
    VALUES ('Хома', '2020-03-04', '', 3),
    ('Чижик', '2021-05-03', 'сидеть', 3),
    ('Пахом', '2022-10-04', NULL, 3),
    ('Мохнач', '2021-03-22', NULL, 3);
    
    CREATE TABLE horses
    (
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR (20),
        Birthday DATE,
        Commands VARCHAR (50),
        Genus_id INT,
        FOREIGN KEY (Genus_id) REFERENCES packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
	);
    
    INSERT INTO horses (Name, Birthday, Commands, Genus_id)
    VALUES ('Конь', '2019-07-22', 'стоять, сидеть, бегом', 1),
    ('Мустанг', '2020-04-11', 'вперед, назад, голоп', 1),
    ('Черныш', '2020-09-22', 'стоять, голоп, назад', 1),
    ('Беляш', '2020-02-12', 'голоп, вперед, стоять', 1);
    
    CREATE TABLE donkeys
    (
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR (20),
        Birthday DATE,
        Commands VARCHAR (50),
        Genus_id INT,
        FOREIGN KEY (Genus_id) REFERENCES packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
	);
    
    INSERT INTO donkeys (Name, Birthday, Commands, Genus_id)
    VALUES ('Ослик', '2019-07-21', NULL, 2),
    ('Иа', '2020-04-09', '', 2),
    ('Серый', '2020-09-13', '', 2),
    ('Хохмач', '2020-02-05', NULL, 2);
    
    
    CREATE TABLE camels
    (
		Id INT AUTO_INCREMENT PRIMARY KEY,
        Name VARCHAR (20),
        Birthday DATE,
        Commands VARCHAR (50),
        Genus_id INT,
        FOREIGN KEY (Genus_id) REFERENCES packed_animals (Id) ON DELETE CASCADE ON UPDATE CASCADE
    );
    
    INSERT INTO camels (Name, Birthday, Commands, Genus_id)
    VALUES ('Веля', '2016-04-11', 'сюда', 3),
    ('Горбач', '2019-07-12', 'кушать', 3),
    ('Метан', '2020-04-20', 'позируй', 3),
    ('Пропан', '2019-05-03', 'тихо', 3);
    
    
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM camels;
    
    SELECT Name, Birthday, Commands FROM horses
    UNION SELECT Name, Birthday, Commands FROM donkeys;
    
    
    CREATE TEMPORARY TABLE animals AS
    SELECT *, 'Лошади' AS genus FROM horses
    UNION SELECT *, 'Ослы' AS genus FROM donkeys
    UNION SELECT *, 'Собаки' AS genus FROM dogs
    UNION SELECT *, 'Кошки' AS genus FROM cats
    UNION SELECT *, 'Хомяки' AS genus FROM hamsters;
    
    
    CREATE TABLE yang_animal AS
    SELECT Name, Birthday, Commands, genus, TIMESTAMPDIFF(MONTH, Birthday, CURDATE()) AS age_in_month
    FROM animals WHERE Birthday BETWEEN ADDDATE(curdate(), INTERVAL - 3 YEAR) AND ADDDATE(CURDATE(), INTERVAL - 1 YEAR);
    
    SELECT * FROM yang_animal;
    
    SELECT h.Name, h.Birthday, h.Commands, pa.Genus_name, ya.Age_in_month
    FROM horses h
    LEFT JOIN yang_animal ya ON ya.Name = h.Name
    LEFT JOIN packed_animals pa ON pa.Id = h.Genus_id
    UNION
    SELECT d.Name, d.Birthday, d.Commands, pa.Genus_name, ya.Age_in_month
    FROM donkeys d
    LEFT JOIN yang_animal ya ON ya.Name = d.Name
    LEFT JOIN packed_animals pa ON pa.Id = d.Genus_id
    UNION
    SELECT c.Name, c.Birthday, c.Commands, ha.Genus_name, ya.Age_in_month
    FROM cats c
    LEFT JOIN yang_animal ya ON ya.Name = c.Name
    LEFT JOIN home_animals ha ON ha.Id = c.Genus_id
    UNION
    SELECT d.Name, d.Birthday, d.Commands, ha.Genus_name, ya.Age_in_month
    FROM dogs d
    LEFT JOIN yang_animal ya ON ya.Name = d.Name
    LEFT JOIN home_animals ha ON ha.Id = d.Genus_id
    UNION
    SELECT hm.Name, hm.Birthday, hm.Commands, ha.Genus_name, ya.Age_in_month
    FROM hamsters hm
    LEFT JOIN yang_animal ya ON ya.Name = hm.Name
    LEFT JOIN home_animals ha ON ha.Id = hm.Genus_id;
    
    
    
        
        
        

