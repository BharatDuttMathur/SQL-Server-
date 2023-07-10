select * FROM EMPLOYEEDETAIL 
select FirstName from EMPLOYEEDETAIL
select Upper(FirstName) from EMPLOYEEDETAIL
select Lower(FirstName) from EMPLOYEEDETAIL
select FirstName + ' ' + lastName as Name from EMPLOYEEDETAIL
select * from EMPLOYEEDETAIL where FirstName = 'Vikas'
select * from EMPLOYEEDETAIL where FirstName like 'a%'
select * from EMPLOYEEDETAIL where FirstName like '%h'
select * from EMPLOYEEDETAIL where FirstName like '[a-p]%'
select * from EMPLOYEEDETAIL where FirstName like '[^a-p]%'
select * from EMPLOYEEDETAIL where Gender like '__le'
select * from EMPLOYEEDETAIL where FirstName like 'A____'
select * from EMPLOYEEDETAIL where FirstName like '%[%]%'
select Distinct DEPARTMENT from EMPLOYEEDETAIL
select max(salary) as MaxSalary from EMPLOYEEDETAIL
select Min(salary) as MinSalary from EMPLOYEEDETAIL
select format(JOININGDATE,'dd MMM yyyy') from EMPLOYEEDETAIL
select format(JOININGDATE,'yyyy/MM/dd') from EMPLOYEEDETAIL
select Format(JOININGDATE, 'hh:mm:ss tt') from EMPLOYEEDETAIL
select format(JOININGDATE,'yyyy') from EMPLOYEEDETAIL
select format(JOININGDATE,'yyyy') from EMPLOYEEDETAIL
select format(JOININGDATE,'MMM') from EMPLOYEEDETAIL
select Getdate()
select GETUTCDATE()
select FIRSTNAME,GetDate() as CurrentDate, JOININGDATE, datediff(MONTH,JOININGDATE,Getdate()) as TotalWorkingMonths from EMPLOYEEDETAIL
select FIRSTNAME,GetDate() as CurrentDate, JOININGDATE, datediff(Day,JOININGDATE,Getdate()) as TotalWorkingDays from EMPLOYEEDETAIL
select * from EMPLOYEEDETAIL where format(JOININGDATE,'yyyy') = '2013'
select * from EMPLOYEEDETAIL where format(JOININGDATE,'MMM') = 'FEB'
select count(1) from EMPLOYEEDETAIL
select top 1 * from EMPLOYEEDETAIL
select * from EMPLOYEEDETAIL where FIRSTNAME in ('Vikas','Ashish', 'Nikhil')
select * from EMPLOYEEDETAIL where FIRSTNAME not in ('Vikas','Ashish', 'Nikhil')
select RTRIM(FIRSTNAME) from EMPLOYEEDETAIL
select LTRIM(FIRSTNAME) from EMPLOYEEDETAIL
select FIRSTNAME, case when GENDER = 'Male' then 'M' when Gender ='Female' then 'F' end as GENDER  from EMPLOYEEDETAIL
select 'Hello' + FirstName from EMPLOYEEDETAIL
select * FROM EMPLOYEEDETAIL where SALARY > 600000
select * FROM EMPLOYEEDETAIL where SALARY < 700000
select * FROM EMPLOYEEDETAIL where SALARY between 500000  and 600000
------------------------------------
select * from ProjectDetail 
select Department,Sum(Salary) as TotalOfSalary FROM EMPLOYEEDETAIL group by Department
select Department,Sum(Salary) as TotalOfSalary FROM EMPLOYEEDETAIL group by Department order by Sum(Salary) 
select Department,Sum(Salary) as TotalOfSalary FROM EMPLOYEEDETAIL group by Department order by Sum(Salary) DESC
select Department,Sum(Salary),count(department) as NumberOfDepartment FROM EMPLOYEEDETAIL group by Department 
select Department,avg(Salary) as MaxSalary FROM EMPLOYEEDETAIL group by Department order by avg(Salary)
select Department,max(Salary) as MaxSalary FROM EMPLOYEEDETAIL group by Department order by max(Salary)
select Department,min(Salary) as MaxSalary FROM EMPLOYEEDETAIL group by Department order by min(Salary)

select * FROM EMPLOYEEDETAIL ED left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID

