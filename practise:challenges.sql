
-- SELECT FROM (chooses what data to get from where) * Means we select everything (all the columns)
SELECT* FROM current_job_detail;

-- This now means we get only the id and job title from that database 
SELECT employee_id, job_title
FROM current_job_detail;

-- WHERE means we can specifiy parameters, so if the employee id = 1000 thats the ones we bring to the table
-- and the star is meaning we bring all the data from employee id 1000
SELECT *
FROM current_job_detail
WHERE employee_id = 1000;

-- != just like our previous functions means not equal to so it will return any employee aslong as there id
-- is not equal to 1000 
SELECT *
FROM current_job_detail
WHERE employee_id != 1000;

-- returns all employee where the salary is more than or equal to 50,000
SELECT *
FROM current_job_detail
WHERE salary >= 50000;

--  BETWEEN returns employees between the parameters
SELECT *
FROM current_job_detail
WHERE salary BETWEEN
30000 and 50000;

-- LIKE will find any job title containing the letters evel, so all developers and apprentice developers  
-- % is a wildcard. it will find the string betwene them 
SELECT *
FROM current_job_detail
WHERE job_title LIKE
('%evel%');

-- without the first wildcard means it has to start with Devel, whereas between wildcards could be anywhere 
SELECT *
FROM current_job_detail
WHERE job_title LIKE
('Devel%');

-- _ is like wildcard but could be anything within the string
SELECT*
FROM current_job_detail
WHERE job_title LIKE ('P_duct Lead');

-- Checking for job title product lead OR marketing lead  
SELECT*
FROM current_job_title
WHERE job_title IN ('Product Lead','Marketing Lead');

-- Finding developers that earn less than or equal to 35000 
SELECT*
FROM current_job_detail
WHERE salary <= 35000
AND job_title = 'Developer';



-- CHALLENGES 

-- RETURN A TABLE OF ALL OF THE TECH LEADS
SELECT*
FROM current_job_detail
WHERE job_title LIKE ('Tech Lead') ; 

-- RETURN ALL OF THE FEMALE EMPLOYEES
SELECT *
FROM employee_detail 
WHERE gender LIKE ('f'); 

-- RETURN EMPLOYEES WITH NAME STARTING WITH S
SELECT*
FROM employee_detail
WHERE Name LIKE ('s%'); 

-- RETURN ALL WHO HAVE EVER BEEN A DEVELOPER
 SELECT*
 FROM jobs_history
 WHERE job_title LIKE ('devel%');
 
 -- RETURN LAPTOPS ID's THAT ALL USE UBUNTU
 SELECT laptop_id 
 FROM laptop_detail
 WHERE os LIKE ('Ubuntu');
 
 -- RETURN EMPLOYEES WHOSE NAMES BEGIN WITH S OR A
 SELECT*
FROM employee_detail
WHERE Name LIKE ('s%') 
OR
Name LIKE ('a%'); 
-- END OF CHALLENGES

-- This will CREATE A TABLE called my favourite employees
-- char would mean it needs to have 64 characters, varchar means its a maximum of 64  
CREATE TABLE
my_favourite_employees(
employee_id int PRIMARY KEY,
job_title varchar(64));
 
-- Now we can see our new table, its empty for now 
SELECT*
FROM my_favourite_employees;

-- DELETES TABLE 
DROP TABLE my_favourite_employees;

-- Inserts data of employee id and job title to new table, only employee id 1001 and 1002
INSERT INTO my_favourite_employees
SELECT employee_id, job_title
FROM current_job_detail
WHERE employee_id in (1001,1002);

-- Checking its done it
SELECT*
FROM my_favourite_employees;

-- Deleting employee with id 1001 
DELETE FROM my_favourite_employees
WHERE employee_id = 1001;


-- CHALLENGES

-- CREATE NEW TABLE 
CREATE TABLE
great_names(
employee_id int PRIMARY KEY,
name varchar(64));

-- Insert 5 employees
INSERT INTO great_names
SELECT employee_id, Name
FROM employee_detail
WHERE Name LIKE ('Sam')
	OR Name LIKE ('Bob')
	OR Name LIKE ('Joe')
	OR Name  LIKE ('Vaskor')
	OR Name LIKE ('Usman'); 

SELECT*
FROM great_names;

-- Delete someone by their employee id 
DELETE FROM great_names
WHERE employee_id = 1001;
 
-- Recreate table with extra column called great_name_ind 
CREATE TABLE
great_names2(
employee_id int PRIMARY KEY,
name varchar(64),
great_name_ind varchar(1));

-- insert 5 employees and set ind to y 
INSERT INTO great_names2
SELECT employee_id, Name, 'Y'
FROM employee_detail
WHERE Name LIKE ('Sam')
	OR Name LIKE ('Bob')
	OR Name LIKE ('Joe')
	OR Name  LIKE ('Vaskor')
	OR Name LIKE ('Usman'); 

SELECT*
FROM great_names2;

-- Change one row ind to N 
UPDATE great_names2
set
great_name_ind = 'N'
WHERE employee_id = 1000;


