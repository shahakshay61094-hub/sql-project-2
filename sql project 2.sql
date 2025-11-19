create database demo;

use demo;

create table customers (
customersid int primary key,
firstname varchar(100),
lastname varchar(100),
email varchar(100),
registrationdate date
);

insert into customers (customersid, firstname, lastname, email, registrationdate ) values
(1, 'john', 'doe', 'john.doe@gmail.com', '2022-03-25'),
(2, 'jane ', 'smith', 'smith.doe@gmail.com', '2021-11-02');

create table orders (
orderid int primary key,
customersid int,
foreign key (customersid) references customers(customersid),
orderdate date,
totalamount int
);

insert into orders (orderid, customersid, orderdate, totalamount ) values
(101 , 1, '2022-09-25', 150),
(102 , 2, '2022-07-24', 120);

create table employees (
employeeid int primary key,
firstname varchar(100),
lastname varchar(100),
department varchar(50),
hiredate date,
salary decimal(10,2)
);

insert into employees (employeeid, firstname, lastname, department, hiredate, salary) values
(1, 'mark', 'john', 'sales', '2020-01-15', 50000),
(2, 'susan', 'lee', 'hr', '2022-03-15', 40000);

select o.orderid, o.orderdate, o.totalamount,
       c.customersid, c.firstname, c.lastname, c.email
from orders o
inner join customers c
    on o.customersid = c.customersid;

select c.customersid, c.firstname, c.lastname,
       o.orderid, o.orderdate, o.totalamount
from customers c
left join orders o
    on c.customersid = o.customersid;

select o.orderid, o.orderdate, o.totalamount,
       c.customersid, c.firstname, c.lastname
from orders o
right join customers c
    on o.customersid = c.customersid;

select c.customersid, c.firstname, c.lastname,
       o.orderid, o.orderdate, o.totalamount
from customers c
left join orders o on c.customersid = o.customersid

union

select c.customersid, c.firstname, c.lastname,
       o.orderid, o.orderdate, o.totalamount
from customers c
right join orders o on c.customersid = o.customersid;

select *
from customers
where customersid in (
    select customersid
    from orders
    where totalamount > (select avg(totalamount) from orders)
);

select *
from employees
where salary > (select avg(salary) from employees);

select orderid,
       year(orderdate) as orderyear,
       month(orderdate) as ordermonth
from orders;

select orderid,
       datediff(curdate(), orderdate) as dayspassed
from orders;

select orderid,
       date_format(orderdate, '%d-%b-%y') as formatteddate
from orders;

select employeeid,
       concat(firstname, ' ', lastname) as fullname
from employees;

select replace(firstname, 'john', 'jonathan') as updatedname
from customers;

select upper(firstname) as firstnameupper,
       lower(lastname) as lastnamelower
from customers;

select trim(email) as cleanemail
from customers;

select orderid, orderdate, totalamount,
       sum(totalamount) over (order by orderdate) as runningtotal
from orders;

select orderid, totalamount,
       rank() over (order by totalamount desc) as rankbyamount
from orders;

select orderid, totalamount,
       case
           when totalamount > 1000 then totalamount * 0.10
           when totalamount > 500 then totalamount * 0.05
           else 0
       end as discount
from orders;

select employeeid, firstname, lastname, salary,
       case
           when salary >= 70000 then 'high'
           when salary >= 50000 then 'medium'
           else 'low'
       end as salarycategory
from employees;


