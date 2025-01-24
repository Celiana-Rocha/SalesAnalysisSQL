DELIMITER $$

CREATE PROCEDURE MonthlySalesReport()
BEGIN
    SELECT 
        DATE_FORMAT(OrderDate, '%Y-%m') AS Month, -- Formata a data para 'YYYY-MM'
        SUM(TotalAmount) AS TotalSales           -- Soma os valores totais das vendas
    FROM 
        Orders
    GROUP BY 
        Month
    ORDER BY 
        Month;
END $$

DELIMITER ;

CALL MonthlySalesReport();