-- PRIMARY vs FOREIGN
-- PRIMARY means each column should be unique, so an id but not a name, like a customer id, delivery id
-- FOREIGN key is a primary key stored elsewhere, so we can build relations with them 

-- Merging the two tables based on the primary key their ID. 
-- now their details and their work history is on the same table because of using their id 
-- INNER JOIN just means we are joining this to this, ON then gives the parameters of what we are joining    
SELECT*
FROM current_job_detail
INNER JOIN employee_detail
ON current_job_detail.employee_id =
employee_detail.Employee_ID;

-- we can make it look abit tidier 
-- cjd now stands for current job detail and ed is employee detail, saves us writing it out twice 
SELECT*
FROM current_job_detail cjd
INNER JOIN employee_detail ed
ON cjd.employee_id = ed.employee_id;

-- This wont work so well, as id will repeat the same id in each row for different jobs they've had, harder to read
-- 'order by' does what it says on the tin. 
SELECT*
FROM current_job_detail cjd
INNER JOIN jobs_history jh
ON cjd.employee_id = jh.employee_id
order by cjd.employee_id;

-- One to One relationships 
-- One to Many relationships
-- Many to Many relationships    

-- Returning just the employee id from cjd, current job detail 
SELECT cjd.employee_id
FROM current_job_detail cjd
INNER JOIN employee_detail ed
ON cjd.employee_id = ed.employee_id;

 -- job title by name
 SELECT ed.name, cjd.job_title
 FROM current_job_detail cjd
 INNER JOIN employee_detail ed 
 ON cjd.employee_id = ed.employee_id;




-- CHALLENGES
-- REMEMBER ON links them using primary keys, so no duplicates for the same person,
--  you NEED THIS ASWELL AS WHERE (PARAMETERS) 
-- return a table linking laptop and current job
SELECT*
FROM current_job_detail cjd
INNER JOIN laptop_detail ld
ON cjd.laptop_id = ld.laptop_id
;

-- return a table of employees that own a mac
SELECT*
FROM current_job_detail cjd
INNER JOIN laptop_detail ld
ON cjd.laptop_id = ld.laptop_id
WHERE ld.os LIKE ('mac');

-- Return a table of employyes that used to be an apprentice but are now developers
SELECT*
FROM current_job_detail cjd
INNER JOIN jobs_history jh
ON cjd.employee_id = jh.employee_id
WHERE jh.job_title LIKE ('Apprentice%')
AND
cjd.job_title LIKE ('Devel%');

-- Return a table of all the employees that weren’t a developer and now are
SELECT*
FROM current_job_detail cjd
INNER JOIN jobs_history jh
ON cjd.employee_id = jh.employee_id
WHERE jh.job_title NOT LIKE ('Devel%')
AND
cjd.job_title LIKE ('Devel%');

-- Return a table of all the employees that have had more then one job title (not using aggregates)
SELECT*
FROM current_job_detail cjd
INNER JOIN jobs_history jh
ON cjd.employee_id = jh.employee_id
WHERE cjd.job_title != jh.job_title
order by cjd.employee_id;




-- AGGREGATING
-- Max will return the max salary in the table  
SELECT MAX(salary) FROM current_job_detail;

-- GROUP BY can help us find the max salary for each job title
SELECT job_title, MAX(salary) 
FROM current_job_detail 
GROUP BY job_title; 

-- AVG finds the average
SELECT job_title,AVG(salary) 
FROM current_job_detail 
GROUP BY job_title; 

-- MIN will find the minimum salary for each title
SELECT job_title, MIN(salary) 
FROM current_job_detail 
GROUP BY job_title; 

-- SUM finds the sum of all the salaries in that job title
SELECT job_title,SUM(salary) 
FROM current_job_detail 
GROUP BY job_title; 

-- COUNT will find how many entries there is by job title
SELECT job_title,COUNT(*) 
FROM current_job_detail 
GROUP BY job_title;




-- CHALLENGES
-- Return a table of the max salary by job type
SELECT job_title, MAX(salary)
FROM current_job_detail
GROUP BY job_title; 

-- Return a table counting how many people have each OS 
SELECT os,COUNT(*) 
FROM laptop_detail 
GROUP BY os;

-- Return a table of the average salary of staff members that have at some point been an apprentice developer 
SELECT cjd.employee_id, AVG(salary) 
FROM current_job_detail cjd, jobs_history jh
WHERE cjd.job_title LIKE ('Apprentice%')
OR 
jh.job_title LIKE ('Apprentice%')
GROUP BY cjd.employee_id;

-- Return a row of data containing the name of the person with the highest salary
SELECT name, MAX(salary)
FROM current_job_detail cjd
INNER JOIN employee_detail ed
ON cjd.employee_id = ed.employee_id
GROUP BY ed.name;


CREATE TABLE high_salary (
max_salary int,
name varchar(64));

INSERT INTO high_salary
SELECT max(salary), name
FROM current_job_detail, employee_detail;
GROUP BY name, salary;


select * from high_salary;





-- SELECT salary, MAX(salary)
-- FROM current_job_detail cjd ORDER BY salary
-- INNER JOIN employee_detail ed
-- ON cjd.employee_id = ed.employee_id
-- GROUP BY ed.name;



 