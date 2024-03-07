/*
COMENTAROS
*/

-- Comentario en una lína
-- las siguientes instruciones son para crear una base de datos con las edades de las personas <30




CREATE TABLE bbdd.person (
    Name VARCHAR(255),
    Surname VARCHAR(255),
    ID INT,
    Birth_Date DATE,
    Sex CHAR(1),
    Address VARCHAR(255)
);
CREATE TABLE bbdd.jobs (
    Name VARCHAR(255),
    Surname VARCHAR(255),
    ID INT,
    Years_Company1 INT,
    AddressCompany1 VARCHAR(255),
    Years_Company2 INT,
    AddressCompany2 VARCHAR(255),
    Years_Company3 INT,
    AddressCompany3 VARCHAR(255)
);

CREATE TABLE bbdd.academic (
    Name VARCHAR(255),
    Surname VARCHAR(255),
    ID INT,
    FormationDegree VARCHAR(255)
);
--Existe id duplicado?
SELECT ID, COUNT(*) as count
FROM bbdd.person
GROUP BY ID
HAVING count > 1;
-- Cambiar  (Name, Surname, ID, Birth_Date)
UPDATE bbdd.person
SET Name = 'NuevoNombre', Surname = 'NuevoApellido', ID = NuevoID, Birth_Date = 'YYYY-MM-DD', Sex = 'N', Address = 'NuevaDireccion'
WHERE ID = ID_A_Cambiar;

/*
RENAME TABLE `bbdd.Birth Date` TO bbdd.Birth_Date;
ALTER TABLE bbdd.person CHANGE `Birth Date` Birth_Date DATE;
ALTER TABLE bbdd.person CHANGE `Birth Date` Birth_Date DATE;


SELECT * FROM (
  SELECT `Birth Date`, TIMESTAMPDIFF(YEAR, `Birth Date`, CURDATE()) AS Age 
  FROM bbdd.person
) AS temp
WHERE Age > (SELECT Years_Company1 + Years_Company2 + Years_Company3 FROM jobs) -- Sum of the three values from Years_Company1, Years_Company2, Years_Company3


SELECT * FROM (
    SELECT `Birth_Date`, TIMESTAMPDIFF(YEAR, `Birth_Date`, CURDATE()) AS Age 
    FROM bbdd.person
) AS temp 
WHERE Age > (SELECT SUM(Years_Company1) + SUM(Years_Company2) + SUM(Years_Company3) FROM bbdd.jobs)
*/

SELECT *, 
    TIMESTAMPDIFF(YEAR, `Birth_Date`, CURDATE()) AS TrapAge,
    j.Years_Company1 + j.Years_Company2 + j.Years_Company3 AS Total_Years_Worked
FROM bbdd.person
JOIN bbdd.jobs j ON person.ID = j.ID
HAVING TrapAge < Total_Years_Worked;

--EJ3 empieza aqui_______________________________________________________________

CREATE TABLE bbdd.bonus (
    ID INT UNIQUE,
    amed INT,
    atot INT,
    form INT
);

INSERT INTO bbdd.bonus (ID, form, atot, amed)
SELECT 
    person.ID, 
    academic.FormationDegree, 
    Years_Company1 + Years_Company2 + Years_Company3 AS Total_Years_Worked,
    (Years_Company1 + Years_Company2 + Years_Company3) / 3 AS Average_Years_Worked
FROM bbdd.person
JOIN bbdd.jobs ON person.ID = jobs.ID
JOIN bbdd.academic ON person.ID = academic.ID
ON DUPLICATE KEY UPDATE 
    form = VALUES(form), 
    atot = VALUES(atot), 
    amed = VALUES(amed);

-- EJ4 empieza aqui¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?
