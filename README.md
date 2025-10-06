# Online_Book_Store_MySQL_Project.
I developed a comprehension project in MySQL and to design and query a MySQL relational database for an online bookstore.

## Project Overview.
This project demonstrates how to design and query a MySQL relational database for an online bookstore.
The database is populated using three CSV files:
Books.csv → contains details of available books (Book ID, Title, Author, Price, Genre,Published Year,Stock)
Customers.csv → contains customer details (Customer ID, Name, Email, Phone,City,Country)
Orders.csv → contains purchase records (Order ID, Customer ID, Book ID, Quantity, Order Date, Quantity,Total Amount)
The project explores SQL concepts such as joins, aggregation, filtering, and grouping to answer real-world bookstore management queries.

## How to Run
Import the CSV files into MySQL using Workbench or LOAD DATA INFILE.
Execute the create_tables.sql file to create tables and insert data.
Run queries.sql to explore insights about the bookstore.
## Future Enhancements

Add more customer behavior analytics (most active customers, repeat purchases).
Implement stored procedures and triggers (e.g., auto-update stock after orders).
