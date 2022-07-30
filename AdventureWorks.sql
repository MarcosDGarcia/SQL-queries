use AdventureWorks2019 exec sp_changedbowner 'sa'
-- Excercises from https://www.linkedin.com/pulse/ejercicios-sql-server-rocio-lopez/?originalSubdomain=es
-- 1
select
	FirstName, LastName
from
	Person.Person t1
where
	FirstName = 'Mark'

-- 2
select distinct count(BusinessEntityID) from Person.Person

-- 3
select top(100) * from Production.Product t1 where ListPrice!=0
select * from Production.Product t1 where t1.Name like '%Mountain%' and Color='Black' and ListPrice<1000

-- 4
select * from HumanResources.vEmployee where LastName<'D%' order by LastName desc

-- 5
select * from Production.Product
select avg(StandardCost) AvgStandardCost from Production.Product where StandardCost>0.00

-- 6
select * from Person.Person
select count(BusinessEntityID) CountIDs, PersonType from Person.Person group by PersonType

-- 7
select * from Person.StateProvince where CountryRegionCode='CA'

-- 8
select count(ProductID) CountID, Color from Production.Product where Color='Red' or Color='black' group by Color

-- 9
select avg(Freight) AvgFreightPerSale from Sales.SalesOrderHeader where TerritoryID=4

-- 10
select
	concat(FirstName, ' ', MiddleName, ' ', LastName) FullName, EmailAddress, PhoneNumber
from
	Sales.vIndividualCustomer
where
	(LastName='Lopez' or LastName='Martin' or LastName='Wood') and FirstName between 'C' and 'L'

-- 11
select FirstName Nombre, LastName Apellido from Sales.vIndividualCustomer where LastName='Smith'

-- 12
select * from Sales.vIndividualCustomer
select * from Sales.Customer
select * from Sales.SalesTerritory
select
	concat(FirstName, ' ', MiddleName, ' ', LastName) FullName, EmailAddress, PhoneNumber
from
	Sales.vIndividualCustomer
where
	CountryRegionName='Australia' or (PhoneNumberType='Cell' and EmailPromotion=0)

-- 13
select max(ListPrice) MaxPrice from Production.Product
select top(10)
	max(ListPrice) MaxPrice, Name, ProductNumber
from
	Production.Product group by Name, ProductNumber order by max(ListPrice) desc

-- 14
select * from Sales.SalesTerritory
select *
from (
	select
		sum(t1.SubTotal) as total, t1.TerritoryID, t2.Name, t2.CountryRegionCode
	from
		Sales.SalesOrderHeader t1
	inner join
		Sales.SalesTerritory t2 on t1.TerritoryID=t2.TerritoryID
	group by
		t1.TerritoryID, t2.Name, t2.CountryRegionCode
) s1
where s1.total >= 10000000 order by total desc

-- 15
select *
from (
	select
		sum(t1.SubTotal) as total, t1.TerritoryID,
		case
			when t1.TerritoryID=1 then 'Northwest'
			when t1.TerritoryID=2 then 'Northeast'
			when t1.TerritoryID=3 then 'Central'
			when t1.TerritoryID=4 then 'Southwest'
			when t1.TerritoryID=5 then 'Southeast'
			when t1.TerritoryID=6 then 'Canada'
			when t1.TerritoryID=7 then 'France'
			when t1.TerritoryID=8 then 'Germany'
			when t1.TerritoryID=9 then 'Australia'
			when t1.TerritoryID=10 then 'United Kingdom'
			end Region,
		t2.CountryRegionCode
	from
		Sales.SalesOrderHeader t1
	inner join
		Sales.SalesTerritory t2 on t1.TerritoryID=t2.TerritoryID
	group by
		t1.TerritoryID, t2.Name, t2.CountryRegionCode
) s1
where s1.total >= 10000000 order by total desc

select *
from (
	select
		sum(t1.SubTotal) as total, t2.Name, t2.CountryRegionCode
	from
		Sales.SalesOrderHeader t1
	inner join
		Sales.SalesTerritory t2 on t1.TerritoryID=t2.TerritoryID
	group by
		t1.TerritoryID, t2.Name, t2.CountryRegionCode
) s1
where s1.total >= 10000000 order by total desc

-- 16
select * from HumanResources.vEmployeeDepartment where Department='Executive' or Department='Tool Design' or Department='Engineering'

-- 17
select * from
	HumanResources.vEmployeeDepartment
where
	'01-07-2008'<=StartDate and StartDate<='30-06-2010'

-- 18
select * from Sales.SalesOrderHeader where SalesPersonID is not null

-- 19
select count(MiddleName) CountNotNull from Person.Person where MiddleName is not null

-- 20
select SalesPersonID, TotalDue from Sales.SalesOrderHeader where SalesPersonID is not null and TotalDue>70000
select
	SalesPersonID, sum(TotalDue) SumTotalDue
