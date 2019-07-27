--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, first_name, last_name, gender, salary
FROM employees INNER JOIN salaries
	ON salaries.emp_no = employees.emp_no
;
--List employees who were hired in 1986.

SELECT first_name, last_name, hire_date FROM employees WHERE hire_date >('1987/1/1') AND hire_date <('1987/12/31');

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dept_name, employees.emp_no, last_name, first_name, dept_manager.from_date, dept_manager.to_date
FROM departments RIGHT JOIN dept_manager
	ON departments.dept_no = dept_manager.dept_no
		INNER JOIN employees 
			ON employees.emp_no = dept_manager.emp_no
;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT employees.emp_no, first_name, last_name, departments.dept_name 
FROM employees
	INNER JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments
			on dept_emp.dept_no = departments.dept_no
;

--List all employees whose first name is "Hercules" and last names begin with "B."

SELECT emp_no, first_name, last_name FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name.

SELECT employees.emp_no, first_name, last_name, departments.dept_name 
FROM employees
	INNER JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments
			on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales'
;

--List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.

SELECT employees.emp_no, first_name, last_name, departments.dept_name 
FROM employees
	INNER JOIN dept_emp
			ON employees.emp_no = dept_emp.emp_no
	INNER JOIN departments
			on dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
;

--In descending order, list the frequency count of 
--employee last names, i.e., how many employees share each last name.

SELECT last_name, count(last_name) FROM employees
GROUP BY last_name ORDER BY count(last_name) desc
;

