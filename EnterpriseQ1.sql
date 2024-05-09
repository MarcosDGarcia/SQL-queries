WITH CTE AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY hire_date) AS row_num,
        employee_id,
        CONCAT(first_name, ' ', last_name) AS full_name,
        hire_date,
        salary,
        department_name
    FROM 
        employees
)
SELECT 
    row_num,
    employee_id,
    full_name,
    hire_date,
    salary,
    department_name,
    CASE 
        WHEN salary > 50000 THEN 'Above Average'
        ELSE 'Below Average'
    END AS salary_category,
    SUM(salary) OVER (PARTITION BY department_name) AS total_salary_by_department,
    (SELECT AVG(salary) FROM employees WHERE department_name = CTE.department_name) AS avg_salary_department
FROM 
    CTE
LEFT JOIN 
    departments ON CTE.department_id = departments.department_id
WHERE 
    hire_date >= '2020-01-01'
GROUP BY 
    row_num, employee_id, full_name, hire_date, salary, department_name, salary_category
ORDER BY 
    hire_date DESC;



