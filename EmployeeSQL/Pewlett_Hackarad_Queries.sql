create table Departments(
    dept_no varchar(20) Not Null Primary key,
	dept_name char(50) not null
);

Create table Titles(
    title_id varchar (20) not null,
	title char(50) not null,
	primary key(title_id)
);

create table Employees(
    emp_no int not null ,
	emp_title_id varchar(50) not null,
	birth_date date not null,
	first_name char(50) not null,
	last_name char(50) not null,
	sex char(2) not null,
	hire_date date not null,
	primary key(emp_no),
	foreign key(emp_title_id) references Titles(title_id)
);

create table Dept_emp(
    emp_no int not null,
	dept_no varchar(20) not null,
	dept_emp_id varchar(50) not null,
	primary key(dept_emp_id),
	foreign key(emp_no) references Employees(emp_no),
	foreign key(dept_no) references Departments(dept_no)
);

create table Dept_Manager(
    dept_no varchar(20) not null,
	emp_no int not null,
	dept_mgr_id varchar(50) not null,
	primary key(dept_mgr_id),
	foreign key(emp_no) references Employees(emp_no),
	foreign key(dept_no) references Departments(dept_no)
);

create table  Salaries(
    emp_no int not null,
	salary int not null,
	primary key(emp_no, salary),
	foreign key(emp_no) references Employees(emp_no)
);

--Employee #, last name, first name, sex, and salary of each employee
Create View emp_data as
Select Employees.emp_no,
    Employees.first_name,
	Employees.last_name,
	Employees.sex,
	Salaries.salary
From Employees
Inner join Salaries on
Employees.emp_no = Salaries.emp_no;

--first name, last name, and hire date for the employees who were hired in 1986 
Select first_name, last_name, hire_date
From Employees
Where hire_date between '1986-01-01' and '1986-12-31';

--manager of each department along with their department number, department name, 
--employee number, last name, and first name 
Select Dept_Manager.emp_no,
    Dept_Manager.dept_no,
	Departments.dept_name,
	Employees.first_name,
	Employees.last_name
From Dept_Manager
Inner join Departments on
Dept_Manager.dept_no = Departments.dept_no
Inner join Employees on
Dept_Manager.emp_no = Employees.emp_no;

--department number for each employee along with employee number, 
--last name, first name, and department name
create view emp_data as
Select 
    Dept_emp.dept_no,
	Dept_emp.emp_no,
	Departments.dept_name,
	Employees.first_name,
	Employees.last_name
From Dept_emp
Inner join Departments on
Dept_emp.dept_no = Departments.dept_no
Inner join Employees on
Dept_emp.emp_no = Employees.emp_no;

--first name, last name, and sex of each employee whose first name 
--is Hercules and whose last name begins with the letter B
Select first_name, last_name, sex
From Employees
Where first_name = 'Hercules' 
and last_name like 'B%';

--employee in the Sales department, including their employee number, 
--last name, and first name 
select first_name, last_name, emp_no, dept_name
from emp_data
where dept_name = 'Sales';

--employee in the Sales and Development departments, employee number,
--last name, first name, and department name 
select first_name, last_name, emp_no, dept_name
from emp_data
where dept_name = 'Sales' or dept_name = 'Development';

--frequency counts, in descending order, of all the employee last names 
--( how many employees share each last name)
select last_name, count(last_name) as "last name count"
from Employees
group by last_name
Order by "last name count" Desc;



