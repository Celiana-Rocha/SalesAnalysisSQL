
DELIMITER $$

CREATE TRIGGER UpdateStock
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
    UPDATE Products
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END $$

DELIMITER ;

