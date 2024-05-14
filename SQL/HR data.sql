1. Find the average salary for each department.
SELECT
	departments.department_name,
	employees.salary,
  ROUND(AVG(employees.salary), 2) as average_salary
from employees
join departments
on employees.department_id = departments.department_id
group by department_name


2. Find the total number of employees from each country.
SELECT
    locations.country_id, 
    count(*) as count_country
from employees
join departments
on employees.department_id = departments.department_id
join locations
on departments.location_id = locations.location_id
group by country_id

3. Find the number of employees for each job title.
select 
	jobs.job_title,
  count(*) as count_jobs
FROM jobs
join employees
on jobs.job_id = employees.job_id
group by job_title


4. Find the department with the highest average salary.
SELECT
	ROUND(AVG(employees.salary), 2) as average_saraly,
  departments.department_name
from employees
join departments
on employees.department_id = departments.department_id
group by department_name
order by salary desc
limit 1


5. Find all employees name who were hired in 1994. 
select 
	first_name,
  hire_date
from employees
where hire_date like '1994%'


6. Find all employees with a salary greater than the minimum salary for their job title.
SELECT
	employees.first_name,
  employees.salary,
  jobs.min_salary
FROM employees
JOIN jobs
on employees.job_id = jobs.job_id
where salary > min_salary
