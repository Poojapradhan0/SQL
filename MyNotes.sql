
create database Sample1 	-- 1. To create a Database using a Query
create database Sample2

alter Database Samples Modify Name = sample1	--2. To alter a Database

sp_renameDB 'sample4','Sample2'		--system stored procedure to Alter a database

--3. Deleting or Dropping a database
 
Drop database Sample2		 --Dropping a database,delets the LDF and MDF files.
--you cannot drop a database , if it is currently in use.

--4. creating tables
use samples
go
create table tblperson_
(ID int not null primary key,
 Names nvarchar(50) not null,
 Email nvarchar(50) not null,
 GenderId int null )


 --making changes to the structure to our table
  alter table tblperson_ 
  add mobile_no varchar(50)

  alter table tblperson_
  add Ac_no int 


   insert into tblperson_ values (1,'pooja','pooh@.com', 2 , 352656463 , 1111111)
      insert into tblperson_ values (2,'xxxx','X@.com', 4 , 0000000 , 43534456)

	     insert into tblperson_ values (3,'yyyy','Y@.com', 3, 88888888 , 34645645)

		    insert into tblperson_ values (4,'ppppp','P@.com', 6 , 9999999 , 456535)

			   insert into tblperson_ values (5,'aaaa','A@.com', 5 , 22222222 , 4534542)


  Select * from tblperson_

use samples		--Table-2
go

Create table tblGender_
(
ID int not null primary key,
Gender nvarchar(50) not null 
)
--5. Enforcing primary key and foreign key constraints

alter table tblperson_ 
add constraint person_genderId_FK
Foreign key (GenderId) references tblgender_(ID)

--adding default constraint
Select*from tblGender_
select*from tblperson_

insert into tblperson (ID,Names,Email) values (7,'rich','r@.com')

--Altering an existing column to add a default constraint:


alter table tblperson			--add constraint
add constraint DF_tblperson_genderId
default 3 for GENDERID

alter table tblperson			--drop constraint
drop constraint DF_tblperson_genderId	


insert into dbo.tblperson (ID,Names,Email) values (9,'lich','p@l.com')

select*from tblGender
select*from tblperson

Delete from tblgender where ID = 3
Delete from tblgender where ID = 4

--Lecture-7 (Check costraint)
-- Check constraint is used to limit the range of the values , that can be entered for a column.

select*from tblperson
insert into tblperson values(8,'tara','s@t.com',1,50)

--The General formula for adding check constraint in SQL server:

alter table tblperson
add constraint CK_tblperson_Age CHECK  (Age > 0 AND AGE < 159 )

--Lecture-8 (Identity Column)


Select*from Tblperson1
 
insert into Tblperson1 values (1,'jane')
insert into Tblperson1 values (2,'sane')
insert into Tblperson1 values ('dane')


Delete from Tblperson1 where personId = 1

SET IDENTITY_INSERT Tblperson1  Off

Delete from Tblperson1

--DBCC command which we can use to reset the identity value and then start again at 0
-- (Database Consistency Check Commands)

DBCC check ident ( Tblperson1, RESEED, 0)

--Lecture-8(Pre request-Lecture-8)
--Retrieving Identity column values

--1. how to get the last generated identity column value

Create table Test1
(
ID int identity (1,1),
value nvarchar (20)
)

Create table Test2
(
ID int identity (1,1),
value nvarchar (20) 
)

insert into Test1 values ('x')

Select * from Test1
Select * from Test2

create trigger tr_for_insert on test1 for insert
as
begin
	Insert into Test2 Values ('yyyy')
End

insert into Test2 values ('zzz')

Select SCOPE_IDENTITY()			--Same session & the same scope
select @@IDENTITY		 		--Same session and across any scope
Select IDENT_CURRENT ('Test2')

--Lecture-9 (unique key Constraint)
--A. What is unique key constraint
--B. When to use unique key constraint over primary key constrant?
--C. Difference between unique key and primary key constraint?

use samples
go
create table TBperson
(ID     int not null primary key,
 Names nvarchar(50) not null,
 Email nvarchar(50) not null,
 GenderId int null,
 Age    int null,
 )

 select * from TBperson

 alter table TBperson
 Add constraint UQ_TBperson_Email Unique (Email)


 insert into TBperson values (2,'XYZ','a@.com',1,20)
  insert into TBperson values (3,'urfi','u@.com','1', 20)

 --Delete 

 alter table TBperson
 drop constraint UQ_TBperson_Email
 
 -----------------------------------------------------------------------------------------------------

 -- Lecture-10 (All about "SELECT") [SELECT statement in SQL server]

 select * from SamPerson where city = 'london'

 select * from SamPerson where city <> 'london'	-- not eqal to sign (<>,!)

 select * from SamPerson where city != 'london'

 select * from SamPerson where Age =20 or age=23 or age=29		--(NOT) not in a list , Range etc.
 
 select * from SamPerson where Age in (20, 23, 29)			-- (IN)  Specifies a list of values

 select * from SamPerson where Age between 20 and 25		-- (BETWEEN) Specifies a Range

 select * from SamPerson where city like 'L%'			-- (LIKE) Specifies only patterrn

 select * from SamPerson where Email like 's%'		-- %  Specifies zero or more characters

select * from SamPerson where Email like '[^MST]%'	-- [^] Not any character with in the brackets

select * from SamPerson where Email like '_@_.com'   --  _ Specifies exactly one character
	
select * from SamPerson where name like '[MST]%'			-- [] Any character with in the brackets

select distinct  name, City from SamPerson

---------------------------------------------------------------------------------------------------------

--Joining multiple condition using AND & OR operators
select * from SamPerson where (city = 'london' OR city = 'Mumbai') AND Age > 25
select * from samperson where (city = 'london' or name = 'pooja') and age >20
select * from samperson where (city = 'jerman' or email = 'p#.com') and age >25

-----------------------------------------------------------------------------------------------
----------- Sorting rows using ORDER BY

select * from SamPerson order by Name DESC     --(DESCENDING List Name)
select * from Samperson order by name ASC

select * from SamPerson order by Name DESC, Age ASC			--(ASCENDING List Of Age)

-- Selecting top N or top N Percentage of rows
select * from samperson
select top 5 city   from samperson order by id desc

Select top 5 city  from samperson order by age  desc

select top 10  * from SamPerson
select top 3  * from SamPerson
select top 3 name, Age  from SamPerson
select top 1 Percent * from SamPerson
select top 1 Percent * from SamPerson
select top 2 * from SamPerson
select top 4 name, genderid  from SamPerson

select top 1 * from SamPerson order by age DESC

----------------------------------------------------------------------------------------------
-- Lecture-11 [GROUP BY In SQL Server]

/*Definition=
(GROUP BY clause is used to group a selected set of rows into a set of
summary rows by the values of one or more columns or expressions. 
It is always used in conjuction with one or more aggregate functions).
*/
-- A. Grouping Rows using GROUP BY

--C. differenece between WHERE and HAVING

select * from tblemployee

select SUM(salary) from tblemployee

select MIN(salary) from tblemployee

select Max(salary) from tblemploye

select avg(salary) from tblemploye

--Total salary paid by city ----------------------------------------.

select * from tblemployee

select    City, SUM(salary) as totalSalary
from      tblemployee
Group by   City

select gender,  sum(salary) as totalsalary
from tblemployee
group by Gender


--B. Filtering Groups 

-- (i) Grouping by multiple columns

select      city, Gender, SUM(salary) as totalSalary			--city, Gender,
from		tblemployee
Group by	City, Gender 
order by	city --optional

select		 Gender,city,  SUM(salary) as totalSalary			--Gender,city,
from		tblemployee
Group by	 Gender, City 
order by	gender --optional

Select * from tblemployee
select COUNT(*) from tblemployee		--Want to find out Total number of Employee
select COUNT(ID) from tblemployee
select count(name) from tblemployee

-- (ii) Using multiple aggregate function	--aggregate(grouping)

select    Gender,city,  SUM(salary) as totalSalary, Count(ID) as Totalemployees		--  find out [Total employees]			
from      tblemployee
Group by  Gender, City 

select gender, city , sum(salary) as totalsalary, count(name) as totalname
from tblemployee
group by city, gender

select * from tblemployee

--C. differenece between Where and Having.

select    Gender,city,  SUM(salary) as totalSalary, Count(ID) as Totalemployees					
from      tblemployee														---- (If you want only Male Salary)
Group by  Gender, City 
HAVING    gender = 'M'		--male   	--HAVING clause 

select    Gender,city,  SUM(salary) as totalSalary, Count(ID) as Totalemployees					
from      tblemployee	
WHERE     gender = 'F'			--WHERE clause
Group by  Gender, City 


 /* Aggregate functions cannot be used in the WHERE clause,
Unless it is in a sub query contained in a HAVING clause,
Whereas, AGGREGATE FUNCTIONS can be used in  HAVING Clause.
*/
--Lecture-12
--(i) the 3 types of joins in SQL server
--(ii) (Cross join)
--(iii) (inner join)
--(iv)(outer join) Left,Right & full outer join

--(iv)(outer join)s Are divided into
-- 1. Left Join or Left outer join
--2. Right Join or Right outer join
--3. full join or full outer join

-- (Joins) in SQL server are used to retrieve data from 2 or more related tables.
--In general tables are related to each other using foreign key constraint.


--Inner join or Join
--Inner join returns only the matching rows between both the tables. Non matching rows are eliminated

select * from tblEmploye
select * from tblDepartment

select         Name,gender, salary, DepartmentName
from           tblEmploye
inner join      tbldepartment
ON            tblEmploye.DepartmentId = tblDepartment.Id

select  name,gender,salary, departmentname, location, departmrnthead
from tblemploye
inner join tbldepartment
on tblemploye.departmentid = tbldepartment.id

-- LEFT Join returns all the matching rows + non matching rows from the left table

select * from tblEmploye
select * from tblDepartment

select Name,  gender, salary, departmentname
from          tblEmploye
Left join    tbldepartment		--left
ON           tblEmploye.DepartmentId = tblDepartment.Id

-- RIGHT Join returns all the matching rows + non matching rows from the Right table

select * from tblEmploye
select * from tblDepartment

select    Name,gender, salary, departmentname
from       tblEmploye
right outer join tbldepartment		
ON         tblEmploye.DepartmentId = tblDepartment.Id

/*FULL Join or FULL Outer join-
 Full Join returns all rows from both the Left & Right tables + including the non matching rows .
Matching Rows + Non Matching rows from both the tables
*/

select * from tblEmploye
select * from tblDepartment

select       Name,gender, salary, departmentname
from         tblEmploye
 FULL outer join tbldepartment		
ON          tblEmploye.DepartmentId = tblDepartment.Id


--Cross join
--CROSS join shouldn't have ON clause
--CROSS join, produces the cartesian product of the 2 tables involved in the join.

