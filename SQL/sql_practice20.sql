SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;

-- 1. Identify the total no of products sold

select sum(quantity) as Total_sales 
from sales_order;

-- 2. Other than Completed, display the available delivery status's
select status
from sales_order 
where status  not in ( 'Completed', 'completed');

select distinct status
from sales_order
where status in ('Completed','completed');

select status 
from sales_order
where lower(status) != ('completed');

-- 3. Display the order id, order_date and product_name for all the completed orders.

select s.order_id, s.order_date, p.name 
from sales_order s
inner join products p on s.prod_id = p.id
where lower(s.status) = 'completed';

-- 4. Sort the above query to show the earliest orders at the top. Also, display the customer who purchased these orders.

select s.order_id, s.order_date, p.name product_name ,c.name customer_name
from sales_order s 
inner join products p on s.prod_id = p.id
inner join customers c on s.customer_id = c.id
where lower(s.status) = 'completed'
order by s.order_date;

-- 5. Display the total no of orders corresponding to each delivery status
select status, count(*) Total_orders
from sales_order
group by status

SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;

-- 6. How many orders are still not completed for orders purchasing more than 1 item?

select *
from sales_order
where lower(status) != 'completed'  and  quantity >1 


-- 7. Find the total number of orders corresponding to each delivery status by 
  --  ignoring the case in the delivery status. The status with highest no of orders should be at the top.

select count(*) order_quantity , status
from sales_order
group by status
order by order_quantity desc;

-- 8. Write a query to identify the total products purchased by each customer 
select  c.name customer_name, sum(quantity) Toatl_products
from sales_order s
join customers c on s.customer_id = c.id 
group by c.name

-- 9. Display the total sales and average sales done for each day. 
select order_date, avg(quantity*price) avg_sales, sum(quantity*price) as Total_sales
from sales_order s
join products p on p.id = s.prod_id
group by order_date
order by order_date;

SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;
-- 10. Display the customer name, employee name, and total sale amount of all orders which are either on hold or pending.
select c.name, e.name as employee_name, sum(quantity*price) as Total_sales
from sales_order so
join employees e on e.id = so.emp_id
join customers c on c.id = so.customer_id
join products p on p.id = so.prod_id
where status in ('On Hold', 'Pending')
group by c.name, e.name;


-- 11. Fetch all the orders which were neither completed/pending or were handled by the employee Abrar. 
  --   Display employee name and all details of order.
select s.*, e.name
from sales_order s
join employees e on e.id = s.emp_id
where lower (status) not in ('completed','pending') or e.name = 'Abrar%'

select e.name as employee, so.*
from sales_order so
join employees e on e.id = so.emp_id
where lower(e.name) like '%abrar%'
or lower(status) not in ('completed', 'pending');

select s.*, e.name
from sales_order s
join employees e on e.id = s.emp_id
where e.name = '%Abrar%'

-- 12. Fetch the orders which cost more than 2000 but did not include the MacBook Pro. Print the total sale amount as well.

select (so.quantity * p.price) as total_sale, so.*
from sales_order so
join products p on p.id = so.prod_id
where prod_id not in (select id from products 
					  where name = 'Macbook Pro')
and (so.quantity * p.price)	> 2000;

-- 13. Identify the customers who have not purchased any product yet.

select * from customers
where id not in (select distinct customer_id from sales_order);


select c.*
from customers c
left join sales_order so on so.customer_id = c.id
where so.order_id is null;

select  c.*
from sales_order so
right join customers c on so.customer_id = c.id
where so.order_id is null;

-- 14. Write a query to identify the total products purchased by each customer. 
	-- Return all customers irrespective of whether they have made a purchase or not. 
	-- Sort the result with the highest no of orders at the top.

select c.name, coalesce(sum(quantity),0) as sumof_total_products 
from sales_order so
right join customers c on c.id = so.customer_id
group by c.name
order by sumof_total_products desc;

SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;
-- 15. Corresponding to each employee, display the total sales they made of all the completed orders.
	-- Display total sales as 0 if an employee made no sales yet.
select e.name as employee_name ,coalesce (sum (quantity * price),0) as total_sale
from sales_order so
join products p on p.id = so.prod_id
right join employees e 
	on e.id = so.emp_id
	and lower(so.status) = 'completed' 
group by e.name;

-- 16. Re-write the above query to display the total sales made by each employee corresponding to each customer. 
	-- If an employee has not served a customer yet then display "-" under the customer.




-- 17. Re-write the above query to display only those records where the total sales are above 1000





-- 18. Identify employees who have served more than 2 customers.


SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;
-- 19. Identify the customers who have purchased more than 5 products
select c.name,sum(quantity) as orders_purchased
from sales_order so
join customers c on c.id = so.customer_id
group by c.name
having sum(quantity)  >5

-- 20. Identify customers whose average purchase cost exceeds the average sale of all the orders.



















