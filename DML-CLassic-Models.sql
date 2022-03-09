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




----------------QUERIES PERFORMED ON PRODUCTS TABLE-------------------------

SELECT * FROM classicmodels.products;

//--------------SELECTED THE PRODUCT WITH THE LOWEST PRICE----------------

SELECT productName, productLine, MIN(buyPrice)  FROM classicmodels.products;

//--------------SELECTED THE PRODUCT WITH THE HIGHEST PRICE----------------

SELECT productName, productLine, MAX(buyPrice) FROM classicmodels.products;

//--------------SELECTED THE TOTAL NUMBER OF PRODUCTS----------------

SELECT COUNT(productName) FROM classicmodels.products;

//--------------SELECTED THE TOTAL NUMBER OF DISTINCT PRODUCTS----------------

SELECT COUNT(DISTINCT productName) FROM classicmodels.products;

//--------------SELECTED NUMBER OF HARLEY DAVIDSONS----------------

SELECT COUNT(*) FROM classicmodels.products WHERE productName LIKE '%Harley Davidson%';

//--------------SELECTED AVERAGE PRICE----------------

SELECT AVG(buyPrice) FROM classicmodels.products;

//--------------SELECTED THE TOTAL NUMBER OF PRODUCTS FOR EACH PRODUCT LINE----------------

SELECT COUNT(productCode), productLine
FROM classicmodels.products
GROUP BY productLine
ORDER BY COUNT(productCode) DESC;

//--------------SELECTED THE TOTAL NUMBER OF PRODUCTS FOR EACH PRODUCT SCALE----------------

SELECT COUNT(productCode), productScale, quantityInStock
FROM classicmodels.products
GROUP BY productScale
ORDER BY quantityInStock DESC;


//--------------SELECTED THE TOTAL NUMBER OF PRODUCTS FOR EACH PRODUCT LINE FILTERED BY AVG PRICE----------------


SELECT COUNT(productCode), productLine, AVG(buyPrice)
FROM classicmodels.products
GROUP BY productLine
HAVING AVG(buyPrice) > 50
ORDER BY COUNT(productCode) DESC;



//-----------QUERIES PERFORMED ON ORDER DETAILS--------------

//---------- QUERIED THE QUANTITY OF PRODUCTS ORDERED-----------

SELECT quantityOrdered, productCode
FROM orderdetails
WHERE productCode IN (
	SELECT productCode FROM products
);