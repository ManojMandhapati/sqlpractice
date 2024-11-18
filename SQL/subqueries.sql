-- Q1. Find the employees who's salary is more than the average salary earned by all employees.
select avg(salary)
from employee --52400

select * from employee
where salary > (select avg(salary)from employee) --52400)


-- Scalar subquery
-- It always returns one row and one column
select e.*
from employee e
join (select avg(salary) sal from employee) av_sal
	on e.salary >av_sal.sal

-- Multiple row sub query
-- subquery which returns multiple column and multiple rows
-- subquery which returns only 1 column and multiple rows

-- Q2. Find the employees who earn the highest salary in each department.

Select dept_name, max(salary)
from employee
group by dept_name


select * 
from employee
where (dept_name,salary) in (Select dept_name, max(salary)
								from employee
								group by dept_name);
								
-- Single column multiple row subquery
-- Q3. Find department who do not have any employees.


select *
from department
where dept_name not in (Select distinct dept_name from employee)

-- Correlated subquery
-- A Subquery which is related to the outer query
-- Q4. Find the employees in each department who earn more than the average salary in that department.















































