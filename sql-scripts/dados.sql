INSERT INTO Customers (Name, Email, Phone, City, State, JoinDate)
VALUES	('Alice Silva', 'alice.silva@email.com', '123456789', 'São Paulo', 'SP', '2023-01-15'),
		('Carlos Pereira', 'carlos.pereira@email.com', '987654321', 'Rio de Janeiro', 'RJ', '2023-03-22');

INSERT INTO Products (Name, Category, Price, StockQuantity)
VALUES	('Notebook', 'Eletrônicos', 3500.00, 15),
		('Smartphone', 'Eletrônicos', 2500.00, 30);
        
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES	(1, '2024-01-05', 6000.00),
		(2, '2024-01-10', 5000.00);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Subtotal)
VALUES	(1, 1, 2, 7000.00),
		(2, 2, 2, 5000.00);
        
INSERT INTO Regions (RegionName, State)
VALUES	('Sudeste', 'SP'),
		('Sudeste', 'RJ');
        