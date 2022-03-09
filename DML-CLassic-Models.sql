//----------QUERIES PERFORMED ON classicmodels.employees TABLE--------------

SELECT * FROM classicmodels.employees;

//--------- SELECTED ALL EMPLOYEES WHERE LAST_NAME STARTS WITH LETTER 'B'----------------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE 'b%';

//----------SELECTED ALL EMPLOYEES WHERE LAST_NAME ENDS WITH LETTER 'N'-------------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE '%n';

//----------SELECTED ALL EMPLOYEES WHERE LAST_NAME CONTAINS 'EL'----------------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE '%el%';

//----------SELECTED ALL EMPLOYEES WHERE LAST_NAME HAS 'E' IN THE SECOND POSITION--------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE '_e%';

////----------SELECTED ALL EMPLOYEES WHERE LAST_NAME STARTS WITH 'T' AND IS AT LEATS 3 CHARACTERS IN LENGTH---------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE 't__%';

//----------SELECTED ALL EMPLOYEES WHERE LAST_NAME STARTS WITH 'T' AND ENDS WITH 'N'----------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE 't%n';

//----------SELECTED ALL EMPLOYEES WHERE LAST_NAME HAS 'N' IN THE THIRD POSITION-----------

SELECT * FROM classicmodels.employees
WHERE lastName LIKE '__n%';



