# 🌟 Super Shop Management System

---

## 🛒 Project Overview

Welcome to the **Super Shop Management System** — a robust SQL database solution crafted to streamline and automate retail super shop operations. This system efficiently manages everything from product inventories, suppliers, customers, purchases, and sales to complex reporting and auditing.

Designed for scalability and real-world usage, this project incorporates advanced SQL concepts including stored procedures, triggers, user-defined functions, and more, ensuring data integrity and powerful data insights.

---

## 🚀 Key Features

### Database Design & Integrity

* ✅ **Normalized tables** for Products, Categories, Suppliers, Customers, Purchases, Sales, and their details
* ✅ Strong **primary and foreign key constraints** for data consistency
* ✅ Automated **auditing using triggers** (AFTER & INSTEAD OF) to track data changes
* ✅ Stored procedures for safe and reusable data operations

### Powerful Data Operations

* 📥 Bulk **data insertion** for categories, products, suppliers, customers, and transactions
* 🔍 Comprehensive **SELECT queries** with joins, filters, and aggregations
* 🔄 Efficient **updates** to totals via subqueries
* ❌ Controlled **deletions** with referential integrity enforcement

### Advanced SQL Techniques

* 🧩 **Joins**: INNER, LEFT, RIGHT for combined data views
* 🧮 **Aggregate functions**: SUM, AVG, MIN, MAX, COUNT with grouping
* 🧰 **CTEs & Recursive CTEs** for hierarchical and complex queries
* 🛠️ **User-defined functions** for reusable logic and calculations
* 🔀 **MERGE & UNION** for elegant data merging and set operations
* 🎯 **Conditional logic** with CASE, IIF, CHOOSE, IF...ELSE
* 📅 **Date and String functions**: CAST, CONVERT, LEFT, RIGHT, CONCAT, and more

---

## 📂 Database Structure Summary

| Object Type               | Description                                                               |
| ------------------------- | ------------------------------------------------------------------------- |
| **Tables**                | Products, Categories, Suppliers, Customers, Purchases, Sales, and Details |
| **Views**                 | Simplify complex query results for reports                                |
| **Stored Procedures**     | Insert, update, delete operations on Customers and other entities         |
| **Triggers**              | AFTER and INSTEAD OF triggers for auditing and control                    |
| **Functions**             | Scalar, Table-valued, and Multi-statement functions                       |
| **Indexes & Constraints** | Primary/foreign keys and validation rules                                 |

---

## ⚙️ How to Use

1. **Setup Database**
   Run the DDL scripts to create the database schema with tables, triggers, and functions.

2. **Insert Initial Data**
   Execute the DML scripts to populate categories, products, suppliers, customers, purchases, and sales.

3. **Test Stored Procedures & Triggers**
   Use provided procedures to test CRUD operations and verify triggers work correctly.

4. **Run Queries & Reports**
   Utilize provided sample queries to extract useful business insights and reports.

5. **Extend & Customize**
   Modify or add tables, procedures, and business logic as per your super shop requirements.

---

## 📊 Sample Queries

### Total Sales on a Specific Day

```sql
SELECT dbo.fn_GetTotalSalesForDay(GETDATE()) AS TotalSalesForToday;
```

### Product Details by Product ID

```sql
SELECT * FROM dbo.fn_GetProductDetailsByProductID(1);
```

### Sales Summary by Category

```sql
WITH CTE_CategorySales AS (
    SELECT pc.CategoryName, SUM(sd.Quantity * sd.Price) AS TotalSalesAmount
    FROM ProductCategory pc
    JOIN Product p ON pc.CategoryID = p.CategoryID
    JOIN SalesDetail sd ON p.ProductID = sd.ProductID
    GROUP BY pc.CategoryName
)
SELECT CategoryName, TotalSalesAmount FROM CTE_CategorySales
ORDER BY TotalSalesAmount DESC;
```

---

## 👩‍💻 About the Author

**Jasmin Akhter**
* Passionate about building scalable database solutions and learning advanced SQL!

---

## 📄 License

This project is for educational purposes. Feel free to adapt and improve for your own learning or development.

---

## 🙌 Thank You!


