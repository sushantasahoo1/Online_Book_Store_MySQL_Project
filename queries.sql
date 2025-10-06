-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
SELECT * FROM onlinebookstore.books;

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
SELECT * FROM onlinebookstore.Customers;

DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM onlinebookstore.Orders;

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM onlinebookstore.books WHERE Genre="Fiction";

-- 2) Find books published after the year 1950:

SELECT * FROM onlinebookstore.books WHERE Published_Year > 1950;

-- 3) List all customers from the Canada:
SELECT * FROM onlinebookstore.customers WHERE Country="Canada";

-- 4) Show orders placed in November 2023:
SELECT * FROM onlinebookstore.Orders WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Stock FROM onlinebookstore.books;

-- 6) Find the details of the most expensive book:
SELECT * FROM onlinebookstore.books ORDER BY Price DESC LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM onlinebookstore.Orders WHERE Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM onlinebookstore.Orders WHERE Total_Amount>20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre  FROM onlinebookstore.books;

-- 10) Find the book with the lowest stock:
SELECT * FROM onlinebookstore.Books ORDER BY Stock ASC LIMIT 1;  

-- 11) Calculate the total revenue generated from all orders
SELECT SUM(Total_Amount) as Revenue FROM onlinebookstore.Orders;

-- 12) Retrieve the total number of books sold for each genre:

SELECT b.Genre, SUM(o.Quantity) AS Total_Book_Sold 
FROM onlinebookstore.orders o 
JOIN onlinebookstore.books b 
ON o.BOOK_ID = b.BOOK_ID
GROUP BY Genre;


-- 13) Find the average price of books in the "Fantasy" genre:

SELECT AVG(Price)  As Average_Price FROM onlinebookstore.books 
WHERE Genre="Fantasy";

-- 14) List customers who have placed at least 2 orders:
SELECT c.Customer_ID,c.Name,COUNT(o.Order_ID) AS Order_Count 
FROM  onlinebookstore.Orders o 
JOIN onlinebookstore.Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING COUNT(o.Order_ID) >= 2;

-- 15) Find the most frequently ordered book:
SELECT o.Book_ID,COUNT(o.Order_ID) as Order_Count FROM 
onlinebookstore.orders o 
GROUP BY o.Book_ID ORDER BY Order_Count DESC LIMIT 1;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT  * FROM onlinebookstore.Books b
WHERE b.Genre='Fantasy' ORDER BY Price LIMIT 3;


-- 17) Retrieve the total quantity of books sold by each author:
SELECT b.Author,SUM(o.Quantity) AS Total_Quantity 
FROM onlinebookstore.Books b JOIN 
onlinebookstore.Orders o ON b.BOOK_ID=o.BOOK_ID GROUP BY b.Author;

-- 18) List the cities where customers who spent over $30 are located:
SELECT DISTINCT(c.City), o.Total_Amount 
FROM onlinebookstore.Customers c JOIN 
onlinebookstore.Orders o ON c.CUSTOMER_ID=O.CUSTOMER_ID 
where o.Total_Amount>30;

-- 19) Find the customer who spent the most on orders:
SELECT c.Customer_ID,c.Name, ROUND(SUM(o.Total_Amount),2) AS Total_Spent 
FROM onlinebookstore.Customers c JOIN onlinebookstore.Orders o ON c.CUSTOMER_ID=O.CUSTOMER_ID 
GROUP BY c.Customer_ID,c.Name ORDER BY Total_Spent DESC LIMIT 1; 

-- 20) Calculate the stock remaining after fulfilling all orders:
SELECT b.BOOK_ID,b.Title,b.Stock,COALESCE(SUM(o.Quantity),0) AS Order_Quantity,b.Stock-COALESCE(SUM(o.Quantity),0) AS Remaing_Stock 
FROM onlinebookstore.Books b LEFT JOIN onlinebookstore.Orders o ON b.BOOK_ID=o.BOOK_ID
GROUP BY b.Book_ID,b.Title,b.Stock ORDER BY b.Book_ID;