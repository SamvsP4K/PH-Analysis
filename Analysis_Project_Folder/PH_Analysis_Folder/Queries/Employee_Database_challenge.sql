--selecting full tables for reference
SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM retirement_titles;
SELECT * FROM dept_emp;

DROP TABLE employees;

ALTER TABLE employees
ALTER COLUMN emp_no TYPE INTEGER
USING emp_no::integer;


DROP TABLE retirement_titles;
--# of retiring employees per title
SELECT e.emp_no,e.first_name,e.last_name,t.title,t.from_date,t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no::integer;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON(emp_no) emp_no,first_name,last_name,title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;


--number of retiring employees by recent job title

SELECT COUNT(title),title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

--mentorship eligibility 
SELECT DISTINCT ON(e.emp_no)e.emp_no,e.first_name,e.last_name,e.birth_date,de.from_date,de.to_date,t.title
INTO mentorship_eligibility
FROM employees as e
JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
JOIN titles as t
ON(e.emp_no = t.emp_no)
WHERE(de.to_date = '9999-01-01') AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no

--number of mentorship unique titles
SELECT * FROM mentorship_eligibility;

SELECT COUNT(title),title
INTO mentorship_titles
FROM mentorship_eligibility
GROUP BY title
ORDER BY count DESC;