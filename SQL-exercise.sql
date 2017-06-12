use Northwind
/** Opdracht 2.1 **/

/** All customers in londen, below 5 orders **/

SELECT Customers.CustomerID, CompanyName, COUNT(Orders.OrderID) as NumberOfOrders
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID AND
Customers.City = 'London'
GROUP BY Customers.CustomerID, CompanyName
HAVING COUNT(Orders.OrderID) < 5


/** Opdracht 2.2 **/

/** Select all orders for Pavlova above 800 sales **/

SELECT ProductID as Pavlova, UnitPrice, Quantity, Discount, ((Quantity-Discount)*UnitPrice) as Sales
FROM [Order Details]
Where [Order Details].ProductID IN
(SELECT ProductID
From Products
Where ProductName = 'Pavlova')
AND ((Quantity-Discount)*UnitPrice) >= 800


/** Opdracht 2.3 **/

/** Select all regions where chocolate is saled **/

SELECT  [Order Details].ProductID, Region.RegionID, Region.RegionDescription
FROM Products 
INNER JOIN [Order Details] ON  [Order Details].ProductID = Products.ProductID
INNER JOIN Orders ON  Orders.OrderID = [Order Details].OrderID
INNER JOIN Employees ON  Employees.EmployeeID = Orders.EmployeeID
INNER JOIN EmployeeTerritories on EmployeeTerritories.EmployeeID = Employees.EmployeeID
INNER JOIN Territories ON Territories.TerritoryID = EmployeeTerritories.TerritoryID
INNER JOIN Region ON Region.RegionID = Territories.RegionID
WHERE ProductName = 'Chocolade'
GROUP BY Region.RegionID, RegionDescription, [Order Details].ProductID

/** Opdracht 2.4 **/

/** All Tofu Orders with freith cost betwen 25 50 **/

SELECT ProductName, Customers.CompanyName,Orders.OrderID, Freight
FROM Products
INNER JOIN [Order Details] ON  [Order Details].ProductID = Products.ProductID
INNER JOIN Orders ON  Orders.OrderID = [Order Details].OrderID
INNER JOIN Customers On Customers.CustomerID = Orders.CustomerID
WHERE ProductName = 'Tofu' AND
 Freight BETWEEN 25 AND 50


 /** Opdracht 2.5 **/

 /** Select all cities where clients and employees live **/
SELECT Customers.City as CustomerCity, Employees.City as EmployeeCity
FROM Customers
INNER JOIN Orders ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
WHERE Employees.City = Customers.City
GROUP BY Employees.City , Customers.City


 /** Opdracht 2.6 **/

 /** Which product is most sold for German customers, and which employees sold these items **/
SELECT top 5 ProductName,   Products.ProductID, COUNT(Products.ProductID) as Amount, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title
FROM Products
INNER JOIN [Order Details] ON  [Order Details].ProductID = Products.ProductID
INNER JOIN Orders ON  Orders.OrderID = [Order Details].OrderID
INNER JOIN Customers On Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees On Employees.EmployeeID = Orders.EmployeeID
WHERE Customers.Country = 'Germany'
Group BY  ProductName, Products.ProductID, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title
ORDER BY Count(Products.ProductID) DESC 


 /** Opdracht 2.7 **/

 /** Which product has the highest sales in Germany, who sold those products **/

 SELECT TOP 5 ProductName, Products.ProductID, (([Order Details].Quantity- [Order Details].Discount)* [Order Details].UnitPrice) as Sales, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title
FROM Products
INNER JOIN [Order Details] ON  [Order Details].ProductID = Products.ProductID
INNER JOIN Orders ON  Orders.OrderID = [Order Details].OrderID
INNER JOIN Customers On Customers.CustomerID = Orders.CustomerID
INNER JOIN Employees On Employees.EmployeeID = Orders.EmployeeID
WHERE Customers.Country = 'Germany'
Group BY  ProductName, Products.ProductID,  [Order Details].Quantity,  [Order Details].Discount,  [Order Details].UnitPrice , Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title
ORDER BY (([Order Details].Quantity- [Order Details].Discount)* [Order Details].UnitPrice) DESC

 /** Opdracht 2.8 **/
 
 /** Join Products and Suppliers with Inner Join (only matching results between two tables **/

 SELECT *
 FROM Products
 INNER JOIN Suppliers ON Suppliers.SupplierID = Products.SupplierID


  /** Join Products and Suppliers with Left Join (all product results + matching results with suppliers**/

   SELECT *
 FROM Products
 LEFT JOIN Suppliers ON Suppliers.SupplierID = Products.SupplierID


   /** Join Products and Suppliers with Right Join (all supplier results + matching results with products**/
      SELECT *
 FROM Products
 Right JOIN Suppliers ON Suppliers.SupplierID = Products.SupplierID

    /** Join Products and Suppliers with Full Join (all results that either match with supplier or product**/

	   SELECT *
 FROM Products
 FULL OUTER JOIN Suppliers ON Suppliers.SupplierID = Products.SupplierID

  /** Opdracht 2.8 **/

  /** Average result from each employee **/

 SELECT ROUND(AVG(([Order Details].Quantity- [Order Details].Discount)* [Order Details].UnitPrice),2) as Average_SalesResult, Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title
FROM [Order Details]
INNER JOIN Orders ON  Orders.OrderID = [Order Details].OrderID
INNER JOIN Employees On Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.LastName, Employees.FirstName, Employees.Title
ORDER BY ROUND(AVG(([Order Details].Quantity- [Order Details].Discount)* [Order Details].UnitPrice),2)