select * from tblEmploye
select * from tblDepartment

select		Name,gender, salary, departmentname,location
from          tblEmploye
Cross join   tbldepartment		

--Lecture-13
 --Advanced or intelligent joins

 --in this lesson we will learn only NON-MATCHING rows from the LEFT table,RIGHT TABLE & LEFT and RIGHT table 
 select * from tblEmploye
select * from tblDepartment

select		 Name, gender, salary, departmentname
from		 tblEmploye
LEFT join	 tbldepartment		
ON			 tblEmploye.DepartmentId = tblDepartment.Id
where		 tblDepartment.Id IS NULL


select		 Name, gender, salary, departmentname
from		 tblEmploye
Right join	 tbldepartment		
ON			 tblEmploye.DepartmentId = tblDepartment.Id
where		 tblEmploye.DepartmentId IS NULL

select		 Name, gender, salary, departmentname
from		 tblEmploye
Full join	 tbldepartment		
ON			 tblEmploye.DepartmentId = tblDepartment.Id
where		 tblEmploye.DepartmentId IS NULL
OR			 tblDepartment.Id IS NULL

--Lecture-14 (SELF JOIN)
--joining a table with it self is as SELF JOIN. {Learning never ends channel}
-----self join
/*
In SQL Server, a self JOIN is a regular join, but the table is joined with itself.
A self-join is used to find records in a table that are related to other records in the same table.
A table is joined to itself in a self-join
*/

create table employe_manager
(
Emp_ID int primary key,
EMP_Name nvarchar(10),
Manager_ID int 
)

insert into employe_manager values (1, 'pooja',4)
insert into employe_manager values (2, 'chitra', 3)
insert into employe_manager values (3, 'kajol', 4)
insert into employe_manager values (4, 'martina', 1)
insert into employe_manager values (5, 'ashish', 6)
insert into employe_manager values (6, 'kashish', 2)
insert into employe_manager values (7, 'chinu', 1)

select * from employe_manager;

--self join ke liye iska koi particular keyword nahi so her we need to use INNER JOIN
-- yaha per 1 hi table ko alag alag devide karna he

select * from employe_manager;

select A.EMP_Name as Employee , B.EMP_Name as manager from employe_manager as A
inner join employe_manager as B
on A.Emp_ID = B.manager_Id;


--lecture-16
--COALESCE() Function
-- It Returns the first NON NULL-value in a list

select coalesce (NULL,NULL, 'pooh', NULL, 'pradhan'); --is line me first null value pooh he, 2nd null value pradhan he, but coalesce function ka rule ye he ki ye sirf first null value output dega
create table COALESCE_EXAMPLE
(
ID int primary key,
firstname nvarchar (10),
middlename nvarchar (10),
lastname nvarchar (10)
)

insert into COALESCE_EXAMPLE values (1,null, null, 'pooja')
insert into COALESCE_EXAMPLE values (2,'mona', null, 'dude')
insert into COALESCE_EXAMPLE values (3,null, 'sona', null)
insert into COALESCE_EXAMPLE values (4,null, null, 'dey')
insert into COALESCE_EXAMPLE values (5,null, 'kismis', 'meena')
insert into COALESCE_EXAMPLE values (6,'swwetu', null, 'pooja')






select id, coalesce (firstname,middlename,lastname)
from COALESCE_EXAMPLE


----difference between COALESCE and ISNULL
--DIFFERENCE---
ISNULL  function contains only 2 arguments
coalesce function doesnt limit the number of arguments.

--ISNULL me only 2 argument pass kar sakte he
--coalesce me 2 se jyada list of value argument pass kar sakte he 

select * from   COALESCE_EXAMPLE;
select ISNULL(firstname,middlename) from COALESCE_EXAMPLE ---- ISNULL ME only 2 argument pass hua he

select coalesce(firstname,middlename,lastname) from COALESCE_EXAMPLE; ---COALESCE 2 se jyada argument pass hua he

--Lecture-17
--UNION & UNION ALL
--Definition- UNION & UNION ALL Operators in SQl server, are used to combine the result-set of two or more  SELECT Query.
--Difference- UNION removes duplicates rows, where as UNION ALL does not.
-- UNION  is little slower than  UNION ALL

select * from Tbl_UK
select * from Tbl_india

select * from Tbl_UK
UNION 
select * from Tbl_india


select * from Tbl_UK
UNION ALL
select * from Tbl_india


select * from Tbl_UK
UNION ALL
select * from Tbl_india
order by name

select  Id, Email, name from Tbl_UK
UNION ALL
select Id, E_Mail, name from Tbl_india

--Difference between UNION and JOIN
--UNION combine rows from two or more tables , where JOINS combine columns from 2 or more table
--------------------------------------------------------------------------------------------------------------

--Lecture - 18
-------------------------Stored Procedure (SP)
/*
---What Is Stored Procedure In SQL ?
A stored procedure is a set of Structured Query Language (SQL) statements with an assigned name,
which are stored in a relational database management system as a group, so it can be reused and shared by multiple programs.
Stored procedures are useful when repetitive tasks have to be performed.////////

A stored procedure is a group of Transact-SQL statements that act as a single block of code that performs a specific task.
This block of code is identified by an assigned name and is stored in the database in a compiled form.
Stored procedures can accept values in the form of input parameters and return output values as defined by the output parameters.

---The advantages of using stored procedures are as follows:
*Improved Security
*Precompiled Execution
*Reduced Client/Server Traffic
*Reuse of Code

---Stored Procedures is divided into 2 Categories
1-System Stored Procedures
2-User-Defined Stored Procedures

-------System Stored Procedures:-
System stored procedures are commonly used for interacting with system tables .
The system stored procedures are prefixed with ‘sp_’.
These procedures are located in the Resource database.
System stored procedures allow GRANT, DENY, and REVOKE permissions.
A system stored procedure is a set of pre-compiled Transact-SQL statements executed as a  "single unit".
System procedures are used in database administrative and informational activities.
When referencing a system stored procedure, the sys schema identifier is used. System stored procedures are owned by the database administrator.

--------User-Defined Stored Procedures:-
User-defined stored procedures are also known as custom stored procedures.
These procedures are used for reusing Transact-SQL statements for performing repetitive tasks.
There are two types of user-defined stored procedures, the Transact-SQL stored procedures and the Common Language Runtime (CLR) stored procedures
Transact-SQL stored procedures consist of Transact-SQL statements whereas the CLR stored procedures are based on the .NET framework CLR methods.
Both the stored procedures can take and return user-defined parameters.
Custom Or User-Defined Stored Procedures
In SQL Server, users are allowed to create customized or user-defined stored procedures for performance of various tasks.

The CREATE PROCEDURE permission is required to create a procedure and the ALTER permission on the schema in which the procedure is being created.
Syntax:
CREATE PROC / PROCEDURE Procedure_Name
Parameters DataType
AS
BEGIN
......SQL_STATEMENT Here.......
END
*/
--(i) stored procedure example--------------------------------
Select *from stored_Procedure

----Example -2----(learning never ends)
 Select *from stored_Procedure

  CREATE PROC  spGetemployees
  AS
  BEGIN
  Select name, gender from stored_Procedure; --main line to input in stored procedure
  END

  --Output
  spGetemployees;   --you dosn't need to write that query anymore
 
        
--ii) how to create STORED PROCEDURE with  single PARAMETERS
 Select *from stored_Procedure

 create proc spgetemployeesById
 @id int -- SQL ke andar variable declare krne ke liye  @  ka sign use krte he
 as
 begin
 select *from stored_Procedure where id= @id;		-- here id= column name, @id= parameter name
 end

 execute spgetemployeesById 2;

  execute spgetemployeesById 3;

 execute spgetemployeesById 5;
   

  --- STORED PROCEDURE with  Multiple PARAMETERS


Create Proc spGetemployeesByGenderandDepartment
@Gender nvarchar(20),
@DepartmentId int 
AS
Begin
Select * from stored_Procedure Where  Gender = @Gender 
and DepartmentId = @DepartmentId
END

spGetemployeesByGenderandDepartment 'm', 3;

--example -2---------------------------
 Select *from stored_Procedure

 create proc spnameANDId
 @name nvarchar(10),
 @Id int 
 as
 begin
 select * from stored_Procedure where name = @name and 
 id = @id
 end

 execute spnameANDId 'cham' , 4;
spnameANDId 'pooja', 1;


 --To change a procedure

 CREATE PROC  spGetemployees
  AS
  BEGIN
  Select name, gender from stored_Procedure;
  END


  Alter PROCEDURE  spGetemployees
  AS
  BEGIN
  Select name, gender from stored_Procedure ORDER By name
  END
   execute spGetemployees;

-------  --To view definition of the store procedure 
sp_helptext spGetemployees


  ------To Delet  a procedure

Drop Proc spGetemployees  

--Skip the Lecture 19,20,21 related to stored procedure

--Lecture - 19
--To Create an SP with output Parameter , We use the keyword OUT OR OUTPUT

Select *from stored_Procedure

Create procedure  spGetemployeeCountByGender
@Gender nvarchar(20),
@Employeecount int output
AS
Begin
	Select @Employeecount = COUNT(Id) from stored_Procedure where Gender  = @Gender
