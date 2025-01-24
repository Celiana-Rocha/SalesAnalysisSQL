CREATE VIEW TopSellingProducts AS
SELECT 
    p.Name AS Product,
    SUM(od.Quantity) AS TotalQuantitySold
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalQuantitySold DESC;