from
	Sales.SalesOrderHeader
where SalesPersonID is not null and TotalDue>70000 group by SalesPersonID

-- 21
select * from Sales.vIndividualCustomer where LastName like 'R%'

-- 22
select * from Sales.vIndividualCustomer where LastName like '%R'

-- 23
select * from (
select count(ProductID) CountProducts, Color from Production.Product where Color is not null group by Color
) s1
where s1.CountProducts>20

-- 24
select sum(s1.Quantity*s1.ListPrice) TotalIncomes
from (
select t1.ProductID, t1.ProductNumber, t1.Name, t1.ListPrice, t2.Quantity from Production.Product t1
inner join Production.ProductInventory t2 on t1.ProductID=t2.ProductID
) s1
where s1.ListPrice!=0

-- 25
select * from Person.Person
select
	FirstName, LastName,
	case
		when EmailPromotion=0 then 'Promo 1'
		when EmailPromotion=1 then 'Promo 2'
		when EmailPromotion=2 then 'Promo 3'
	end Promo
from
	Person.Person

-- 26
select
	t1.BusinessEntityID, t1.SalesYTD, t1.TerritoryID, t2.Name
from
	Sales.SalesPerson t1
left join
	Sales.SalesTerritory t2 on t1.TerritoryID=t2.TerritoryID

-- 27
select
	t1.BusinessEntityID, t3.FirstName, t3.LastName, t1.SalesYTD, t1.TerritoryID, t2.Name NameTerritory
from
	Sales.SalesPerson t1
left join
	Sales.SalesTerritory t2 on t1.TerritoryID=t2.TerritoryID
inner join
	Person.Person t3 on t1.BusinessEntityID=t3.BusinessEntityID
where
	t2.Name='Northeast' or t2.Name='Central'

-- 28
select t1.FirstName, t1.LastName, t2.PasswordHash from Person.Person t1
inner join Person.Password t2 on t1.BusinessEntityID=t2.BusinessEntityID

-- 29
select Title, FirstName, LastName from Person.Person where Title is not null

-- 30
select
	concat(FirstName, IIF(MIddleName IS NULL, ' ', concat(' ', MiddleName, ' '), LastName)
from
	Person.Person

select
	iif(
		(MiddleName IS NULL), 
		-- when midleName is null, we use only one blank space between First Name and LastName
		concat(FirstName, ' ', LastName), 
		-- otherwise, we use MiddleName
		concat(FirstName, ' ', MiddleName, ' ', LastName)
		)
from
	Person.Person

select
	case
		when MiddleName is null then concat(FirstName, ' ', LastName)
		when MiddleName is not null then concat(FirstName, ' ', MiddleName, ' ', LastName)
	end FullName
from Person.Person

-- 31
select
	MakeFlag, FinishedGoodsFlag,
	case
		when MakeFlag=FinishedGoodsFlag then null
		when MakeFlag!=FinishedGoodsFlag then 1
	end Result
from
	Production.Product

-- 32
select
	case
		when Color is null then null
		when Color is not null then Color
	end Result
from Production.Product

-- 33
select
	t1.FirstName, t1.LastName, t2.PasswordHash
from
	Person.Person t1
inner join
	Person.Password t2 on t1.BusinessEntityID=t2.BusinessEntityID

-- End of excercises

-- Subqueries excercises

-- 1

select t1.FirstName, t1.LastName, t2.SickLeaveHours
from HumanResources.vEmployeeDepartment t1
inner join HumanResources.Employee t2 on t1.BusinessEntityID = t2.BusinessEntityID
where t2.SickLeaveHours >=
	(select avg(SickLeaveHours)
	from HumanResources.Employee)

-- 2

select t3.FirstName, t3.LastName, t2.ShiftID
from
	HumanResources.Employee t1
inner join
	HumanResources.EmployeeDepartmentHistory t2 on t1.BusinessEntityID = t2.BusinessEntityID
inner join
	HumanResources.vEmployeeDepartment t3 on t2.BusinessEntityID = t3.BusinessEntityID
where
	t2.BusinessEntityID in (
	select
		BusinessEntityID
	from
		HumanResources.EmployeeDepartmentHistory
	where
		ShiftID = 3)

-- 3

select * from Sales.SpecialOfferProduct where ProductID = 801

select
	t1.ProductID, t1.ProductNumber, t1.Name, count(t2.ProductID) Times
from
	Production.Product t1
inner join
	Sales.SpecialOfferProduct t2 on t1.ProductID=t2.ProductID
where
	t1.ProductID in (
	select
		ProductID
	from
		Sales.SpecialOfferProduct
	)
group by
	t2.ProductID, t1.ProductID, t1.ProductNumber, t1.Name


	