END

 Declare @Totalcount int
 Execute spGetemployeeCountByGender 'male ', @Totalcount 
 select @Totalcount

 if(@Totalcount is null ,
	print '@Totalcount is null',
else 
	print 'totalCount is not null'	
  --If you don't specify the OUTPUT keyword, When Executing the stored procedure, the @employ Total variable will be null

  --useful system stored procedure
  --1- sp_help procedure_name
  sp_help spGetemployeeCountByGender

  --2- sp_helptext procedure_name
  sp_helptext spGetemployeeCountByGender

  --3- sp_depends procedure_name
sp_depends spGetemployeeCountByGender


--Lecture  = 20
--Stored procedure output parameters or return values
--skip

--Lecture-21
--Advantages of Stored procedure
--Execution planretention and reuseability
--reduce Network traffic
--Code reuseability & better maintainability
--Better security
--Avoids Sql injection attack




--Lecture = 22
 --------------------------------------------
 --String functions-----------------------------------------------------------

 -- 1-user defined functions and
 -- 2- system functions

 --system functions=

 Select *from stored_Procedure
 --ASCII

 SELECT ASCII('A')
 SELECT ASCII('ABC')
 --CHAR

  SELECT CHAR(65)

  Declare @start int
  set @start = 65
  While (@start <=90)
  Begin 
  Print Char (@start)
  Set @start = @start + 1
   End


   SELECT CHAR('0')

  Declare @start int
  set @start = 48
  While (@start <= 57)
  Begin 
  Print Char (@start)
  Set @start = @start + 1
   End

--LTRIM  (removes LeFT side blank space)
--RTRIM  (removes Right side blank space)

Select ('  hello')
Select  LTRIM('  hello')

Select * From String_Function

Select LTRIM(Firstname) as Firstname,middlename, LastName from String_Function

Select  RTRIM('  hello  ')

Select LTRIM(Firstname) as Firstname,middlename, LastName, 
Firstname + ' ' + middlename + ' ' + LastName as FULLName
from String_Function

 --Removes space from FULLName

Select LTRIM(Firstname) as Firstname,middlename, LastName, 
RTRIM (LTRIM(Firstname)) + ' ' + middlename + ' ' + LastName as FULLName
from String_Function


--LOWER AND UPPER CASE
Select UPPER(LTRIM(firstName)) as firstName, Middlename,LOWER(LastName), 
RTRIM (LTRIM(Firstname)) + ' ' + middlename + ' ' + LastName as FULLName
from String_Function

--REVERSE function (E.G-  THE Name SAM become MAS)

Select REVERSE(UPPER(LTRIM(firstName)))as firstName, Middlename,LOWER(LastName), 
RTRIM (LTRIM(Firstname)) + ' ' + middlename + ' ' + LastName as FULLName
from String_Function


--LEN Function

Select * From String_Function
Select FirstName,LEN(FirstName) as[Total character] From String_Function

Select FirstName,LEN(LTRIM(FirstName)) as[Total character] From String_Function

--Lecture-23
--LEFT(),	RIGHT(),	CHARINDEX(),	SUBSTRING()

Select * From String_Function

--LEFT()
SELECT LEFT ('ABCDEF',4) 
SELECT RIGHT ('ABCDEF',4) 

--CHARINDEX() - To Find
  SELECT CHARINDEX('@', 'sam@sss.com')
    SELECT CHARINDEX('r', 'poojapradhan')

  --SUBSTRING('Expression','Start','length')
  Select * From String_Function

Select SUBSTRING('sim@dua.com', 5, 8)

Select SUBSTRING('sim@dua.com' , CHARINDEX ('@','sim@dua.com'), 8)

Select SUBSTRING('sim@dua.com' , CHARINDEX ('@','sim@dua.com') +1, 8)

 Select SUBSTRING('sim@dua.com' , CHARINDEX ('@','sim@dua.com') +1,
  LEN ('sim@dua.com') - CHARINDEX ('@','sim@dua.com'))
   
 Select SUBSTRING(Email,CHARINDEX('@', Email) + 1,
	LEN (Email) - CHARINDEX ('@', EMAIL)) as EmailDomain 
From String_Function


--Lecture-24 (part-2 of lecture -3)

REPLICATE,	SPACE,	PATINDEX,	REPLACE,	STUFF

--REPLICATE () FUNCTION
--REPLICATE(String_to_be_replicated, Number_of_times_to_replicate)
--example- mask the email with 5*(star) symbols

 select REPLICATE('POOJA',3)

 select * from String_Function
 Select firstname, Lastname,
 SUBSTRING(EMAIL,1,2) + REPLICATE('*',5) +
 SUBSTRING(EMAIL,CHARINDEX ('@', EMAIL), LEN(Email) - - CHARINDEX ('@', EMAIL) +1) as Email 
 From String_Function

 --Space () function 
 --Returns number of Spaces

 Select '       '
 Select SPACE (6)
 Select firstname + SPACE (5) + LastName as FullName 
  From String_Function

 --PATINDEX FUNCTION (PATTERN INDEX)
  Select Email, PATINDEX('%@sss.COM' , email) as Firstoccurence
    From String_Function

 Select Email, PATINDEX('%@sss.COM' , email) as Firstoccurence
    From String_Function
	Where PATINDEX('%@sss.COM' , email) >0

	--REPLACE Function
--REPLACE(String_expression,[attern,Repacement_Value)
--Replaces all occurances of  specified String value with another string alue
--Example- ram@bbb.com -->  ram@bbb.net
--.COM strings are replaced with .NET

Select * From String_Function


Select Email , REPLACE (Email, '.com', '.net') as convertedemail 
From String_Function

--STUFF Function
 
 Select Firstname, Lastname
	STUFF(Email, 2, 3, '*****') as stuffedEmail
From String_Function

--Lecture-25 ------(DATE time function)
-- data types,	functions, UTC time and ime zone offset
--(Coordinated Universal Time)

Date & Time In SQL, Listed Below
GetDate()
SysDateTime()
Current_TimeStamp
DateName()
DateDiff()
DateAdd()
DatePart()
Day()
Month()
Year()
IsDate()



SELECT * FROM table_DateTime
  
 INSERT INTO table_DateTime VALUES (GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE(), GETDATE() ) 

 SELECT GETDATE(), 'GETDATE()'
 SELECT SYSDATETIME(), 'SYSDATETIME()'
SELECT SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET()'
SELECT GETUTCDATE(), 'GETUTCDATE()'

--Lecture-26
--isDate,day,Month, Year and DateName

--isDate()- checks if the given value , is a valid date,time, or datetime. returns 1 for success, 0 for failure 
--note- For datetime2 vaSelect ISDATE('2022-12-01 ')  --RETURNS 1
lues. isdate returens ZERO.
--Examples;
Select ISDATE('POOJA')  --RETURNS 0
Select ISDATE(GETDATE())	--RETURNS 1
 Select ISDATE('2022-12-01 ')	--RETURNS 0



-- DAY, MONTH, YEAR functions

 --DAY()- Returns the 'day number of the month' of the given date
 Select Day(GETDATE()) --Returns current date
 Select Day('01-12-2022')

-- month()- Returns the 'month number of the year' of the given date
 Select Month(GETDATE())
  Select Month ('01-12-2022')

 --Year()- Returns the 'year number'  of the given date
Select Year(GETDATE())
  Select year ('01-12-2022')


  LECTURE 27
 --DATEPART, DATEADD AND DATEDIFF

 --DATEPART-(Datepart,date)- Returns an Intiger
 --This fnction is similar to DateName().
 --DateName returns Nvarchar, Where as Datepart returns an integer.

 --DATEADD(datepart, NumberToAdd,Date)- returns the Datetime

 --DATEDIFF(datepart,startdate,enddate) - 
 --Returns the count of the specified date part boundaries crossed between the specified start date and enddate


 --Examples:
Select DATEPART(weekday, '2012-08-30 ' ) -- returns 5
Select DATEPART(weekday, getdate()) as 'current year'; -- returns 5
Select DATEPART(YEAR, getdate()) as 'current year';



Select DATENAME(weekday, '2012-08-30 19:45:31.793') -- returns Thursday
select DATENAME (MONTH,GETDATE());
 SELECT DATENAME (YEAR,G
 ETDATE());
 SELECT DATENAME (DAY,GETDATE());
  SELECT DATENAME (HOUR,GETDATE());

--DATEADD (datepart, NumberToAdd, date) - Returns the DateTime, after adding specified NumberToAdd, to the datepart specified of the given date.

--Examples:
Select DateAdd(DAY, 20, '2012-08-30 19:45:31.793') 
-- Returns 2012-09-19 19:45:31.793
Select DateAdd(DAY, -20, '2012-08-30 19:45:31.793') 
-- Returns 2012-08-10 19:45:31.793
Select DateAdd(DAY, 20, GETDATE()) 
Select DateAdd(DAY, -5, GETDATE() ) 


--DATEDIFF(datepart, startdate, enddate) - Returns the count of the specified datepart boundaries crossed between the specified startdate and enddate.

Examples:
Select DATEDIFF(MONTH, '11/30/2005','01/31/2006') -- returns 2
Select DATEDIFF(DAY, '11/30/2005','01/31/2006') -- returns 62
Select DATEDIFF(YEAR, '11/30/2005','01/31/2006') -- returns 1
Select DATEDIFF(YEAR, '11/30/2005',GETDATE())
Select DATEDIFF(HOUR, '01/06/2022','12/12/2022')

CREATE FUNCTION fnComputeAge(@DOB DATETIME)
RETURNS NVARCHAR(50)
AS
BEGIN

DECLARE @tempdate DATETIME, @years INT, @months INT, @days INT
SELECT @tempdate = @DOB

SELECT @years = DATEDIFF(YEAR, @tempdate, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END
SELECT @tempdate = DATEADD(YEAR, @years, @tempdate)

SELECT @months = DATEDIFF(MONTH, @tempdate, GETDATE()) - CASE WHEN DAY(@DOB) > DAY(GETDATE()) THEN 1 ELSE 0 END
SELECT @tempdate = DATEADD(MONTH, @months, @tempdate)

SELECT @days = DATEDIFF(DAY, @tempdate, GETDATE())

DECLARE @Age NVARCHAR(50)
SET @Age = Cast(@years AS  NVARCHAR(4)) + ' Years ' + Cast(@months AS  NVARCHAR(2))+ ' Months ' +  Cast(@days AS  NVARCHAR(2))+ ' Days Old'
RETURN @Age

End

/* Using the function in a query to get the expected output along with the age of the person.
Select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from tblEmployees
Email ThisBlogThis!Share to TwitterShare to FacebookShare to Pinterest
*/


Lecture-28


/* To convert one data type to another, CAST and CONVERT functions can be used. 

Syntax of CAST and CONVERT functions from MSDN:

CAST ( expression AS data_type [ (length) ] )
CONVERT ( data_type [ ( length ) ] , expression, [ style ] )

From the syntax, it is clear that CONVERT() function has an optional style parameter, where as CAST() function lacks this capability.
The following 2 queries convert, DateOfBirth's DateTime datatype to NVARCHAR. The first query uses the CAST() function, and the second one uses CONVERT() function. The output is exactly the same for both the queries as shown below. */

select cast(26.46 as int);
select convert(int,26.46);
 
 select * from castandconvert
select  name +'-'+   cast(dateofbirth as nvarchar) 
from  castandconvert
select  name +'-'+   cast(dateofbirth as nvarchar) as ConvertedDOB 
from  castandconvert

Select  Name + '' +  Convert(nvarchar, DateOfBirth) as ConvertedDOB
from castandconvert


--Now, let's use the style parameter of the CONVERT() function, to format the Date as we would like it. In the query below, we are using 103 as the argument for style parameter, which formats the date as dd/mm/yyyy.
Select Name +''+ Convert(nvarchar, DateOfBirth, 103) as ConvertedDOB
from castandconvert
--To get just the date part, from DateTime
SELECT CONVERT(VARCHAR(10),GETDATE(),101)


SELECT CAST(GETDATE() as DATE)
SELECT CONVERT(DATE, GETDATE())

--Note: To control the formatting of the Date part, DateTime has to be converted to NVARCHAR using the styles provided. When converting to DATE data type, the CONVERT() function will ignore the style parameter.


--Lecture-29
---Mathematical function in SQL server
--Abs, Ceiling, Floor, Power, Rand, Square, Sqrt, and Round functions

--ABS ( numeric_expression ) - ABS stands for absolute and returns, the absolute (positive) number. 

--For example,
Select ABS(-101.5) -- returns 101.5, without the - sign.

--CEILING ( numeric_expression ) and FLOOR ( numeric_expression )

Select CEILING(15.2) -- Returns 16
Select CEILING(-15.2) -- Returns -15

Select FLOOR(15.2) -- Returns 15
Select FLOOR(-15.2) -- Returns -16

Select POWER(2,3) -- Returns 8

Select RAND(1) -- Always returns the same value

If you want to generate a random number between 1 and 100, RAND() and FLOOR() functions can be used.

Select FLOOR(RAND() * 100) --generate a random number between 1 and 100
--prints 10 random numbers between 1 and 100.
Declare @Counter INT
Set @Counter = 1
While(@Counter <= 10)
Begin
 Print FLOOR(RAND() * 100) 
 Set @Counter = @Counter + 1
End

Select SQUARE(9) -- Returns 81
Select SQRT(81) -- Returns 9


--ROUND ( numeric_expression , length [ ,function ] )
-- Round to 2 places after (to the right) the decimal point
Select ROUND(850.556, 2) -- Returns 850.560

--- Part 30 - User Defined Functions (UDF) in sql server - Part 30

/* In SQL Server there are 3 types of User Defined functions
1. Scalar functions
2. Inline table-valued functions
3. Multistatement table-valued functions



---------1. Scalar functions
Scalar functions may or may not have parameters, but always return a single (scalar) value.
Scalar functions can be used  anywhere in T-SQL statements.
Scalar functions accept one or more parameters but return only one value, therefore, they must include a RETURN statement.
Scalar functions can use logic such as IF blocks or WHILE loops.
Scalar functions cannot update data. They can access data but this is not a good practice.
Scalar functions can call other functions

To create a function, we use the following syntax:

CREATE FUNCTION Function_Name(@Parameter1 DataType, @Parameter2 DataType,..@Parameter Datatype)
RETURNS Return_Datatype
AS
BEGIN
    Function Body
    Return Return_Datatype
END */

--create a function without parameter
create function showmessage()
returns nvarchar(100)
as
begin
	return 'welcome to functions'
end

select dbo.showmessage()

example-2
create function shownumber()
returns int
as
begin
	return '6'
end

select dbo.shownumber()


---create a function with a single parameter
create function Takeanumber (@num as int)
returns int
as
begin
	return (@num * @num)
end
select dbo.Takeanumber(5);


---create a function with a multiple parameter

create function Addition (@num1 as int, @num2 as int )
returns int
as
begin
	return (@num1 + @num2)
end
--output
select dbo.Addition(5,8);
select dbo.Addition(20,30);

create  function substract (@num1 as int , @num2 as int )
returns int
begin
	return (@num1 -@num2)
end

select dbo.substract (2347,1263);

select dbo.Addition(5,8);
select dbo.Addition(20,30);
 
 ---Alter a function
 create function Takeanumber (@num as int)
returns int
as
begin
	return (@num * @num)
end

ALTER function Takeanumber (@num as int)
returns int
as
begin
	return (@num * @num * @num)
end
select dbo.Takeanumber(2);
select dbo.Takeanumber(12);

--drop a function
drop function Takeanumber

-- Example No: 4 - Checking Voter's Age
create function CheckVoterAge(@age as int)
returns nvarchar(50)
as
begin
	declare @str nvarchar(100)
	if @age >= 18
	begin
	set @str = 'You are eligible to vote'
	end
	else
	begin
	set @str = 'You are not eligible to vote'
	end
	return @str
end

select dbo.CheckVoterAge(16);
select dbo.CheckVoterAge(18);



LECTURE =31
--Inline table valued functions - Part 31
/*
Scalar Function:
It returns a Scalar Value
Inline Table Valued Function:
It returns a Table

Follow The Steps To Create Inline Table Valued Function.
Step 1:
We have to specify TABLE as the return type, instead of any scalar data type like int, varchar etc

Step 2:
There is no BEGIN and END Blocks.

Step 3:
The table that gets returned, is determined by the SELECT command within the function

*/
/* Syntax for creating an inline table valued function
CREATE FUNCTION Function_Name(@Param1 DataType, @Param2 DataType..., @ParamN DataType)
RETURNS TABLE
AS
RETURN (Select_Statement)

*/

--Create a function that returns EMPLOYEES by GENDER.

--create a function without parameter

Select * from Multi_Statementtable
create function fn_multistatement()
returns table
as
return (Select * from Multi_Statementtable)

Select * from fn_multistatement();



	--Difference between Inline and Multi-Statement
	--Example-

 --Inline Table Valued function(ILTVF):

Create Function fn_ILTVF_GetEmployees()
Returns Table
as
Return (Select Id, Name, Cast(DateOfBirth as Date) as DOB
        From tblEmployees)


-- Multi-statement Table Valued function(MSTVF): -- not get right answer from this lecture

--inline table-valued functions	      -- differences --         Multi-statement table-valued functions

In this inline function, the returns clause cannot contain the structure of the table.	
In this table function, we specify the structure of the table with returns clause.

In this, there are no BEGIN and END blocks.	
In this, we have to use BEGIN and END blocks.

Inline table-valued functions are better in performance as compared to multi statement table-valued functions.
There is no performance advantage in multi statement table-valued functions.

Internally, Inline table-valued function much like it would a view.	
Internally, multi statement table-valued function much like it would a stored procedure.

Select * from Multi_Statementtable

Create Function fn_MSTVF_GetEmployees()
Returns @Table Table (Id int, Name nvarchar(20), DOB Date)
as
Begin
 Insert into @Table
 Select Id, Name, Cast(DateOfBirth as Date)
 From tblEmployees
 
 Return
End 
select * from [dbo].[fn_MSTVF_GetEmployees] (1);

--LECTURE- 33
--Important concepts related to Functions 

sELECT count (*) from Multi_Statementtable
Select getdate ()
select square (3)

/* Deterministic(Aggregate) and Nondeterministic Functions:
Deterministic functions always return the same result any time they are called with a specific set of input values and given the same state of the database. 
Examples: Sum(), AVG(), Square(), Power() and Count()

Note: All aggregate functions are deterministic functions.

Nondeterministic functions may return different results each time they are called with a specific set of input values even if the database state that they access remains the same.
Examples: GetDate() and CURRENT_TIMESTAMP

Rand() function is a Non-deterministic function, but if you provide the seed value, the function becomes deterministic, as the same value gets returned for the same seed value.
*/

--LECTURE-34
--Temporary tables 
---What are Temporary tables?
--Temporary tables, are very similar to the permanent tables.
Permanent tables get created in the database you specify, and remain in the database permanently, 
until you delete (drop) them. On the other hand, 
temporary tables get created in the TempDB and are automatically deleted, when they are no longer used.

--Types of Temporary tables- Local Temporary tables 
							--Global Temporary tables.
 
--Local Temporary tables-----
syntax
CREATE TABLE #EmpDetails 
(
id INT, 
name VARCHAR(25)
) 


Create Table #PersonDetails
(Id int, 
Name nvarchar(20)
)
--Check local temporaray is created
select name from tempdb..sysobjects
Where name like '#persondetails%'
--formula 2
select name from tempdb..sysobjects
Where name like '%persondetails%'

--Insert Data into the temporary table:
Insert into #PersonDetails Values(1, 'Mike')
Insert into #PersonDetails Values(2, 'John')
Insert into #PersonDetails Values(3, 'Todd')

Select * from #PersonDetails



 --the temporary table, is created inside the stored procedure
 Create Proc spCreateLocalTempTable
as
Begin
Create Table #PersonDetails(Id int, Name nvarchar(20))

Insert into #PersonDetails Values(1, 'Mike')
Insert into #PersonDetails Values(2, 'John')
Insert into #PersonDetails Values(3, 'Todd')

Select * from #PersonDetails
End
spCreateLocalTempTable
--Global Temporary Table:
Create Table ##EmployeeDetails
(Id int, 
Name nvarchar(20)
 )
 Insert into ##PersonDetails Values(1, 'Mike')
Insert into ##PersonDetails Values(2, 'John')
Insert into ##PersonDetails Values(3, 'Todd')

--How to Create a Global Temporary Table:
--To create a Global Temporary Table, prefix the name of the table with 2 hash symbols (##). EmployeeDetails Table is the global temporary table, as we have prefixed it with 2 ## symbols.

/*
LOCAL TEMPORARY TABLES	   difference         GLOBAL TEMPORARY TABLES

In SQL Server, We have Single # Symbol before the name of local temporary table.	
In SQL Server, To create the global temporary table, use 2 (##) hash symbols before the name of the table.

SQL Server appends some random numbers at the end of the local temp table.
SQL Server did not appends random numbers at the end of the global temp table.

In SQL Server, Local temporary tables are only visible to that connection / session of the SQL server which has created it.
In SQL Server, Global temp tables are visible to all SQL Server connections / sessions.

In SQL Server, We can create the local temporary table with same name in different connections	In SQL Server,
We cannot create the global temporary table with same name in different connections.
*/
--lecture 35

--------------------------------------------------------------------------------------------------------------
indexes?

--Indexes are used by queries to find data from tables quickly. 
--Indexes are created on tables and views.
-- Index on a table or a view,
--is very similar to an index that we find in a book.
---When should indexes be avoided?

Indexes should not be used on small tables.
Tables that have frequent, large batch updates or insert operations.
Indexes should not be used on columns that contain a high number of null values.

select * from indexemployesalary

create index index_employe_salary
on indexemployesalary (salary ASc)

create index ix_employe_salary
on indexemployesalary (salary desc);


Sp_helpindex indexemployesalary;

select * from indexemployesalary
where salary >1000 and salary <22000;

DROP INDEX indexemployesalary.index_employe_salary


--LECTURE -36
--Clustered and Non-Clustered indexes

--Clustered Index:
--A clustered index determines the physical order of data in a table.
--For this reason, a table can have only one clustered index.

CREATE TABLE [clusterd_Index]
(
[id] int primary key,
[NAME] nvarchar(50),
[SALARY] int,
[GENDER] nvarchar(10),
[CITY] nvarchar(50)
)

insert into clusterd_Index VALUES (3,'john',4500,'male','NEWYORK')
Insert into clusterd_Index Values(4,'Sara',5500,'Female','Tokyo')
Insert into clusterd_Index Values(5,'Todd',3100,'Male','Toronto')
Insert into clusterd_Index Values(2,'Pam',6500,'Female','Sydney')

Select * from clusterd_Index

--to create a composite clustered Index on the Gender and Salary columns.
Create Clustered Index IX_Employee_Gender_Salary
ON clusterd_Index (Gender DESC, Salary ASC)

Select * from clusterd_Index


--Non Clustered Index:

--The following SQL creates a Nonclustered index on the NAME column on tblEmployee table:
Create NonClustered Index IX_tblEmployee_Name
ON tblEmployee(Name)
/*Difference between Clustered and NonClustered Index:
1. Only one clustered index per table, where as you can have more than one non clustered index
2. Clustered index is faster than a non clustered index, because, the non-clustered index has to refer back to the table,
if the selected column is not present in the index.
3. Clustered index determines the storage order of rows in the table, 
and hence doesn't require additional disk space,
but where as a Non Clustered index is stored seperately from the table, additional storage space is required.
*/

--LECTURE -37    skip
--Unique and Non-Unique Indexes - Part 37
--Unique index is used to enforce uniqueness of key values in the index. Lets understand this with an example.

--Create the Employee table using the script below
CREATE TABLE [tblEmployee]
(
 [Id] int Primary Key,
 [FirstName] nvarchar(50),
 [LastName] nvarchar(50),
 [Salary] int,
 [Gender] nvarchar(10),
 [City] nvarchar(50)
)
--differences-

--1. By default, a PRIMARY KEY constraint, creates a unique clustered index, where as a UNIQUE constraint creates a unique nonclustered index.These defaults can be changed if you wish to.

2--. A UNIQUE constraint or a UNIQUE index cannot be created on an existing table, if the table contains duplicate values in the key columns. Obviously, to solve this,remove the key columns from the index definition or delete or update the duplicate values.

--3. By default, duplicate values are not allowed on key columns, when you have a unique index or constraint. For, example, if I try to insert 10 rows, out of which 5 rows contain duplicates, then all the 10 rows are rejected. However, if I want only the 5 duplicate rows to be rejected and accept the non-duplicate 5 rows, then I can use IGNORE_DUP_KEY option. An example of using IGNORE_DUP_KEY option is shown below.

CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY

--LECTURE -38

--Advantages and disadvantages of indexes 
--Advantages
--The following select query benefits from the index on the Salary column, because the salaries are sorted in ascending order in the index. From the index, it's easy to identify the records where salary is between 4000 and 8000, and using the row address the corresponding records from the table can be fetched quickly.

Select * from tblEmployee where Salary > 4000 and Salary < 8000

--Not only, the SELECT statement, even the following DELETE and UPDATE

Delete from tblEmployee where Salary = 2500
Update tblEmployee Set Salary = 6500 where Salary = 6000

--Indexes can also help queries
Select * from tblEmployee order by Salary

--The index on the Salary column, can also help the query below, by scanning the index in reverse order.
Select * from tblEmployee order by Salary Desc


--GROUP BY queries can also benefit from indexes
Select Salary, COUNT(Salary) as Total
from tblEmployee
Group By Salary

--Diadvantages of Indexes:

--Additional Disk Space: Clustered Index does not, require any additional storage. 
Every Non-Clustered index requires additional space as it is stored separately from the table.
The amount of space required will depend on the size of the table, and the number and types of columns used in the index.

--Insert Update and Delete statements can become slow: When DML (Data Manipulation Language)
statements (INSERT, UPDATE, DELETE) modifies data in a table, the data in all the indexes also 
needs to be updated. Indexes can help, to search and locate the rows, that we want to delete, 
but too many indexes to update can actually hurt the performance of data modifications.


--What is a covering query?
If all the columns that you have requested in the SELECT clause of query, 
are present in the index, then there is no need to lookup in the table again.
The requested columns data can simply be returned from the index.

--A clustered index, always covers a query, since it contains all of the data in a table.
A composite index is an index on two or more columns. Both clustered and nonclustered indexes can be composite indexes.
To a certain extent, a composite index, can cover a query.
-----------------------------------------------------------------------------------------------------------------------
--LECTURE -39

--What is a View?
--A view is nothing more than a saved SQL query.
--  A view can also be considered as a virtual table.

--agar hume client ko comapny details dena ho ,
at the point of time we cannot give all details of table like salary and income so,
here we just need to create VIEW and usme table ka only required  column add krke client ko show krenge 

create table ViewEmploye
(
DepartmentId int Primary key,
DepartmentName nvarchar (50)
)

INSERT  INTO ViewEmploye values (1,'IT')
INSERT INTO ViewEmploye VALUES (2,'Payroll')
INSERT INTO ViewEmploye VALUES (3,'HR')
INSERT INTO ViewEmploye VALUES (4, 'ADMIN')

CREATE TABLE viewDepartment
(
Id int Primary key,
Name nvarchar(50),
salary INT ,
gender nvarchar(10),
DepartmentId int 
)

INSERT INTO viewDepartment VALUES (1, 'POOJA', 5000, 'F',3)
INSERT INTO viewDepartment VALUES (2,'CHITRA', 8000, 'F', 2)
Insert into viewDepartment values (3,'John', 7000, 'Male', 1)
Insert into viewDepartment values (4,'Mike', 3400, 'Male', 4)
Insert into viewDepartment values (5,'Pam', 6000, 'Female', 1)

SELECT *FROM ViewEmploye 
SELECT * FROM viewDepartment
 
 example-1
 create view view_foremployees
 as 
 select * from ViewEmploye AS A
 inner join viewDepartment AS B
 on B.Id = A.departmentId; 

 select * from view_foremployees

--example-2
create view viewemploye_department
as
Select Id, Name, Salary, Gender, DepartmentName
from viewDepartment
join ViewEmploye
on viewDepartment.DepartmentId = ViewEmploye.DepartmentId

Select * from viewemploye_department

--Advantages of using views:

 --Views can be used to reduce the complexity of the database schema, for non IT users. 
 The sample view, vWEmployeesByDepartment, 
 hides the complexity of joins. Non-IT users, finds it easy to query the view, rather than writing complex joins.

 --Views can be used as a mechanism to implement row and column level security.
Row Level Security:


--LECTURE -40 Updateable Views - Part 40

 
 /*Is it possible to Insert, Update and delete rows, from the underlying tblEmployees table, 
 using view vWEmployeesDataExceptSalary?
Yes, SQL server views are updateable. */

--the conclusion - If a view is based on multiple tables, and if you update the view, 
it may not update the underlying base tables correctly.
To correctly update a view, that is based on multiple table, INSTEAD OF triggers are used.

--LECTURE-41 Indexed views 
--SKIPPED


--LECTURE-42 Limitations OF Views

--1. You cannot pass parameters to a view. 
--2. Rules and Defaults cannot be associated with views.

--3. The ORDER BY clause is invalid in views unless TOP or FOR XML is also specified.
--4. Views cannot be based on temporary tables.
-- Error: Cannot create a view on Temp Tables


--Lecture- 43 TRIGGERS (practical not clear)

In SQL server there are 3 types of triggers
1. DML triggers 
2. DDL triggers
3. Logon trigger
/*
1. (DML)- statemen like  - DELETE , INSERT OR UPDATE
2. (DDL) - CREATE , ALTER, DROP
3. DATABASE OPERATION - LOGON, LOGOFF, STARTUP, SHUTDOWN
*/ 

Benefit of triggers
1. security
2.Referential integrity (Constraint)
3. Event logging and storing information on table access
4.Auditing
5. Synchronous replication of tables
6. preventing invalid transacion


--1. DML triggers 
--DML stands for Data Manipulative Language. INSERT, UPDATE, and DELETE statements are DML statements. DML triggers are fired, when ever data is modified using INSERT, UPDATE, and DELETE events

--DML triggers can be again classified into 2 types.
--1. After triggers (Sometimes called as FOR triggers)
--2. Instead of triggers


--After triggers, 
--as the name says, fires after the triggering action. The INSERT, UPDATE, and DELETE statements, causes an after trigger to fire after the respective statements complete execution.
--INSTEAD of triggers,
--fires instead of the triggering action. The INSERT, UPDATE, and DELETE statements, can cause an INSTEAD OF trigger to fire INSTEAD OF the respective statement execution.


create table Tbl_Student

(
Id int Primary key,
Name nvarchar (50),
Gender nvarchar (10),
class int,
fees nvarchar (10)
)

INSERT INTO Tbl_Student VALUES (1, 'POOJA', 'F', 10, 4000);
INSERT INTO Tbl_Student VALUES (2, 'CHITRA', 'F', 8, 5000);
INSERT INTO Tbl_Student VALUES (3, 'MITRA', 'M', 10, 6000);
INSERT INTO Tbl_Student VALUES (4, 'CHITA', 'F', 5, 9000);
INSERT INTO Tbl_Student VALUES (5, 'ITRA', 'M', 9, 12000);
INSERT INTO Tbl_Student VALUES (6, 'TARA', 'M', 8, 2000);
INSERT INTO Tbl_Student VALUES (7, 'mARA', 'f', 9, 3000);

 SELECT * FROM Tbl_Student
 update Tbl_Student set name = 'Alisha', gender ='male'
 where id = 5;
 create table Tbl_Student_audit
 (audit_id int primary key, audit_info nvarchar(
 ));
 select * from Tbl_Student_audit
   
  create trigger Tbl_Student_audit_forinsert
  on Tbl_Student
  after insert
  as
 begin
	declare @id int
	select @id= id from inserted

	insert into Tbl_Student_audit 
	values ('student with id' + cast(@id as varchar(50)) + 'is added at' +  cast (getdate()  as varchar(50)) );
end

 delete from Tbl_Student where id = 1;

 create TRIGGER tR_student_fordelete
 on Tbl_Student
 after delete
 as
 begin
   select *from deleted
 end
   
  create TRIGGER tR_student_forupdate
 on Tbl_Student
 after update
 as
 begin
   select *from deleted
   select *from update

 end


 --Trigger example- interview

 create table Main
 (id int,
 salary int);

 insert into main values (1,1000);
 insert into main values(2,2000);

 create table Back_up
 (
 id int,
 salary int
 )

  select * from back_up
  -----------------------------------

 create  trigger t1
 before delete on main
 for each row
 begin
	Insert into back_up values (old.id, old.salary);
 end;

 delete form main where id = 1

 -------------------------------------- Example-  
 Select * from Employee_Tbl





 Part -2
 --DML instead of triggers--
  -------------------------------

  create table Tbl_customer
(
Id int Primary key,
Name nvarchar (50),
Gender nvarchar (10),
City nvarchar (10), 
ContactNo nvarchar(11) 
)

INSERT INTO Tbl_customer VALUES (1, 'POOJA', 'F', 'Surat', '1237864647');
INSERT INTO Tbl_customer VALUES (2, 'CHITRA', 'F', 'mumbai', '7643264244');
INSERT INTO Tbl_customer VALUES (3, 'MITRA', 'M', 'raipur', '635242152');
INSERT INTO Tbl_customer VALUES (6, 'TARA', 'M', 'kashmir', '1235646566');

Select * from Tbl_customer

create trigger tr_customer_insteadof_insert
on Tbl_customer
insted of update
as
Begin
	print 'you are not allowed to update in this table' 
end
update Tbl_customer set name= 'asif' where id= 6;

--

--CTE IN SQL – PART-1---------

/* A CTE allows you to define a temporary result set, that can be linked immediately with the select, insert, update or delete statement.
CTE is similar to a temporary resultset defined within the execution scope of a single SELECT, INSERT, UPDATE, DELETE, or CREATE VIEW statement.
The CTE can also be used in a View.
A CTE is defined at the start of a query and can be referenced several times in the outer query.
Key advantages of CTEs are improved readability and ease in maintenance of complex queries.
*/

--Syntax Of Defining CTE------
WITH expression_name (column1, column2, ……)  
AS 
(
CTE_definition
) 
SQL_statement;

 


-- EXAMPLE NO: 1
with New_CTE
as
(
 select * from student where gender = 'Male'
)
select * from New_CTE

-- EXAMPLE NO: 2
with New_CTE
as
(
 select * from student where gender = 'Male'
)
select count(*) from New_CTE

-- EXAMPLE NO: 3
with New_CTE
as
(
 select * from student where gender = 'Male'
)
--select 'Hello World'
select * from New_CTE where age >= 17

-- EXAMPLE NO: 4 - WITH COLUMNS
with New_CTE(std_id, std_name, std_class)
as
(
 select id, name, [standard] from student where gender = 'Male'
)
select std_id, std_name from New_CTE

-- EXAMPLE NO: 5
with New_CTE
as
(
 select * from student
)
select * from New_CTE

-- EXAMPLE NO: 6 - CTE WITH INSERT UPDATE DELETE
with New_CTE
as
(
 select * from student
)
delete New_CTE where id = 18
update New_CTE set name = 'Zain' where id = 18
insert New_CTE values('Afaq','Male',15,8)

-- EXAMPLE NO: 7 - CREATING VIEW USING CTE
create view vWMyNewView
as
with New_CTE
as
(
 select * from student where [standard] = 12
)
select * from New_CTE

select * from vWMyNewView;

-- CREATING MULTIPLE CTES USING SINGLE WITH CLAUSE
with New_CTE
as
(
 select * from student where [standard] = 12
),
New_CTE2
as
(
 select * from student where [standard] = 11
)
select * from New_CTE
union all
select * from New_CTE2

with New_CTE
as
(
 select count(*) as [Total_Male_Students] from student where gender = 'Male'
)
select * from New_CTE

---------COMMON TABLE EXPRESSION--------- (CTE)


/*

What Is Database Normalization ?

Normalization plays a vital role in database management system,
database normalization is the process of organizing data to minimize data 
redundancy (data duplication) which leads to data in consistency.

Disadvantages of Data Redundancy
Disk space wastage
Data inconsistency
DML (Data Manipulation Language) insert update delete queries can become slow

Database normalization is a step by step process. There are 6 normal forms,


First normal form (1nf) to sixth normal form (6nf). Most databases are in third normal form (3nf).
There are certain rules, that each normal form should follow.

-----First Normal Form (1nf) Of Database Normalization

A table is said to be in first normal form, if:

The data in each column should be ATOMATIC , no multiple values seperated by comma.
The table does not contain any repeating column groups.
Identify each record uniquely using primary key.

-------Second Normal Form (2nf) Of Database Normalization

The table is said to be in 2nf, if:

The table meets all the conditions of first normal form.
There are no partial dependencies in the table.
Partial dependency means a non-key attribute should not be partially dependent on more than one key attribute.
Move redundant data to a separate table.
Create relationships between these tables using foreign keys.
Before Applying Second Normal Form

------Third Normal Form (3nf) of Normalization 

A table is said to be in third normal form, if:

Meets all the conditions of first normal form and second normal form.
The tables should not have transitive dependencies in them.
Does not contain columns (attributes) that are not fully dependent on the primary key.
If an attribute can be determined by another non-key attribute, it is called a transitive dependency.
To make it simpler, every non-key attribute should be determined by the key attribute only.
If a non-key attribute can be determined by another non-key attribute, it needs to put into another table.

*/
-----------------------------------------------------------------------------------------------------------------------------------
----Transaction----

create table Studebt_tbl
(
Id int primary key,
Name nvarchar(50),
Age int,
Class int
)

insert into Studebt_tbl values (1,'pooja', 15,7)
insert into Studebt_tbl values (2, 'chitra', 16,6)
insert into Studebt_tbl values (3,'kkk', 17,8)
insert into Studebt_tbl values (4,'rrr', 12,5)
insert into Studebt_tbl values (5,'ttt', 14,4)
insert into Studebt_tbl values (6,'kunal', 18,6)

Select * from Studebt_tbl;

update Studebt_tbl set name = 'rohi' where Id = 4; ---Implicit transaction

Begin Transaction	--- Explicit transaction
update Studebt_tbl set name  = 'Urvi' where Id = 3;
Delete from Studebt_tbl where id = 5

Rollback transaction;  ----undo


commit transaction; -- permanent save in table
/*
TRANSACTION IN SQL SERVER
A transaction is a single unit of work.

A transaction in SQL Server is successful only when all data modifications that are made in a transaction are committed and are saved in the database permanently.

If the transaction is rolled back or cancelled, then it means that the transaction has encountered errors and there are no changes made to the contents of the database.

A transaction can be either committed or rolled back.

TCL (TRANSFER CONTROL LANGUAGE) COMMIT, ROLLBACK, SAVEPOINT.

------------Defining Transactions

A logical unit of work must exhibit four properties,
called the atomicity, consistency, isolation, and durability (ACID) properties, to qualify as a transaction in SQL Server.

--Atomicity: If the transaction has many operations then all should be committed. It means ALL or NONE. It manages by Transaction Manager. Example of 2 accounts. A —- B

--Consistency: (Before transaction start and after the transaction completed SUM of money  shoud be same )
The sequence of operations must be consistent.

A = 3000, B = 4000 = 7000 – before transaction
A = 3000 – 1000 = 2000
B = 4000 + 1000 = 5000
--Isolation: The operations that are performed must be isolated from the other operations on the same server or on the same database. 
means each transaction must be executed without knowing what is happening to other transactions.
--Durability: The operations that are performed on the database must be saved and stored in the database permanently.
STATES OF TRANSACTION

When a transaction is started on a connection, all TransactSQL statements are executed on the same 
connection and are a part of the connection until the transaction ends.

Transactions are managed at the connection level.
Setting the isolaton level to read uncommited by default its read commited.
SYNTAX: SET TRANSACTION ISOLATION LEVEL READ UNCOMMITED.

--2 Types Of Transactions
Explicit Transactions: Every transaction explicitly starts with the BEGIN TRANSACTION statement
and ends with a ROLLBACK or COMMIT transaction.
Implicit Transactions: When you cannot rollback any transaction and your transaction is automatically committed by sql server engine.
*/


---------------------------------------TRY , CATCH OR ERROR HANDLING in T-SQL---------------------


Select * from Studebt_tbl;

begin try
	Select 10/0
end try

begin catch
	 print 'you cannot devide any number  by zero'
end catch
-------------------

begin try
	update Studebt_tbl set age  = 'abc' where Id = 1
end try

begin catch
	 print 'you cannot insert strings into integer column';
end catch

-- Retrieving Error information
--CATCH block

ERROR_NUMBER()
ERROR_SEVERITY()
ERROR_STATE()
ERROR_PROCEDURE()
ERROR_LINE()
ERROR_MESSAGE()

--ERROR INFORMATION CAN BE  retrieved by using  these functions from anywhere within the sco

----------------------------------------------------------------------------------------------------------------------------------

-------------COORELATED SUBQUERY ( SYNCHRONIZED QUERY)

1 it is a subquery that uses from outer query
2-TOP to DOWN approach

Example- 
find all employees detail who work in a department.
-- syntax
Select from emp where exists (select * from dept where dept.eid= emp.eid);


-------------------Difference between NESTED SUBQUERY,CORELATED SUBQUERY, JOINS------------

CREATE TABLE Employi
(
Employ_ID int primary key,
name nvarchar(50)
)

insert into Employi values(1, 'aaa')
insert into Employi values(2, 'bbb')
insert into Employi values(3, 'ccc')
insert into Employi values(4, 'ddd')
insert into Employi values(5, 'eee')

create table Department_
(
dept_no nvarchar (5),
name nvarchar (10),
Employ_ID int
)

insert into Department_ values ('D1',  'IT' , 1)
insert into Department_ values ('D2',  'HR' , 2)
insert into Department_ values ('D3',  'mrkt' , 3)

select * from Employi
select * from Department_

------Example of NESTED SUBQUERY
----- BUTTOM UP

select * from Employi
where Employ_ID in
 (select Employ_ID from Department_)

------Example of CORELATED SUBQUERY
---TOP DOWN APPROACH

select * from Employi where exists (select Employ_ID from Employi where Employi.Employ_ID = Department_.Employ_ID );

------Example of JOIN
------CROSS PRODUCT + CONDITION
 
 -----------------------------------------------------------------------------------------------------------
 ------------------------------------------Cursor--------------------------------------


/* What Is Cursor In SQL Server ???
Cursor is a Temporary Memory or Temporary Work Station.
A SQL cursor is a database object that is used to retrieve data from a result set one row at a time.

 Use of Cursor In SQL ??
A SQL cursor is used when the data needs to be updated row by row.
It is Allocated by Database Server at the Time of Performing DML operations on Table by User.
Cursors are used to store Database Tables.
It allows you to process individual row returned by a query.

Types of Cursors in SQL
There are the following two types of cursors in SQL:

1.Implicit Cursor
Implicit Cursors are also known as Default Cursors of SQL SERVER. These Cursors are allocated by SQL SERVER when the user performs DML operations.

2.Explicit Cursor
Explicit Cursors are Created by Users whenever the user requires them. Explicit Cursors are used for Fetching data from Table in Row-By-Row Manner.

Methods Of Cursor ??
1.Next
2.Prior
3.First
4.LastRR
5.Absolute n
6.Relative n

The following steps are involved in a SQL cursor life cycle.
1.Declaring Cursor
2.Opening Cursor
3.Fetching Cursor
4.Closing Cursor
5.De-allocating Cursor

We can use Cursors in 2 Ways.
1.With Cursor Variables
2.Without Cursor Variables

*/

-- EMPLOYEE TABLE CREATE QUERY

create table cursur_pooja
(
Id int primary key,
name nvarchar (50),
joiningdate datetime null 
)

insert into cursur_pooja values (1, 'aaa', '12-02-12 01:26:43')
insert into cursur_pooja values (2, 'pooja', '04-04-06 12:32:05')
insert into cursur_pooja values (3, 'chitra', '02-04-04 12:32:05')
insert into cursur_pooja values (4, 'cacc', '09-12-04 12:32:05')
insert into cursur_pooja values (5, 'efcd', '03-04-04 12:32:05')
insert into cursur_pooja values (6, 'dvfrtg', '06-04-04 12:32:05')

select* from cursur_pooja

declare Mycursor cursor scroll for select* from cursur_pooja
open Mycursor
fetch next from Mycursor
fetch first from Mycursor
fetch prior from Mycursor
fetch last from Mycursor
fetch relative 2 from Mycursor
fetch absolute -1 from Mycursor
close Mycursor
deallocate Mycursor

-- with Cursor Variables
declare myCursor cursor scroll for select id, name from cursur_pooja
declare @emp_id int, @emp_name varchar(50)
open myCursor
fetch first from myCursor into @emp_id, @emp_name
print 'Employee is: ' + cast(@emp_id as varchar(50)) + ' ' + @emp_name

fetch next from myCursor into @emp_id, @emp_name
print 'Employee is: ' + cast(@emp_id as varchar(50)) + ' ' + @emp_name

fetch last from myCursor into @emp_id, @emp_name
print 'Employee is: ' + cast(@emp_id as varchar(50)) + ' ' + @emp_name

fetch prior from myCursor into @emp_id, @emp_name
print 'Employee is: ' + cast(@emp_id as varchar(50)) + ' ' + @emp_name

fetch absolute 4 from myCursor into @emp_id, @emp_name
print 'Employee is: ' + cast(@emp_id as varchar(50)) + ' ' + @emp_name

fetch relative -1 from myCursor into @emp_id, @emp_name
print 'Employee is: ' + cast(@emp_id as varchar(50)) + ' ' + @emp_name

close myCursor
deallocate myCursor


----------------------------------------------------------------------------------------------------------------------------
--------------------Pivot operator-----------------------
Create Table tblProductSales
(
 SalesAgent nvarchar(50),
 SalesCountry nvarchar(50),
 SalesAmount int
)

Insert into tblProductSales values('Tom', 'UK', 200)
Insert into tblProductSales values('John', 'US', 180)
Insert into tblProductSales values('John', 'UK', 260)
Insert into tblProductSales values('David', 'India', 450)
Insert into tblProductSales values('Tom', 'India', 350)
Insert into tblProductSales values('David', 'US', 200)
Insert into tblProductSales values('Tom', 'US', 130)
Insert into tblProductSales values('John', 'India', 540)
Insert into tblProductSales values('John', 'UK', 120)
Insert into tblProductSales values('David', 'UK', 220)
Insert into tblProductSales values('John', 'UK', 420)
Insert into tblProductSales values('David', 'US', 320)
Insert into tblProductSales values('Tom', 'US', 340)
Insert into tblProductSales values('Tom', 'UK', 660)
Insert into tblProductSales values('John', 'India', 430)
Insert into tblProductSales values('David', 'India', 230)
Insert into tblProductSales values('David', 'India', 280)
Insert into tblProductSales values('Tom', 'UK', 480)
Insert into tblProductSales values('John', 'US', 360)
Insert into tblProductSales values('David', 'UK', 140)

select * from tblProductSales


-----------USING GROUP BY query
select salescountry, SalesAgent, sum(SalesAmount) AS total 
from tblProductSales
GROUP BY salescountry, SalesAgent
ORDER BY salescountry, SalesAgent


---------------------using PIVOT operator.--------

Select  SalesAgent, India, US, UK
from tblProductSales
Pivot
(
   Sum(SalesAmount) for SalesCountry in ([India],[US],[UK])
) as PivotTable

select * from tblProductSales

------ computed columns or calculated columns ----
 1. In SQL server you have an option to create computed columns or calculated columns in a table other than normal columns .
 --A computed column can also be the expression
 --A computed column is nothing but an expression, which can be -
 /* 
 1.non computed column
 2.constant
 3.function
 4.any combination using operators.
*/

create table Employe_playroll
(
empID int identity,
empName nvarchar(10),
Designation nvarchar(10),
[Basic pay] int,
[Houserent allowance ] int,
[convence allowance] int,
[medical allowance] int,
[Gross pay ] as [Basic pay] + [Houserent allowance ] +
[convence allowance] + [medical allowance]
)

  
insert into Employe_playroll values ('ppp', 'HR', 25000, 3000,4000,6000)
insert into Employe_playroll values ('vvv', 'incharge', 30000, 3000,9000,6000)
insert into Employe_playroll values ('sds', 'manager', 35000, 3000,4000,3000)
insert into Employe_playroll values ('asc', 'ssenior', 45000, 2000,7000,6000)
insert into Employe_playroll values ('wef', 'assistant', 60000, 4000,4000,6000)

--------------------------------------------------------------------------------------------------------------------------
------------------Cube And Rollup -----------
/*
Cube In SQL----
CUBE is an aggregate operator that produces a super-aggregate row.
The summary row is displayed for every possible combination of groups in the result set.
In addition to the usual rows provided by the GROUP BY, it also provides the summary of the rows that the GROUP BY clause generates.
The summary row displays NULL in the result set but at the same time returns all the values for those.
Cube() in SQL server produces the result set by generating all combinations of columns specified in GROUP BY CUBE().
Write a query to retrieve Sum of Salary grouped by all possible combinations of the 2 columns (City and Gender) as well as GRAND TOTAL.


Rollup In SQL Server---
In addition to the usual rows that are generated by the GROUP BY clause, it also introduces summary rows into the result set.
It arranges the groups from the lowest to the highest.
It is similar to CUBE operator but generates a result set that shows groups arranged in a hierarchical order.
Group hierarchy in the result is dependent on the order in which the columns that are grouped are specified.

*/

create table Employee_Tbl 
(
Id int primary key identity,
Name varchar(50),
Gender varchar(50),
City varchar(50),
Salary int
);

-- INSERTING DATA INTO EMPLOYEE TABLE

insert into Employee_Tbl values

('Ali','Male','Karachi',15000),
('Anas','Male','Hyderabad',12000),
('Afshan','Female','Karachi',14000),
('Imran','Male','Hyderabad',11000),
('Anum','Female','Hyderabad',13000),
('Usman','Male','Sukkur',11000),
('Sumaira','Female','Sukkur',16000),
('Amir','Female','Hyderabad',17000),
('Zain','Male','Sukkur',12000),
('Maryam','Female','Karachi',15000);

Select * from Employee_Tbl

select city,  sum (salary) as total_salary
from Employee_Tbl
Group by city;

select city, gender, sum (salary) as total_salary
from Employee_Tbl
Group by city,Gender
;
 
select city, gender, sum (salary) as total_salary
from Employee_Tbl
Group by cube (city,Gender)
;
select * from Employee_Tbl
-- ANOTHER EXAMPLE OF CUBE COMMAND

select city, gender, sum (salary) as total_salary
from Employee_Tbl
Group by city,Gender with cube
-- ANOTHER EXAMPLE OF rollup COMMAND

select city, gender, sum (salary) as total_salary
from Employee_Tbl
Group by rollup (city,Gender)
;
-- ANOTHER EXAMPLE OF CUBE COMMAND

select city, sum (salary) as total_salary
from Employee_Tbl
Group by cube (city);
;
-- ANOTHER EXAMPLE OF rollup COMMAND

select city, sum (salary) as total_salary
from Employee_Tbl
Group by rollup ( city);


--------------------------------------------------------------------------------------------------------------------------
---------------------Grouping Sets----------------------

The GROUPING SETS operator allows you to group together
multiple groupings of columns followed by an optional 
grand total row, denoted by parentheses, ().

It is more efficient to use GROUPING SETS operators 
instead of multiple GROUP BY with UNION clauses 
because the latter adds more processing overheads
on the database server.

 ---example of grouping set

Select * from Employee_Tbl

select City, Gender, sum(Salary) as Total_Salary
from Employee_Tbl
group by
grouping sets		
(
(City,Gender),
(City),
(Gender),
()
)
order by grouping(City),grouping(Gender);

-- EXAMPLE OF GROUP BY IN SQL
select City, Gender, sum(Salary) as Total_Salary
from Employee_Tbl
group by City,Gender

union all

select City, NULL as [Male / Female], sum(Salary) as Total_Salary
from Employee_Tbl
group by City

union all

select NULL, NULL as [Male / Female], sum(Salary) as Total_Salary
from Employee_Tbl
group by ()

union all

select NULL, Gender as [Male / Female], sum(Salary) as Total_Salary
from Employee_Tbl
group by Gender



-------Subquery------ pending to complete
subquery- ek query ke andar dusri query. ek outer query hoti hai & dusri inner query or nestet query hoti hai.

What Is Sub-Query In SQL Server ?
A Subquery or Inner query or a Nested query is a query within another SQL query and embedded within the WHERE clause.
A subquery is used to return data that will be used in the main query as a condition to further restrict the data to be retrieved.

select * from tblemploye
select * from tbldepartment



select * from tblemploye
where id in
(select id from tblemploye where salary > 5000);

select * from tblemploye
where id in
(select id from tblemploye where gender = 'f')

/*   --confused in this topic
Types Of Subqueries In SQL Server         
Scalar Sub-Queries
Multi-Valued Sub-Queries

SCALAR SUBQUERIES – subqueries that return one row to the outer SQL statement.
Operators: = > >= < <= !=
MULTIVALUED SUBQUERIES – subqueries that return more than one row to the outer SQL statement.
Operators: in, any and all.

*/
Select * from tblemploye
where id in 
(select id from tblemploye where gender = 'f')

Select * from tblemploye
where salary < any
(select salary  from tblemploye where name = 'tom' or name = 'dam')

Select * from tblemploye
where salary  < all
(select salary  from tblemploye where name = 'tom' or name = 'dam')


---Joining of 3 tables--------------------------------------

use 
samples
go

create table teacher
(
Teacher_id int primary key,
Name nvarchar(10),
salary nvarchar(10),
Qualification nvarchar(10)
)

insert into teacher values (1,'qAli',30000, 'BCA')
insert into teacher values (2,'pooh',60000, 'mCA')
insert into teacher values (3,'chitra',40000, 'CA')
insert into teacher values (4,'kjol',35000, 'sC')


create table Students
(
Student_ID int primary key,
Name nvarchar(10),
Classes int,
Fee nvarchar(10),
Teacher_id int
)

insert into Students values (101,'amir', 6, 3000, 2)
insert into Students values (102,'ajay',7, 6000, 3)
insert into Students values (103,'atish',8, 4000, 4)
insert into Students values (104,'ashu',9, 3500, 1)


create table Branch
(
Branch_id int primary key,
City nvarchar(10),
Student_ID int
)

insert into Branch values (111,'qAli', 101)
insert into Branch values (222,'poh', 102)
insert into Branch values (333,'melt',103 )
insert into Branch values (444,'lopa', 104)

select * from teacher;
select * from Students;
select * from Branch;

 Select * from teacher as A
 inner join students as B
 on A.Teacher_id = B.Teacher_id
 inner join Branch as C
 on B.Student_ID = C.Student_ID


 Select 
 A.name, A.salary, A.qualification,
 B.Classes , B.fee ,
 C.city  from teacher as A
 inner join students as B
 on A.Teacher_id = B.Teacher_id
 inner join Branch as C
 on B.Student_ID = C.Student_ID

--------------------------------------------------------------------------------------------------- 

------Identity or auto increment--------(Auto Id number generate)

create table teacher_Tbl
(
Teacher_id int  Identity primary key ,
Name nvarchar(10),
salary nvarchar(10),
Qualification nvarchar(10)
)

insert into teacher_Tbl values ('qAli',30000, 'BCA')
insert into teacher_Tbl values ('pooh',60000, 'mCA')
insert into teacher_Tbl values ('chitra',40000, 'CA')
insert into teacher_Tbl values ('kjol',35000, 'sC')

Select * from teacher_Tbl

--Example -2 

create table Branch_Tbl
(
Branch_id int identity(100,10) primary key,
City nvarchar(10)

)

insert into Branch_Tbl values ('qAli')
insert into Branch_Tbl values ('poh')
insert into Branch_Tbl values ('melt')
insert into Branch_Tbl values ('lopa')

Select * from Branch_Tbl


-------------------------------------------------------------------------

----Intersect and except----------------

create table HockeyParticipants 
(
id int, 
Name varchar(50), 
Email varchar(50)
);

insert into HockeyParticipants values(1,'Ali Mushtaq','Ali123@gmail.com');
insert into HockeyParticipants values(2,'Anas khan','anask123@gmail.com');
insert into HockeyParticipants values(3,'Umar jatoi','umar123@gmail.com');
insert into HockeyParticipants values(4,'Amir nasir','Amir123@gmail.com');

create table FootballParticipants 
(
id int, 
Name varchar(50), 
Email varchar(50)
);

insert into FootballParticipants values(1,'Umair Khan','umair123@gmail.com');
insert into FootballParticipants values(2,'Usman khan','uk123@gmail.com');
insert into FootballParticipants values(3,'Armaan jatoi','aj123@gmail.com');
insert into FootballParticipants values(4,'Amir nasir','Amir123@gmail.com');

 select * from HockeyParticipants
select * from FootballParticipants

---union 
select * from HockeyParticipants
union
select * from FootballParticipants

--union all
select * from HockeyParticipants
union all
select * from FootballParticipants

---except - removes common columns from bot the table
select * from HockeyParticipants
except
select * from FootballParticipants

--intersect -- find out common column from both table
select * from HockeyParticipants
intersect
select * from FootballParticipants


------------------------------------------------------------------------

---Cross Apply & Outer Apply \

--cross apply and outer apply ka kam ye he ki 2 result set ko apas me join karna or merge karna.
cross apply and outer apply table valued function ke sath kam krta he

/*

In SQL, APPLY operator is like a join clause and it allows joining between two table expressions
i.e. joining a left table expression with a right table expression.
In SQL, Cross Apply is just like Inner Join. 
In SQL, Outer Apply is just like Left Join.
In SQL, Cross Apply returns only matching rows.
In SQL, Outer Apply returns both matching and non-matching rows, the unmatched columns of the table valued function will be set to NULL.
*/

create table teachers
(
teacher_id int identity primary key,
teacher_name varchar(50),
teacher_gender varchar(50),
teacher_qual varchar(50),
teacher_sal int
);

insert into teachers values
('Asad','Male','BSIT',28000),
('Khalid','Male','MBA',29000),
('Amjad','Male','MPHIL',30000),
('Adeel','Male','BSIT',27000),
('Sahar','Female','BSC',25000),
('Farukh','Male','BBA',26000);

select * from teachers;

create table student_
(
std_id int primary key identity,
std_name varchar(50),
std_gender varchar(50),
std_age int,
std_class int,
t_id int foreign key references teachers(teacher_id)
);

insert into student_ values
('Anas','Male',22,12,2),
('Anum','Female',21,11,3),
('Zain','Male',23,12,1),
('Furqan','Male',21,10,2),
('Saba','Female',21,11,4),
('Amna','Female',23,12,3);

select * from teachers;
select * from student_;

select * from teachers
inner join student_
on teachers.Teacher_id = student_.t_id

select A.teacher_name, A.teacher_qual, B.std_name, B.std_age from teachers as A
inner join student_ as B
on A.Teacher_id = B.t_id 

select A.teacher_name, A.teacher_qual, B.std_name, B.std_age from teachers as A
left join student_ as B
on A.Teacher_id = B.t_id

 --- create table valued function
 --to create table valued function instead of using JOIN function here we will use cross apply or outer apply


 create function fn_getstudentbyteacherid(@teacher_id int)
 returns table     --because we r creating table vlued funcion
 as
 return
 (
 select * from student_
 where t_id = @teacher_id
 )
 select * from fn_getstudentbyteacherid(2);

 --cross apply   (Cross Apply is just like Inner Join.)
 select A.teacher_name, A.teacher_qual, B.std_name, B.std_age 
 from teachers as A
CROSS APPLY fn_getstudentbyteacherid(A.teacher_id) as B

--outer apply		(Outer Apply is just like Left Join.)
select A.teacher_name, A.teacher_qual, B.std_name, B.std_age 
 from teachers as A
outer APPLY fn_getstudentbyteacherid(A.teacher_id) as B



-----------------------------------------------------------

--Converted data from rows to column----

create table emp
(
name text,
value nvarchar(10),
ID int
)

insert into emp values ('name', 'adam',1)
insert into emp values ('Gender', 'male',1)

insert into emp values ('salary', '5000',1)

select * from emp
select ID, [Name], [gender],[salary]
(select ID, name as eName value
from emp) as source_table
pivot
(Max(value)
for
eName in ([Name], [gender],[salary]) as pivot_table

-----------------------------------------------------------------------

--------------MERGE statement-----------------------------
/*
With merge statement we require 2 tables
1. Source Table - Contains the changes that needs to be applied to the target table
2. Target Table - The table that require changes (Inserts, Updates and Deletes)

Merge statement syntax-------

*/

 Create table StudentSource
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Create table StudentTarget
(
     ID int primary key,
     Name nvarchar(20)
)
GO
Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')
GO
/*
MERGE [TARGET] AS T
USING [SOURCE] AS S
   ON [JOIN_CONDITIONS]
 WHEN MATCHED THEN 
      [UPDATE STATEMENT]
 WHEN NOT MATCHED BY TARGET THEN
      [INSERT STATEMENT] 
 WHEN NOT MATCHED BY SOURCE THEN
      [DELETE STATEMENT]
*/
select * from StudentTarget
Select * from StudentSource

Merge StudentTarget As T
using StudentSource As S
on T.ID = S.ID 
when matched then
	update set T.Name = S.Name
	When not matched by target then 
	insert (ID, name) Values (S.ID , S.Name);

	--------------------------------------------------------

	---Alter database table columns without dropping table

	Create table poohu
(
 ID int primary key identity,
 Name nvarchar(50),
 Gender nvarchar(50),
 Salary nvarchar(50)
)
Insert into poohu values('Sara Nani','Female','4500')
Insert into poohu values('James Histo','Male','5300')
Insert into poohu values('Mary Jane','Female','6200')
Insert into poohu values('Paul Sensit','Male','4200')
Insert into poohu values('Mike Jen','Male','5500')

Select * from poohu

Select Gender, sum(salary) as totalsalary
from poohu
group by gender

--To alter a column
Alter table poohu
Alter column salary int


	

	 
--------------------------------------------------
--5 ways to find nth highest salary

	 select * from tblemployee
 --2nd highest salary
--using max()

--find maximum salary
select MAX (salary)
from tblemployee

--2nd highest salary
select MAX (salary)
from tblemployee
where salary < 7000

--3rd highest salary



------------------------------------------------------------------------------------------------------------
---Sql queries interview question and answers

Select * from Employee_Tbl
update Employee_Tbl set  Salary = 50000
where Id = 1;

update Employee_Tbl set Name = 'Aliahemed'
where City = 'karachi'

update Employee_Tbl set Name = 'mona'
where Salary = 15000

--select all Emplyee name where age is greater then 22
Select * from Samperson

select name from Samperson where Age >22

select  *from SamPerson  where Age > 22

--find all emolyee with salary between 10000 and 30000
Select * from Employee_Tbl
Select * from Employee_Tbl where Salary between 10000 and 15000
---without using between
Select * from Employee_Tbl where Salary > 10000 and salary <15000

-- find name begining with 's'
select * from SamPerson

select * from SamPerson where Name like 's%';
 
select * from SamPerson where Name <> 'tom' and Name  <> 'may'
 select * from SamPerson where Name NOT IN ( 'tom', 'may')

 --display full name

 select CONCAT(name,Email) from SamPerson
  select CONCAT(name, ' ',Email) from SamPerson
  
  select SYSDATETIME()

  --to get day of last day of the privious month xxxxxxxxxxxxx

  select replace(name , 'A', '@') from SamPerson
    select replace(name , '@', 'A') from SamPerson


	select * from SamPerson

	-- fetch all the employees details from employee table who joined in the year 2012

	select * from cursur_pooja
		select * from cursur_pooja  where joiningdate between ' 01-jan-2012' and '31-dec-2012'
				select To_char( joiningdate , 'yyyy') from cursur_pooja

	----- how to fetch odd rows / even rows xxxxxxxxxxxxx
	 select * from SamPerson  where mod(id,2)	< 0
	 
	 --create a new table with data and structured copy from another table xx
	  create table sampersoncopy as (select * from SamPerson);

	  --how to fetch top 3 highest  salary
	     Select *  from Employee_Tbl
		Select  Salary from Employee_Tbl
		 Select  Distinct  Salary from Employee_Tbl
	 Select  Distinct  Salary from Employee_Tbl order by Salary desc

	 --chech this line
	 	 Select  Distinct  Salary from Employee_Tbl 
		 order by Salary desc 
		 where row_number < 4

		 --- find the first employe and last employe 
		 	    
				--first employee
				Select *  from Employee_Tbl
		Select *  from Employee_Tbl where Id= (
			Select   min(Id)  from Employee_Tbl)
			 
		 --last employee
			Select *  from Employee_Tbl
		Select *  from Employee_Tbl where Id= (
			Select   max(Id)  from Employee_Tbl)



 Select  * from Employee_Tbl
   Select  gender, COUNT(*) from Employee_Tbl
   group by Gender

   Select gender, MAX(Salary) from Employee_Tbl
   group by Gender

