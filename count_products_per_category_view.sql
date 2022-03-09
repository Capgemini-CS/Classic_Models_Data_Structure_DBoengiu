CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `classicmodels`.`count_products_per_category` AS
    SELECT 
        COUNT(`classicmodels`.`products`.`productCode`) AS `COUNT(productCode)`,
        `classicmodels`.`products`.`productLine` AS `productLine`
    FROM
        `classicmodels`.`products`
    GROUP BY `classicmodels`.`products`.`productLine`
    ORDER BY COUNT(`classicmodels`.`products`.`productCode`) DESC