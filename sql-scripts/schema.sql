CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Name TEXT NOT NULL,
    Email VARCHAR(50) UNIQUE NOT NULL,
    Phone TEXT,
    City TEXT,
    State TEXT,
    JoinDate DATE
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY AUTO_INCREMENT,
    Name TEXT NOT NULL,
    Category TEXT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INTEGER NOT NULL
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY AUTO_INCREMENT,
    CustomerID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INTEGER PRIMARY KEY AUTO_INCREMENT,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Quantity INTEGER NOT NULL,
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Regions (
    RegionID INTEGER PRIMARY KEY AUTO_INCREMENT,
    RegionName TEXT NOT NULL,
    State TEXT NOT NULL
);