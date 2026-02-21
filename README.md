# E_Trade_DataProject

# E-Trade Data Analysis & Reporting with SQL 📊

## 🚀 Project Overview
This project demonstrates a comprehensive data analysis of a mock e-commerce database (`ETRADE2`) using **Microsoft SQL Server (T-SQL)**. 

As a **Data Analyst** candidate with a background in Economics & Finance, I performed various queries to extract actionable business insights, ranging from basic data exploration to complex reporting using joins and aggregations.

**Key Goals:**
* Analyze customer demographics and regional distribution.
* Calculate product profit margins and tax-inclusive prices.
* Evaluate sales performance by brand, category, and time.
* Identify high-value customers and "Star" brands.

## 🗄️ Database Structure
The project works with a relational database schema consisting of the following key tables:
* **`dbo.CUSTOMERS`**: Customer details (Name, City, Gender, Birthdate, Contact Info).
* **`dbo.ITEMS`**: Product inventory (Brand, Category, Buying/Selling Price).
* **`dbo.SALES`**: Transactional data (Fiche No, Date, Total Price, Amount).
* **`dbo.CITIES` / `dbo.TOWNS`**: Location data for geospatial analysis.

## 🛠️ Skills & Techniques Demonstrate
The SQL scripts in this repository cover the following technical concepts:

* **Data Cleaning & Filtering:** `WHERE`, `LIKE`, `IS NULL`, `BETWEEN`.
* **Calculated Fields:** Profit calculation, VAT (KDV) computation, Dynamic Age Calculation using `DATEDIFF`.
* **Aggregations:** `SUM`, `AVG`, `COUNT`, `MIN`, `MAX`.
* **Grouping & Segmentation:** `GROUP BY`, `HAVING` for filtering aggregated data.
* **Conditional Logic:** `CASE WHEN` for customer/sales segmentation (e.g., "VIP Sale" vs. "Standard Sale").
* **Joins:** `INNER JOIN` to combine Sales, Customers, and Locations tables.
* **Data Integrity Checks:** Verifying if `Amount * Price` matches the recorded `TotalPrice`.

## 💡 Sample Queries

### 1. Profit Margin Analysis
Calculating the profit and profit margin percentage for each item, handling division by zero errors.
```sql
SELECT
   ITEMCODE,
   ITEMNAME,
   BRAND,
   (SALEPRICE - BUYINGPRICE) AS PROFIT,
   ((SALEPRICE - BUYINGPRICE) * 100.0 / NULLIF(SALEPRICE, 0)) AS PROFIT_MARGIN
FROM dbo.ITEMS
ORDER BY PROFIT_MARGIN DESC;

<img width="1694" height="863" alt="Ekran görüntüsü 2026-02-21 222301" src="https://github.com/user-attachments/assets/3cc220ac-c68d-4a35-a1d8-86fee59ae2ba" />
