-- 1.Create Database as SQL practice and use it for further questions. 
        create database sqlpractice;
		use sqlpractice;
        
/* 2.Create a table named "Students" with the following columns: StudentID (int), 
	FirstName (varchar), LastName (varchar), and Age (int). 
	Insert at least three records into the table. */
         create table Students ( StudentID int, first_name varchar(49),
         last_name varchar(50) , Age int);
         
         insert into students values( 1, 'Antony','Jerome',22),(2,'Arun','Kumar', 22),
         (3,'BK','krishna',21),(4,'Crown','GK',22);
         
/* 3.Update the age of the student with StudentID 1 to 21. 
     Delete the student with StudentID 3 from the "Students" table.*/
		update Students set Age=21 where studentID=1;
        delete from students where studentid=3;
        
/* 4.Retrieve the first names and ages of all students who are older than 20.*/
        select  first_name , age from students where age>20;
       -- truncate students;
       
/* 5.Delete records from the same table where age<18.*/
         insert into students values( 5, 'arul','mani',17);
         delete from students where age<18;
         
/*6.Create a table named "Customers" with the following columns and constraints: 
	CustomerID (int) as the primary key. 
	FirstName (varchar) not null.  
	LastName (varchar) not null.  
	Email (varchar) unique. */
		create table Customers ( CustomerID int  primary key , 
        first_name varchar(49) not null,
		last_name varchar(50) not null , Age int  unique);
		
/*7.You have a table named "Orders" with columns: OrderID (int), 
    CustomerID (int), OrderDate (date), and TotalAmount (decimal).
    Create a foreign key constraint on the "CustomerID" column 
    referencing the "Customers" table. */
         create table Orders (orderId int ,CustomerID int ,
         OrderDate date,TotalAmount decimal, foreign key(customerID) references customers (customerID));
		
/*8.Create a table named "Employees" with columns: 
	EmployeeID (int) as the primary key. 
	FirstName (varchar) not null. 
	LastName (varchar) not null. 
	Salary (decimal) check constraint to ensure salary is between 20000 and 100000*/
		create table Employees (EmployeeID int primary key, 
        First_name varchar(40) not null, Last_name varchar(40) not null,
        salary decimal check(salary between 20000 and 100000));
/*9.Create a table named "Books" with columns: 
	BookID (int) as the primary key. 
	Title (varchar) not null. 
	ISBN (varchar) unique.*/
		create table Books (BookID int primary key,
        Title varchar (40) not null,
        ISBN varchar(50) unique);
/*10.Consider a table named "Employees" with columns: EmployeeID, FirstName, 
	LastName, and Age. 
	Write an SQL query to retrieve the first name and 
	last name of employees who are older than 30.*/
		Alter table employees add column age int;
        select first_name, Last_name from employees where age>30; 
/*11.Using the same "Employees" table, write an SQL query to retrieve the first name, last name, 
	and age of employees whose age is between 20 and 30.*/
		select first_name, Last_name from employees where age between  20 and 30;
        
/*12.Given a table named "Products" with columns: ProductID, ProductName, 
	Price, and InStock (0- for out of stock, 1- for in stock). 
	Write an SQL query to retrieve the product names and prices of 
	products that are either priced above $100 or are out of stock.*/ 
		create table Products (ProductID int, ProductName varchar(50),
			Price int, Instock binary);
		insert into products values(1 ,'iphone', 1000,0),(2,'iwatch',500,1),(3,'yatch',100000, 1),(4,'macbook',2000,1);
		select ProductName, Price from Products where price>100 and instock=0; 
/*13.Using the "Products" table, write an SQL query to retrieve the product names and 
	prices of products that are in stock and priced between 50 and 150.*/
		select productname,price from products where price between 50 and 150 and instock=1;

/*14.Consider a table named "Orders" with columns: OrderID, OrderDate, TotalAmount, 
	and CustomerID. Write an SQL query to retrieve the order IDs and total amounts of
	orders placed by 
	customer ID 1001 after January 1, 2023, or orders with a
	total amount exceeding $500.*/
		insert into orders values(01,1001,'2023-01-02',600),(02,1002,'2023-04-15',500);
		select orderID,totalamount from orders where customerid =1001 and orderdate>= 01-01-2023 
        or totalamount>500; 
        
/*15.Retrieve the ProductName of products from the "Products" table 
	that have a price between $50 and $100.*/
		select productname from products where price between 50 and 100;
        
/*16.Retrieve the names of employees from the "Employees" table who are both 
	from the "Sales" department and have an age greater than 25,
	or they are from the "Marketing" department. */
		select *from employees;
        alter table employees add column dept char(50);
        select first_name,last_name from employees where dept='sales' and age>25 
			or dept='marketing';
            
/*17.Retrieve the names of customers from the "Customers" table who are not 
	from the city'New York' or 'Los Angeles'*/
		alter table customers add column city char(50);
        select first_name,last_name from customers where city ='New york' or 'Los Angeles';
        
/*18.Retrieve the names of employees from the "Employees" table 
	who are either from the "HR" department and have an age less than 30, or 
	they are from the "Finance" department and have an age greater than or equal to 35. */
		select first_name,last_name from employees where dept='HR' and age>30 
			or dept='Finance' and age>=35;
            
/*19.Retrieve the names of customers from the "Customers" table 
	who are not from the city 'London' and either have a postal code starting with '1' or
	their country is not 'USA'. */
    alter table customers add column postalcode int;
	alter table customers add column country char(30);
    select *from customers;
    insert into customers values( 01,'aj','jeroime',22, 'chennai',122344,'india');
		select first_name,last_name from customers where 
        city !='London' and substring(postalcode,1,1)=1 or country!= 'USA';
        
        select first_name,last_name from customers where 
        city !='London' and postalcode like '%1' or country!= 'USA';
            
        create table process_table (id int not null);
        alter table process_table  modify column id int null;
        insert into process_table values(null),(1);
        select *from process_table;