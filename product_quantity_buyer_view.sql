CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `classicmodels`.`new_view` AS
    SELECT 
        `classicmodels`.`orderdetails`.`quantityOrdered` AS `quantityOrdered`,
        `classicmodels`.`orderdetails`.`priceEach` AS `priceEach`,
        `classicmodels`.`products`.`productName` AS `productName`,
        `classicmodels`.`orders`.`customerNumber` AS `customerNumber`,
        `classicmodels`.`customers`.`customerName` AS `customerName`,
        (`classicmodels`.`orderdetails`.`quantityOrdered` * `classicmodels`.`orderdetails`.`priceEach`) AS `totalCost`
    FROM
        (((`classicmodels`.`orderdetails`
        JOIN `classicmodels`.`products` ON ((`classicmodels`.`orderdetails`.`productCode` = `classicmodels`.`products`.`productCode`)))
        JOIN `classicmodels`.`orders` ON ((`classicmodels`.`orderdetails`.`orderNumber` = `classicmodels`.`orders`.`orderNumber`)))
        JOIN `classicmodels`.`customers` ON ((`classicmodels`.`orders`.`customerNumber` = `classicmodels`.`customers`.`customerNumber`)))