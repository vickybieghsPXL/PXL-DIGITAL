CREATE OR REPLACE PROCEDURE minimumlonen
    (p_landnaam in varchar2,
     p_minimumloon in number)
AS
BEGIN
    UPDATE employees 
    SET employees.salary = p_minimumloon
    Where employee_id IN (SELECT employees.employee_id
                          FROM employees JOIN departments on employees.department_id = departments.department_id
                          JOIN locations on locations.location_id = departments.location_id
                          JOIN countries on countries.country_id = locations.country_id
                          WHERE countries.country_name = p_landnaam and employees.salary < p_minimumloon);
END minimumlonen;
/