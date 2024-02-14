create database trigger2023;
CREATE TABLE trigger2023.worker (
  worker_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  hourly_pay DECIMAL(10,2),
  job_title VARCHAR(50),
  hiredate DATE,
  supervisor_id INT,
  FOREIGN KEY (supervisor_id) REFERENCES worker(worker_id)
);
INSERT INTO trigger2023.worker (worker_id, first_name, last_name, hourly_pay, job_title, hiredate, supervisor_id) VALUES
  (1, 'John', 'Doe', 20.00, 'Project Manager', '2022-01-01', NULL),
  (2, 'Jane', 'Smith', 18.50, 'Designer', '2021-03-15', 1),
  (3, 'Mark', 'Johnson', 22.00, 'Programmer', '2020-05-01', 1),
  (4, 'Sarah', 'Lee', 16.75, 'Administrator', '2023-02-14', 3),
  (5, 'David', 'Kim', 19.25, 'Developer', '2022-11-30', 3),
  (6, 'Emily', 'Chen', 21.50, 'Senior Developer', '2021-06-20', 3),
  (7, 'Michael', 'Wong', 23.75, 'Marketing Manager', '2020-01-01', NULL),
  (8, 'Jennifer', 'Davis', 25.00, 'Sales Manager', '2022-04-15', 7),
  (9, 'Kevin', 'Nguyen', 17.50, 'Customer Support', '2023-01-15', 7),
  (10, 'Rachel', 'Garcia', 18.00, 'HR Assistant', '2021-10-01', 7),
  (11, 'Andrew', 'Brown', 20.50, 'IT Manager', '2022-07-01', NULL),
  (12, 'Olivia', 'Martinez', 19.75, 'Help Desk Technician', '2021-05-15', 11),
  (13, 'William', 'Liu', 21.00, 'Network Administrator', '2020-02-28', 11),
  (14, 'Grace', 'Scott', 18.25, 'Web Designer', '2023-03-01', 11),
  (15, 'Jason', 'Baker', 22.50, 'Software Engineer', '2022-08-15', 11),
  (16, 'Karen', 'Nelson', 20.25, 'Data Analyst', '2021-04-01', 1),
  (17, 'Daniel', 'Gonzalez', 19.50, 'Research Assistant', '2022-01-15', 16),
  (18, 'Ava', 'Taylor', 17.25, 'Statistician', '2020-12-01', 16),
  (19, 'Luke', 'Adams', 21.75, 'Database Administrator', '2021-09-01', 16),
  (20, 'Sophia', 'Wilson', 18.75, 'Business Analyst', '2023-04-15', 16);


CREATE TABLE trigger2023.expense (
  expense_id INT PRIMARY KEY,
  expense_name VARCHAR(50),
  expense_total DECIMAL(10, 2)
);

INSERT INTO trigger2023.expense (expense_id, expense_name, expense_total) 
VALUES 
  (1, 'salaries', 0),
  (2, 'supplies', 0),
  (3, 'taxes', 0);
  
  select*
  from trigger2023.worker;
  
  -- BEFORE INSERT TRIGGER--
  
  alter table trigger2023.worker
  add column annual_salary decimal(10,2) after hourly_pay;
  
  set sql_safe_updates = 0;
  update trigger2023.worker
  set annual_salary=hourly_pay*2080;
  
  create  trigger New_annual_salary
  before insert on worker
  for each row
  set new.annual_salary=new.hourly_pay*2080;
  
  insert into trigger2023.worker(worker_id, first_name, last_name,hourly_pay,annual_salary, job_title, hiredate, supervisor_id)
  VALUES (24, "Ishan","Thapa",28.99,null,"Data Analyst",'2023-12-02',2);

  select*
  from trigger2023.worker;
  
  -- data will be stored here after we delete it from below queries 
create table trigger2023.worker_audit(
id INT Primary KEy,
title VARCHAR(255) NOT NULL,
date_left timestamp);

-- after delete
-- values will be from old table and we use "OLD" 
create trigger worker_after_delete
after delete on worker
for each row 
insert into trigger2023.worker_audit(id,title,date_left)
values(old.worker_id,old.job_title, now());

delete from trigger2023.worker
where worker_id=22;

-- now above deleted will be stored in worker audit 
select*
from trigger2023.worker_audit;

-- add a new name into worker audit so we need first name and last name
alter table trigger2023.worker_audit
add column first_name varchar(255) after id;


update trigger2023.worker_audit
set first_name="Kevin"
where id=22;

-- calculate the expense 
select* from trigger2023.expense;

select sum(annual_salary)
from trigger2023.worker;

-- after that
update trigger2023.expense
set expense_total=(select sum(annual_salary)
from trigger2023.worker)
where expense_name='salaries';

-- after insert 
-- what if one empolyee leave or come what ill be the expense and it needs to be triggered automaically
create trigger update_salary_after_insert
after insert on worker
for each row
update trigger2023.expense
set expense_total=old.expense_total+new.annual_salary

