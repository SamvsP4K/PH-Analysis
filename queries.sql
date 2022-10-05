--Creating a table
CREATE TABLE Departments (
	dept_no VARCHAR(4) NOT NULL, 
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY(dept_no),
	UNIQUE(dept_name)
);

CREATE TABLE employees(
	emp_no VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY(emp_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR NOT NULL,
	emp_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY(dept_no) REFERENCES departments (dept_no),
FOREIGN KEY(emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries(
	emp_no VARCHAR NOT NULL,
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY(emp_no),
FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

DROP TABLE titles;
CREATE TABLE titles(
	emp_no VARCHAR NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

DROP TABLE dept_emp;
CREATE TABLE dept_emp(
	emp_no VARCHAR NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
FOREIGN KEY(dept_no) REFERENCES departments(dept_no)	
);

-- checking CSV imports
SELECT * FROM titles;
SELECT * FROM dept_emp;

-- Search for employees by birthday
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31'

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'

-- Retirement eligibality 
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Preparing data for export
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE retirement_info;

--Creating a new table for retirement info
SELECT emp_no,first_name,last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') 
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--Joining departments and dept_managers table
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT * FROM departments;

SELECT retirement_info.emp_no, retirement_info.first_name, retirement_info.last_name, dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT retirement_info.emp_no,retirement_info.first_name,retirement_info.last_name, dept_emp.to_date
INTO current_emp
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date = ('9999-01-01');

SELECT * FROM current_emp;

--Employee count by dept number
SELECT COUNT(current_emp.emp_no), dept_emp.dept_no
INTO emp_count
FROM current_emp
LEFT JOIN dept_emp
ON current_emp.emp_no = dept_emp.emp_no
GROUP BY dept_emp.dept_no
ORDER BY dept_emp.dept_no;

SELECT * FROM current_emp;

--Employee info
SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT employees.emp_no,employees.first_name,employees.last_name,employees.gender,salaries.salary,dept_emp.to_date
INTO emp_detailed_info
FROM  employees
INNER JOIN salaries
on (employees.emp_no = salaries.emp_no)
INNER JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (dept_emp.to_date = '9999-01-01');