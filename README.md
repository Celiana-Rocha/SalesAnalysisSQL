# Documentation of the Sales Data Analysis and Performance Project

## **1. Introduction**
This project was developed to demonstrate advanced SQL skills through a database that simulates a sales system. It includes data modeling, data insertion and manipulation, advanced queries, stored procedures, triggers, and views. Below, we detail the steps and techniques applied in the development of the project.

---

## **2. Technologies Used** 🕹
The following technologies and tools were utilized in this project:

- **MySQL** ![MySQL](https://img.shields.io/badge/MySQL-483d8b?style=for-the-badge&logo=mysql&logoColor=white): Relational database management system used to create and manage the database.
- **Python** ![Python](https://img.shields.io/badge/Python-483d8b?style=for-the-badge&logo=python&logoColor=white): Programming language used for automating data insertion and generating reports.
- **Faker Library** ![Faker](https://img.shields.io/badge/Faker-483d8b?style=for-the-badge&logo=python&logoColor=white): Python library used for generating realistic fake data.
- **MySQL Workbench** ![Workbench](https://img.shields.io/badge/MySQL_Workbench-483d8b?style=for-the-badge&logo=mysql&logoColor=white): Tool for designing, managing, and querying the database.
- **GitHub** ![GitHub](https://img.shields.io/badge/GitHub-483d8b?style=for-the-badge&logo=github&logoColor=white): Platform for version control and collaboration.

---

## **3. Database Modeling** 🧩
The database was designed to simulate a sales system and includes the following main tables:

1. **Products**: Stores information about the products available for sale.
   - Example columns: `ProductID`, `ProductName`, `StockQuantity`.

2. **Orders**: Records customer orders.
   - Example columns: `OrderID`, `OrderDate`, `TotalAmount`.

3. **OrderDetails**: Details the products included in each order.
   - Example columns: `OrderDetailID`, `OrderID`, `ProductID`, `Quantity`.

---

## **4. Development Steps** 👷‍♀️

### **Step 1: Database and Table Creation**
SQL commands to create the necessary tables and relationships:

```sql
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    StockQuantity INT
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

---

### **Step 2: Data Insertion** 
Data insertion was automated using Python and the **Faker** library to generate fictional data.

#### Python Script Example:
```python
from faker import Faker
import mysql.connector

# Database connection
conn = mysql.connector.connect(
    host='localhost',
    user='your_user',
    password='your_password',
    database='your_database'
)
cursor = conn.cursor()

faker = Faker()

# Generate fictional data
for _ in range(100):
    product_name = faker.word()
    stock_quantity = faker.random_int(min=10, max=100)
    cursor.execute("INSERT INTO Products (ProductName, StockQuantity) VALUES (%s, %s)", (product_name, stock_quantity))

conn.commit()
conn.close()
```

---

### **Step 3: Advanced Queries**
Queries were developed to extract insights from the database. Examples:

1. **Query: Monthly Revenue**
```sql
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY Month
ORDER BY Month;
```

2. **Query: Best-Selling Products**
```sql
SELECT 
    P.ProductName,
    SUM(OD.Quantity) AS TotalSold
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY TotalSold DESC;
```

---

### **Step 4: Creating Views**
Views were created to simplify queries and facilitate access to specific information.

#### Example View: Monthly Revenue
```sql
CREATE VIEW MonthlySales AS
SELECT 
    DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
    SUM(TotalAmount) AS TotalSales
FROM Orders
GROUP BY Month
ORDER BY Month;
```

---

### **Step 5: Triggers**
Triggers were configured to automate processes, such as updating stock after an order.

#### Example Trigger: Stock Update
```sql
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
```

---

### **Step 6: Stored Procedures** 
Procedures were created to automate queries and generate reports.

#### Example Procedure: Monthly Sales Report
```sql
DELIMITER $$

CREATE PROCEDURE MonthlySalesReport()
BEGIN
    SELECT 
        DATE_FORMAT(OrderDate, '%Y-%m') AS Month,
        SUM(TotalAmount) AS TotalSales
    FROM 
        Orders
    GROUP BY 
        Month
    ORDER BY 
        Month;
END $$

DELIMITER ;
```
To execute:
```sql
CALL MonthlySalesReport();
```

---

## **7. Final Considerations** 🚀

This project demonstrates a practical approach to creating a robust SQL database and applying advanced functionalities such as triggers, views, and stored procedures.

### **Possible Improvements** 🚧
- Implement stricter validations to prevent negative stock.
- Add more tables, such as `Customers` (clients) and `Categories` (product categories), to enrich the data model.
- Automate the generation of graphical reports by integrating with Python libraries like Matplotlib or Power BI.






