/* List of Employees with Civil Service Elegibility */

--SELECT EmployeeID,LastName,FirstName,Position,Office,Eligibility
--FROM employeetable
--WHERE Eligibility!='NA'
--ORDER BY 2,6

/* Top 5 highest earning position*/

--SELECT TOP 5 (Salary),Position,Office,FirstName,LastName
--FROM employeetable
--ORDER BY Salary DESC

/*Positions*/

--SELECT DISTINCT Position, Office
--FROM employeetable

/*Total salary per office*/
--SELECT Office,MIN(Salary) AS MinSalary, MAX(Salary) AS MaxSalary, AVG(Salary) AS AvgSalary, COUNT(EmployeeID) AS Employees
--From employeetable
--GROUP BY Office
--ORDER BY AvgSalary DESC

/*Employees in HR,Planning, and Engineering*/

--SELECT *
--FROM employeetable
--WHERE Office IN ('HR Office','Planning Office', 'Engineering Office')
--ORDER BY Office

/*Employees age 20-30 years old*/

--SELECT EmployeeID,FirstName,LastName,Age,Salary,Office,Position
--FROM employeetable
--WHERE Age BETWEEN 20 AND 30 
--ORDER BY Age

/*Employees' full name*/

--SELECT EmployeeID, LastName+', '+FirstName + ' '+CONCAT(LEFT(MiddleName, 1),'.') AS NAMES, Position, Office
--FROM employeetable

/*Employee's performance rating in the last 3 years*/

--SELECT LastName+', '+FirstName + ' '+CONCAT(LEFT(MiddleName, 1),'.') AS Fullname, Office, Position, ROUND((PR2021+PR2022+PR2023)/3,2) AS AverageRating
--FROM employeetable AS e
--JOIN ratingtable AS r
--	ON e.EmployeeID=r.EmployeeID
--ORDER BY AverageRating ASC

/*List of performance rating per year*/

--SELECT LastName, FirstName, Position, Office, ROUND(PR2021,2) AS Rating
--FROM employeetable AS e
--JOIN ratingtable AS r
--	ON e.EmployeeID=r.EmployeeID
--ORDER BY Rating DESC

--SELECT LastName, FirstName, Position, Office, ROUND(PR2022,2) AS Rating
--FROM employeetable AS e
--JOIN ratingtable AS r
--	ON e.EmployeeID=r.EmployeeID
--ORDER BY Rating DESC

--SELECT LastName, FirstName, Position, Office, ROUND(PR2023,2) AS Rating
--FROM employeetable AS e
--JOIN ratingtable AS r
--	ON e.EmployeeID=r.EmployeeID
--ORDER BY Rating DESC

/* Number of Employees per office*/

--SELECT DISTINCT
--    e.office,
--    COUNT(CASE WHEN er.employmentStatus = 'employed' THEN er.employeeID END) AS Employed,
--    COUNT(CASE WHEN er.employmentStatus = 'retired' THEN er.employeeID END) AS Retired,
--    COUNT(CASE WHEN er.employmentStatus = 'removed' THEN er.employeeID END) AS Removed
--FROM employeetable e
--LEFT JOIN ratingtable er ON e.employeeID = er.employeeID
--GROUP BY e.office;

/* Using Having statement*/

--SELECT COUNT(employeeID),Office
--FROM employeetable
--GROUP BY Office
--HAVING COUNT(EmployeeID)<200

/*List of contact number of employees with >=8 rating score*/

--SELECT FirstName+' '+LastName AS EmployeeName, ContactNumber
--FROM employeetable
--WHERE EXISTS (
--	SELECT EmployeeID
--	FROM ratingtable
--	WHERE ratingtable.EmployeeID=employeetable.EmployeeID AND PR2021>8);

/* Employees that are no longer employed in the organization*/
--SELECT LastName, FirstName, Position, Office
--FROM employeetable
--WHERE EmployeeID = ANY (
--	SELECT EmployeeID
--	FROM ratingtable
--	WHERE DateEnded!='NA')

/*Employee rating interpretation*/
--SELECT employeetable.EmployeeID, FirstName+' '+LastName AS FULLNAME, 
--	CASE 
--		WHEN PR2021>=9 THEN 'OUTSTANDING'
--		WHEN PR2021>=8 AND PR2021 < 9 THEN 'VERY GOOD'
--		WHEN PR2021>=7 AND PR2021 <8 THEN 'GOOD'
--		WHEN PR2021<7 THEN 'POOR'
--	END AS Performance
--FROM employeetable
--INNER JOIN ratingtable
--	ON employeetable.EmployeeID=ratingtable.EmployeeID
--ORDER BY FULLNAME 

/*Stored Procedure*/
--CREATE PROCEDURE CompleteName
--AS 
--	SELECT LastName+', '+FirstName+' '+CONCAT(LEFT(MiddleName,1),'.') AS FULLNAME
--	FROM employeetable
--GO;

--EXEC CompleteName