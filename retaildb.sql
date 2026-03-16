-- Create Database
CREATE DATABASE RetailDB;
USE RetailDB;

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    City VARCHAR(50),
    JoinDate DATE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Total Sales per Product
SELECT p.ProductName, SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC;

-- Sales by Category
SELECT p.Category, SUM(o.Quantity * p.Price) AS CategorySales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY CategorySales DESC;

-- Top 10 Customers by Total Spend
SELECT c.Name, SUM(o.Quantity * p.Price) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.Name
ORDER BY TotalSpent DESC
LIMIT 10;

-- Monthly Sales Trend
SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS Month, SUM(o.Quantity * p.Price) AS MonthlySales
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY Month
ORDER BY Month;

-- Orders by City
SELECT c.City, COUNT(o.OrderID) AS TotalOrders, SUM(o.Quantity * p.Price) AS TotalSales
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY c.City
ORDER BY TotalSales DESC;

