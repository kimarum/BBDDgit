-- Creación de las tablas
CREATE TABLE bbdd.person (
    ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Surname VARCHAR(255),
    Birth_Date DATE,
    Sex CHAR(1),
    Address VARCHAR(255)
);

CREATE TABLE bbdd.jobs (
    ID INT PRIMARY KEY,
    Years_Company1 INT,
    AddressCompany1 VARCHAR(255),
    Years_Company2 INT,
    AddressCompany2 VARCHAR(255),
    Years_Company3 INT,
    AddressCompany3 VARCHAR(255),
    FOREIGN KEY (ID) REFERENCES bbdd.person(ID)
);

CREATE TABLE bbdd.academic (
    ID INT PRIMARY KEY,
    FormationDegree VARCHAR(255),
    FOREIGN KEY (ID) REFERENCES bbdd.person(ID)
);

-- Actualización de un registro en la tabla person
UPDATE bbdd.person
SET Name = 'NuevoNombre', Surname = 'NuevoApellido', Birth_Date = 'YYYY-MM-DD', Sex = 'N', Address = 'NuevaDireccion'
WHERE ID = ID_A_Cambiar;

-- Selección de personas cuya edad es menor que la suma de los años trabajados
SELECT *, 
    TIMESTAMPDIFF(YEAR, Birth_Date, CURDATE()) AS Age,
    Years_Company1 + Years_Company2 + Years_Company3 AS Total_Years_Worked
FROM bbdd.person p
JOIN bbdd.jobs j ON p.ID = j.ID
HAVING Age < Total_Years_Worked;

-- Creación de la tabla bonus y llenado con datos
CREATE TABLE bbdd.bonus (
    ID INT PRIMARY KEY,
    amed INT,
    atot INT,
    form INT,
    FOREIGN KEY (ID) REFERENCES bbdd.person(ID)
);

INSERT INTO bbdd.bonus (ID, form, atot, amed)
SELECT 
    p.ID, 
    a.FormationDegree, 
    j.Years_Company1 + j.Years_Company2 + j.Years_Company3 AS Total_Years_Worked,
    (j.Years_Company1 + j.Years_Company2 + j.Years_Company3) / 3 AS Average_Years_Worked
FROM bbdd.person p
JOIN bbdd.jobs j ON p.ID = j.ID
JOIN bbdd.academic a ON p.ID = a.ID
ON DUPLICATE KEY UPDATE 
    form = VALUES(form), 
    atot = VALUES(atot), 
    amed = VALUES(amed);

-- Conteo de repeticiones de una dirección
SELECT Address, COUNT(*) as Count
FROM (
    SELECT AddressCompany1 as Address FROM bbdd.jobs
    UNION ALL
    SELECT AddressCompany2 as Address FROM bbdd.jobs
    UNION ALL
    SELECT AddressCompany3 as Address FROM bbdd.jobs
) AS Addresses
GROUP BY Address;