-- Q1. Find the employees who's salary is more than the average salary earned by all employees.
select avg(salary)
from employee --52400;

select * from employee
where salary > (select avg(salary)from employee); --52400)


-- Scalar subquery
-- It always returns one row and one column
select e.*
from employee e
join (select avg(salary) sal from employee) av_sal
	on e.salary >av_sal.sal;

-- Multiple row sub query
-- subquery which returns multiple column and multiple rows
-- subquery which returns only 1 column and multiple rows

-- Q2. Find the employees who earn the highest salary in each department.

Select dept_name, max(salary)
from employee
group by dept_name;


select * 
from employee
where (dept_name,salary) in (Select dept_name, max(salary)
								from employee
								group by dept_name);
								
-- Single column multiple row subquery
-- Q3. Find department who do not have any employees.


select *
from department
where dept_name not in (Select distinct dept_name from employee);

-- Correlated subquery
-- A Subquery which is related to the outer query
-- Q4. Find the employees in each department who earn more than the average salary in that department.

Select avg(salary) avg_salary from employee where dept_name = 'specific_dept';

select *
from employee e1
where salary > (select avg(salary) from employee e2
				where e2.dept_name = e1.dept_name);

/* Q5. Find the departments who do not have any employees */

Select * 
from department d
where not exists (Select * from employee e where e.dept_name = d.dept_name );


/* CREATE TABLE sales (
    store_id INT,
    store_name VARCHAR(50),
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10, 2)
);

INSERT INTO sales (store_id, store_name, product_name, quantity, price) VALUES
(1, 'Store A', 'Product X', 10, 15.00),
(1, 'Store A', 'Product Y', 5, 20.00),
(2, 'Store B', 'Product X', 8, 15.00),
(2, 'Store B', 'Product Z', 12, 25.00),
(3, 'Store C', 'Product Y', 6, 20.00),
(3, 'Store C', 'Product Z', 10, 25.00),
(4, 'Store D', 'Product X', 14, 15.00),
(4, 'Store D', 'Product Y', 7, 20.00);
*/

/* Q6. Find stores who's sales where better than the average sales across all stores. */
/* 1. find the total sales for each store.
	2. Find avg sales for all the stores.
	3. compare 1& 2.
*/

SELECT *
FROM (
    SELECT store_name,SUM(price * quantity) AS total_sales
    FROM sales
    GROUP BY store_name ) sales_summary
WHERE total_sales > (SELECT AVG(total_sales) 
    FROM (SELECT SUM(price * quantity) AS total_sales
        FROM sales
        GROUP BY store_name) avg_sales);

-- CTE Syntax
with sales as
	(SELECT store_name,SUM(price * quantity) AS total_sales
    FROM sales
    GROUP BY store_name )
select *
from sales
join (select avg(total_sales)as sales
	from sales x) avg_sales
	on sales.total_sales > avg_sales.sales;

-- Sub queries in 
-- SELECT
-- FROM
-- WHERE
-- HAVING

/* Using subquery in SELECT clause. */

/* Fetch all employee details and add remarks to those employees who earn more than the average pay. */

select *, (case when salary > (select avg(salary) from employee)
		then 'Higher than average'
	else null
end )as remarks
from employee

/* Using subquery in HAVING clause. */

/* Find the stores who have sold more units than the average units sold by all stores. */

Select store_name, sum(quantity)
from sales
group by store_name
having sum(quantity) > (select avg(quantity) from sales)



-- Sub queries in 
-- INSERT
-- UPDATE
-- DELETE

/* INSERT - Insert data to employee history table. Make sure not insert duplicate records. */
select * from employee

CREATE TABLE emp_history (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_name VARCHAR(50),
    salary INT,
    location VARCHAR(50)
);	


INSERT INTO emp_history
select e.emp_id, e.emp_name, d.dept_name,e.salary
from employee e
join department d on d.dept_name = e.dept_name
where not exists (select 
					1 from emp_history eh
					where eh.emp_id = e.emp_id)

select * 
from employee
where dept_name = 'Marketing';

-- INSERT INTO employee values(121, 'Emp21','Marketing',35000.00)



