-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" CHAR(4)   NOT NULL,
    "dept_name" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" CHAR(4)   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "emp_no","dept_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" CHAR(4)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(30)   NOT NULL,
    "bithdate" DATE   NOT NULL,
    "first_name" VARCHAR(30)   NOT NULL,
    "last_name" VARCHAR(30)   NOT NULL,
    "sex" CHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" CHAR(5)   NOT NULL,
    "title" VARCHAR(30)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");







-- 1  Employee_dept correct

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
-- LIMIT 50
;



-- 2  1986_employees correct

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31'
-- LIMIT 50
;



-- 3  managers not correct

SELECT 
	employees.emp_no, 
	employees.last_name, 
	employees.first_name,
	departments.dept_no,
	departments.dept_name	
FROM employees

WHERE employees.emp_no IN (
	SELECT dept_manager.emp_no, dept_manager.dept_no
	FROM dept_manager
	WHERE employees.emp_no = dept_manager.emp_no
)
JOIN departments
ON departments.dept_no = dept_manager.dept_no
LIMIT 50
;


-- 4  Employee_info 

SELECT 
	employee.emp_no, 
	employees.first_name, 
	employees.last_name
	


-- 5 Hercules correct 
SELECT 
	employees.first_name,
	employees.last_name,
	employees.sex
FROM employees
WHERE
	employees.first_name = 'Hercules'
	AND employees.last_name LIKE 'B%'
;


-- 6 Sales d007 WORKS 

SELECT 	employees.emp_no,
		employees.last_name,
		employees.first_name
FROM employees
WHERE employees.emp_no IN (
	Select dept_emp.emp_no
	FROM dept_emp
	WHERE dept_emp.dept_no = 'd007'
	)
-- LIMIT 50
;




-- 7 Sales_and_dev sales d007 development d005 CORRECT

-- sales and development

SELECT 	employees.emp_no,
		employees.last_name,
		employees.first_name
FROM employees
WHERE employees.emp_no IN (
	Select dept_emp.emp_no
	FROM dept_emp
	WHERE dept_emp.dept_no = 'd007' AND dept_emp.dept_no = 'd005' 
) 
-- LIMIT 50
;

-- sales or development

SELECT 	employees.emp_no,
		employees.last_name,
		employees.first_name
FROM employees
WHERE employees.emp_no IN (
	Select dept_emp.emp_no
	FROM dept_emp
	WHERE dept_emp.dept_no = 'd007' OR dept_emp.dept_no = 'd005' 
) 
LIMIT 50
;


-- 8 Family 

SELECT 








