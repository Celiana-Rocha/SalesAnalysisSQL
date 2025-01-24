# faturamento mensal

SELECT
	date_format(OrderDate, '%Y-%m') AS Month,
    SUM(TotalAmount) AS TotalSales
FROM
	orders
GROUP BY 
	Month
ORDER BY 
	Month;
    
# Produtos Mais Vendidos

SELECT 
    p.Name AS Product,
    SUM(od.Quantity) AS TotalQuantitySold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalQuantitySold DESC;

# Desempenho Regional

SELECT 
    r.RegionName,
    SUM(o.TotalAmount) AS TotalSales
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Regions r ON c.State = r.State
GROUP BY r.RegionName
ORDER BY TotalSales DESC;
