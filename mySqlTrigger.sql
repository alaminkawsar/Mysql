CREATE TABLE employee(  
    name varchar(45) NOT NULL,    
    occupation varchar(35) NOT NULL,    
    working_date date,  
    working_hours varchar(10)  
);


INSERT INTO employee VALUES    
('Robin', 'Scientist', '2020-10-04', 12),  
('Warner', 'Engineer', '2020-10-04', 10),  
('Peter', 'Actor', '2020-10-04', 13),  
('Marco', 'Doctor', '2020-10-04', 14),  
('Brayden', 'Teacher', '2020-10-04', 12),  
('Antonio', 'Business', '2020-10-04', 11);  


DELIMITER //
Create Trigger before_insert_empworkinghours   
BEFORE INSERT ON employee FOR EACH ROW  
BEGIN  
IF NEW.working_hours < 0 THEN SET NEW.working_hours = 0;  
END IF;  
END //  

SHOW TRIGGERS

INSERT INTO employee VALUES    
('Abir', 'Scientist', '2020-10-04', -5),  
('shahadat', 'Engineer', '2020-10-04', -1010);

INSERT INTO employee VALUES    
('HI', 'Scientist', '2020-10-04', -5),  
('shahebzada', 'Engineer', '2020-10-04', -1010);

backup_Employee
DROP TABLE backup_Employee

DELIMITER //
Create Trigger after_insert_empworkinghours   
AFTER INSERT ON employee FOR EACH ROW  
BEGIN  
	INSERT INTO backup_Employee VALUES(NEW.name, NEW.Occupation,NEW.working_date,NEW.working_hours,CURTIME());
END //

DROP TRIGGER after_insert_empworkinghours;

SHOW TRIGGERS

INSERT INTO employee VALUES    
('AB', 'Scientist', '2020-10-04', -5),  
('XY', 'Engineer', '2020-10-04', -1010);

DELIMITER //
CREATE TRIGGER before_update_employee
BEFORE UPDATE ON employee FOR EACH ROW
BEGIN
	INSERT INTO backup_Employee VALUES(OLD.name, OLD.Occupation,OLD.working_date,OLD.working_hours,CURRENT_TIMESTAMP());
END //

UPDATE employee
SET NAME='ABR'
WHERE NAME='AB';


CREATE TABLE employee_log(  
    user varchar(45) NOT NULL,     
    descriptions VARCHAR(1000)  
);


#making log
DELIMITER //
CREATE TRIGGER after_update_employee
AFTER UPDATE ON employee FOR EACH ROW
BEGIN
	INSERT INTO employee_log VALUES(USER(),
	CONCAT('Update: ',OLD.name,' ',OLD.occupation,' ',NEW.Occupation));
END //

UPDATE employee
SET NAME='ABIR'
WHERE NAME='AB';

#
DELIMITER //
CREATE TRIGGER before_delete_employee
AFTER DELETE ON employee FOR EACH ROW
BEGIN
	INSERT INTO backup_Employee
	VALUES(OLD.name, OLD.Occupation,OLD.working_date,OLD.working_hours,CURRENT_TIMESTAMP());
	
END //

DROP TRIGGER before_delete_employee

DELETE FROM employee
WHERE working_hours=10;


DELIMITER //
CREATE TRIGGER before_delete_employee
BEFORE DELETE ON employee FOR EACH ROW
BEGIN
	INSERT INTO backup_Employee
	VALUES(OLD.name, OLD.Occupation,OLD.working_date,OLD.working_hours,CURRENT_TIMESTAMP());
	
END //