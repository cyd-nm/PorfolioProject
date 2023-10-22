--- Elected officials and their salary
SELECT 
	CONCAT(first_name, ' ',last_name) AS name, 
	position, 
	designation, 
	monthly_salary
FROM 
	employee
WHERE
	employment_status = 'Elected' 
	AND
	status = 'active'

ORDER BY monthly_salary DESC

--- Number of employees per office and the sum of all their salaries
SELECT 
	designation, 
	COUNT (*) AS employee_count, 
	ROUND(SUM(salary),0) AS TotalSalary
FROM 
	employee
GROUP BY designation
ORDER BY TotalSalary DESC


---Average earning of psychology graduates
SELECT ROUND(AVG(salary),0) AS avg_salary
FROM employee
WHERE 
  	attainment LIKE '%psychology%' 
	AND position LIKE '%admin%'
	

---Average, minimum, and maximum salary of employees under 25 years of age working as administrative worker
SELECT AVG(salary) AS ave, MAX(salary) AS highest, MIN(salary) AS lowest
FROM employee
WHERE age<25 AND position LIKE '%admin%'