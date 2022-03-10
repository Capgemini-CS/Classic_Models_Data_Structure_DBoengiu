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

//----------ADDED INDEX ON EMP_NUMBER------------------

CREATE INDEX emp_no ON employees(employeeNumber);





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


//------------------TRANSACTION TO ADD NEW PRODUCTS-----------------------


-- 1. Start a new transaction  
  
START TRANSACTION;  
  
-- 2. Get the highest buyPrice  
  
SELECT @buyPrice:= MAX(buyPrice) FROM products;  
  
-- 3. Insert a new record into the products table  
  
INSERT INTO products(productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)   
VALUES ('S10_1279', '1970 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 'Min Din Diecast', 'This replica features...', 8000, 50, 100);  
  

  
INSERT INTO products(productCode, productName, productLine, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP)   
VALUES ('S11_1279', '1971 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:12', 'Lin Din Diecast', 'This replica features...', 800, 100, 500);  
  
  
-- 4. Commit changes      
COMMIT;  



//-----------QUERIES PERFORMED ON ORDER DETAILS--------------

//---------- QUERIED THE QUANTITY OF PRODUCTS ORDERED-----------

SELECT quantityOrdered, productCode
FROM orderdetails
WHERE productCode IN (
	SELECT productCode FROM products
);

//---------QUERIED QUANTITY, PRICE AND BUYER-------------------------------

SELECT orderdetails.quantityOrdered, orderdetails.priceEach, products.productName, orders.customerNumber, customers.customerName, orderdetails.quantityOrdered * orderdetails.priceEach AS totalCost
FROM orderdetails
INNER JOIN products ON orderdetails.productCode = products.productCode
INNER JOIN orders ON orderdetails.orderNumber = orders.orderNumber
INNER JOIN customers ON orders.customerNumber = customers.customerNumber
;

//----------QURIED QUANTITY_ORDERED, PRODUCT_NAME AND PRICE------------

SELECT orderdetails.quantityOrdered, orderdetails.priceEach, products.productName
FROM orderdetails
INNER JOIN products ON orderdetails.productCode = products.productCode;



//----------------QUERIES PERFORMED ON PAYMENT--------------

SELECT * FROM classicmodels.payments;
USE classicmodels;

//----------------SELECTED AVG AMOUNT GROUOED BY PAYMENT DATE--------------------

SELECT paymentDate, AVG(amount)
FROM classicmodels.payments
GROUP BY paymentDate
ORDER BY AVG(amount) DESC;

//-----------------QUERIED PAYMENT_DATE, AMOUNT AND CUSTOMER_NAME-----------

SELECT payments.paymentDate, payments.amount, customers.customerName
FROM payments
INNER JOIN customers
ON payments.customerNumber = customers.customerNumber;


//-----------------SELECTED AMOUNT GROUPED BY CUSTOMER_NUMBER----------------

SELECT customerNumber, amount
FROM classicmodels.payments
GROUP BY customerNumber
ORDER BY amount DESC;



SELECT 
    customerNumber, 
    paymentDate, 
    amount
FROM
    payments
WHERE
    amount > (SELECT 
            AVG(amount)
        FROM
            payments);


//----------- TRANSACTION FOR ADDING INFO INTO PAYMENTS AND ORDER_DETAILS TABLES---------

START TRANSACTION;

INSERT INTO payments (customerNumber, checkNumber, paymentDate, amount)
VALUES (103, 'ZL224557', '2004-09-09', 200);

INSERT INTO orderDetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber) 
VALUES (10102, 'S18_1749', 12, 50, 4);

COMMIT;



//-------------QUERIES PERFORMED ON OFFICE TABLE----------

//------------ADDED INDEX ON PHONE_NO--------------------

CREATE INDEX phone_index ON offices(phone);




//--------------QUERIES PERFORMED ON ORDERS TABLE-----------------

START TRANSACTION;

-- 2. Get the latest order number
SELECT 
    @orderNumber:=MAX(orderNUmber)+1
FROM
    orders;

-- 3. insert a new order for customer 145
INSERT INTO orders(orderNumber,
                   orderDate,
                   requiredDate,
                   shippedDate,
                   status,
                   customerNumber)
VALUES(@orderNumber,
       '2005-05-31',
       '2005-06-10',
       '2005-06-11',
       'In Process',
        145);
        
-- 4. Insert order line items
INSERT INTO orderdetails(orderNumber,
                         productCode,
                         quantityOrdered,
                         priceEach,
                         orderLineNumber)
VALUES(@orderNumber,'S18_1749', 30, '136', 1),
      (@orderNumber,'S18_2248', 50, '55.09', 2); 
      
-- 5. commit changes    
COMMIT;


SELECT 
    a.orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber,
    orderLineNumber,
    productCode,
    quantityOrdered,
    priceEach
FROM
    orders a
        INNER JOIN
    orderdetails b USING (orderNumber)
WHERE
    a.ordernumber = 10426;
