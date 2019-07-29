--Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.
--Import each CSV file into the corresponding SQL table.

CREATE TABLE departments (
	dept_no varchar(10) NOT null PRIMARY KEY,
	dept_name varchar(100)
);

CREATE TABLE employees (
	emp_no int NOT null PRIMARY KEY,
	birth_date date NOT null DEFAULT now(),
	first_name varchar(75),
	last_name varchar(75),
	gender varchar(5),
	hire_date date NOT null
);

CREATE TABLE dept_emp (
	emp_no int NOT null REFERENCES employees(emp_no),
	dept_no varchar(10) NOT null REFERENCES departments(dept_no),
	from_date date NOT null,
	to_date date NOT null
);

CREATE TABLE dept_manager (
	dept_no varchar(10) NOT null REFERENCES departments(dept_no),
	emp_no int NOT null REFERENCES employees(emp_no),
	from_date date NOT null,
	to_date date NOT null
);

CREATE TABLE salaries (
	emp_no int NOT null REFERENCES employees(emp_no),
	salary int,
	from_date date NOT null,
	to_date date NOT null
);

CREATE TABLE titles (
	emp_no int NOT null REFERENCES employees(emp_no),
	title varchar(75) NOT null,
	from_date date NOT null,
	to_date date NOT null
);
	
--List the following details of each employee: 
--employee number, last name, first name, gender, and salary.

CREATE VIEW employee_details AS 
SELECT employees.emp_no, first_name, last_name, gender, salary
FROM employees INNER JOIN salaries
	ON salaries.emp_no = employees.emp_no
;

--List employees who were hired in 1986.

CREATE VIEW hired_in_1986 AS
SELECT first_name, last_name, hire_date FROM employees WHERE hire_date >=('1987/1/1') AND hire_date <=('1987/12/31');

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

CREATE VIEW manager_department_names AS
SELECT DISTINCT departments.dept_no, departments.dept_name, employees.emp_no, 
employees.last_name, employees.first_name, dept_manager.from_date, dept_manager.to_date
FROM departments 
	RIGHT JOIN dept_manager
		ON departments.dept_no = dept_manager.dept_no
	LEFT JOIN employees 
		ON employees.emp_no = dept_manager.emp_no
		

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

CREATE VIEW employee_departments_past_current AS
SELECT employees.emp_no, last_name, first_name, departments.dept_name 
FROM employees
	INNER JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments
			on dept_emp.dept_no = departments.dept_no
;

--List all employees whose first name is "Hercules" and last names begin with "B."

CREATE VIEW Hercules_B AS
SELECT emp_no, first_name, last_name FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.

CREATE VIEW sales_people AS
SELECT employees.emp_no, last_name, first_name, departments.dept_name 
FROM employees
	INNER JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments
			on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
;

--List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.

CREATE VIEW sales_development_people AS
SELECT employees.emp_no, last_name, first_name, departments.dept_name 
FROM employees
	INNER JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments
			on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

--In descending order, list the frequency count of 
--employee last names, i.e., how many employees share each last name.

CREATE VIEW last_name_count AS
SELECT DISTINCT last_name, count(last_name) FROM employees
GROUP BY last_name ORDER BY count(last_name) desc
;