select ED.FIRSTNAME+' '+ed.LASTNAME as [Employee Name], PD.ProjectName FROM EMPLOYEEDETAIL ED 
left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID where ProjectName is Not NULL
order by ED.firstName 

select ED.FIRSTNAME+' '+ed.LASTNAME as [Employee Name], PD.ProjectName FROM EMPLOYEEDETAIL ED 
left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID 
order by ED.firstName 

select ED.FIRSTNAME+' '+ed.LASTNAME as [Employee Name], case when PD.ProjectName is NULL then '-No Project Assigned' else PD.ProjectName end
FROM EMPLOYEEDETAIL ED 
left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID 
order by ED.firstName 

select ED.FIRSTNAME+' '+ed.LASTNAME as [Employee Name], PD.ProjectName FROM EMPLOYEEDETAIL ED 
right join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID 
order by ED.firstName 

select ED.FIRSTNAME+' '+ed.LASTNAME as [Employee Name], PD.ProjectName FROM EMPLOYEEDETAIL ED 
Full outer join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID 
order by ED.firstName 
----
select z.NAME,PD.ProjectName from (select ED.FIRSTNAME+' '+ed.LASTNAME as Name, ED.EMPLOYEEID FROM EMPLOYEEDETAIL ED 
left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID 
group by  ED.FIRSTNAME+' '+ed.LASTNAME,ED.EMPLOYEEID
having count(pd.ProjectName) > 1)z
left join ProjectDetail PD on z.EMPLOYEEID = pd.EmployeeDetailID 
----

SELECT z.ProjectName,Y.NAME FROM (select PD.ProjectName FROM  EMPLOYEEDETAIL  ED 
left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID
where PD.ProjectName is not null
Group By PD.ProjectName
having Count(distinct ED.FIRSTNAME) >1)Z
left Join 
(select distinct PD.ProjectName,ED.FIRSTNAME+' '+ed.LASTNAME as Name FROM  ProjectDetail PD 
left join EMPLOYEEDETAIL  ED on ED.EMPLOYEEID = pd.EmployeeDetailID)y 
on z.ProjectName = y.ProjectName

----

select * FROM EMPLOYEEDETAIL ED 
Cross join ProjectDetail PD 


-------------------------Project B-------------------------------

select Upper(substring(FirstName,1,1))+substring(FirstName,2,len(FirstName)) from EMPLOYEEDETAIL
----
select string_agg(FIrstName, ',') from EMPLOYEEDETAIL
----

SELECT z.ProjectName,string_agg(Y.NAME,',') FROM (select PD.ProjectName FROM  EMPLOYEEDETAIL  ED 
left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID
where PD.ProjectName is not null
Group By PD.ProjectName
having Count(distinct ED.FIRSTNAME) >1)Z
left Join 
(select distinct PD.ProjectName,ED.FIRSTNAME as Name FROM  ProjectDetail PD 
left join EMPLOYEEDETAIL  ED on ED.EMPLOYEEID = pd.EmployeeDetailID)y 
on z.ProjectName = y.ProjectName
group by z.ProjectName
union
select distinct PD.ProjectName,ED.FIRSTNAME  FROM  ProjectDetail PD 
left join EMPLOYEEDETAIL  ED on ED.EMPLOYEEID = pd.EmployeeDetailID
where PD.ProjectName not in (select PD.ProjectName FROM  EMPLOYEEDETAIL  ED 
                             left join ProjectDetail PD on ED.EMPLOYEEID = pd.EmployeeDetailID
                             where PD.ProjectName is not null
                             Group By PD.ProjectName
                             having Count(distinct ED.FIRSTNAME) >1)

----

select ID,Fuel,Date from 
(select ID,Fuel,
Lag(Fuel,1,-1) over(order by ID) as Lagg, 
Date from FuelDetail )z
where Lagg <Fuel and Lagg <>-1

---------------Project C----------------------

select top 1 * from	FuelDetail	order by newid()
----
select EName,replace(replace(replace(Ename,'B','-'),'A','B'),'-','A') from employee
----
select * into #temp from Employee
select * from #temp
----

 with CTE as  
(  
 select 1 Number  
 union all  
 select Number +1 from CTE where Number<100  
)  
select *from CTE  

----
CREATE INDEX IndexName ON TableName (columnName)
----




