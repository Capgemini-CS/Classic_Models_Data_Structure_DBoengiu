CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `classicmodels`.`count_products_by_product_scale` AS
    SELECT 
        COUNT(`classicmodels`.`products`.`productCode`) AS `COUNT(productCode)`,
        `classicmodels`.`products`.`productScale` AS `productScale`,
        `classicmodels`.`products`.`quantityInStock` AS `quantityInStock`
    FROM
        `classicmodels`.`products`
    GROUP BY `classicmodels`.`products`.`productScale`
    ORDER BY `classicmodels`.`products`.`quantityInStock` DESC