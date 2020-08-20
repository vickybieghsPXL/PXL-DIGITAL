create or replace function next_employee_id
return number
as 
    v_id number(10);
begin

select MAX(employee_id)
into v_id
from employees;

return v_id + 1;
end;
/
