/* SQL WITH Clause | CTE */
-- Fetch employees who earn more than average salary of all employees.

WITH average_salary (avg_sal) as
	(select avg(salary)from employee)
select * 
from employee e, average_salary av
where e.salary > av.avg_sal;


-- Find stores who's sales where better than the average sales accross all stores.

-- Method 1
-- 1) Total sales per each store -- Total_sales
Select s.store_id, sum(price) as total_sales_per_store
from sales s
group by s.store_id;

-- 2) Find the average sales with respect to all the stores -- Avg_sales

select cast(avg(total_sales_per_store)as int) as avg_sales_for_all_stores
from (
	Select s.store_id, sum(price) as total_sales_per_store
	from sales s
	group by s.store_id )x;
	
-- 3) Find the stores where Total_sales > Avg_sales of all stores.
--Sub queries
from (Select s.store_id, sum(price) as total_sales_per_store
		from sales s
		group by s.store_id) Total_sales
join (select cast(avg(total_sales_per_store)as int) as avg_sales_for_all_stores
		from ( Select s.store_id, sum(price) as total_sales_per_store
			   from sales s
			   group by s.store_id )x)Avg_sales
	on Total_sales.total_sales_per_store >Avg_sales.avg_sales_for_all_stores;


-- Method 2 using CTE

with total_sales(store_id,total_sales_per_store) as
		(Select s.store_id, sum(price) as total_sales_per_store
		from sales s
		group by s.store_id),
	avg_sales(avg_sales_for_all_stores) as
	(select cast(avg(total_sales_per_store)as int) as avg_sales_for_all_stores
		from total_sales)
select *
from total_sales ts
join avg_sales av 
on ts.total_sales_per_store >av.avg_sales_for_all_stores;


















