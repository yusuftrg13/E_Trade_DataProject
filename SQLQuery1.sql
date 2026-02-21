---Select the database
use ETRADE2

---Sort the name,surnae,gender
Select NAMESURNAME,GENDER,CITY,TOWN
FROM dbo.CUSTOMERS

--Find out the customers who are living in the city of "Adana"
Select NAMESURNAME,GENDER,TELNR,CITY
FROM dbo.CUSTOMERS
WHERE CITY='Adana' 

--Find out the customers who are living in the city of "Adana" and Gender = "Kadın"
Select NAMESURNAME,TELNR,CITY,BIRTHDATE
FROM dbo.CUSTOMERS
WHERE CITY='Adana' and GENDER='K'

--Find out the customers who name is Ahmet
SELECT NAMESURNAME, TELNR ,CITY,TOWN
FROM dbo.CUSTOMERS 
WHERE NAME_ LIKE 'Ahmet%';

--How many people are there in Adana ?
SELECT COUNT(*) AS AdanaPopulation
FROM dbo.CUSTOMERS
WHERE CITY='Adana'

--How many women and men are there in Adana
Select 
   GENDER as Cinsiyet,
   COUNT(*) As ToplamKisiCinsiyeteGöre
   FROM dbo.CUSTOMERS
   WHERE CITY='Adana'
   GROUP BY GENDER
--Determine the ages of customers 
Select 
  NAMESURNAME,
  BIRTHDATE,
  DATEDIFF(YEAR, BIRTHDATE, GETDATE()) AS AGE
  FROM dbo.CUSTOMERS

--Test the CUSTOMERS
Select * FROM dbo.CUSTOMERS

--How many customers are there who are older than 35 years
Select
  COUNT(*) AS OlderThan35
  FROM dbo.CUSTOMERS
  WHERE DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 35 AND CITY='Adana'

--Work with dbo.ITEMS

--take a look at the items table
Select ITEMCODE,ITEMNAME,BUYINGPRICE,SALEPRICE
FROM dbo.ITEMS

--Calculate the profit and sort the list
Select
  ITEMCODE,
  ITEMNAME,
  BUYINGPRICE,
  SALEPRICE,
  (SALEPRICE-BUYINGPRICE) AS PROFIT
From dbo.ITEMS
ORDER BY PROFIT DESC

--Determine the BRAND
Select BRAND FROM dbo.ITEMS

--We will filter the one of the brands
Select
   ITEMCODE,
   ITEMNAME,
   BUYINGPRICE,
   SALEPRICE,
   (SALEPRICE-BUYINGPRICE) AS PROFIT,
   BRAND
   FROM dbo.ITEMS
   WHERE BRAND='Ulker'
ORDER BY PROFIT DESC


--I would like to see the categories
Select CATEGORY1,CATEGORY2,CATEGORY3,CATEGORY4 FROM dbo.ITEMS 

Select * From ITEMS

SELECT ITEMCODE, ITEMNAME, BRAND, SALEPRICE 
FROM dbo.ITEMS 
WHERE ITEMNAME LIKE '%Laptop%';

--Is there a electronic?
Select ITEMNAME,CATEGORY1,CATEGORY2,CATEGORY3
FROM dbo.ITEMS
WHERE CATEGORY1='Elektronik' OR CATEGORY2='Elektronik' OR CATEGORY3='Elektronik' OR CATEGORY4='Elektronik'

--Profit marge
SELECT
   ITEMCODE,
   ITEMNAME,
   BRAND,
   (SALEPRICE - BUYINGPRICE) AS PROFIT,
   ((SALEPRICE - BUYINGPRICE) * 100.0 / NULLIF(SALEPRICE, 0)) AS PROFITMARGE
FROM dbo.ITEMS
ORDER BY PROFITMARGE DESC;
 
 -- Let's calculate with the taxes which name is KDV
 Select
    ITEMNAME,
    SALEPRICE AS PRICEWITHOUTTAX,
    (SALEPRICE * 1.20) AS PRICEWITHTAX
    FROM dbo.ITEMS

Select ITEMNAME,BUYINGPRICE
FROM dbo.ITEMS
WHERE BUYINGPRICE > 1000

--TOP 5 VALUABLE ITEMS
SELECT TOP 5 ITEMCODE,ITEMNAME,SALEPRICE
FROM dbo.ITEMS
ORDER BY SALEPRICE DESC

-- TOP10 CHEAP ITEMS
SELECT TOP 10 ITEMCODE,ITEMNAME,SALEPRICE,BRAND
FROM dbo.ITEMS
ORDER BY SALEPRICE ASC

--SORT THE WHOLE BRAND
SELECT DISTINCT BRAND
FROM DBO.ITEMS
ORDER BY BRAND ASC

SELECT DISTINCT CATEGORY1,CATEGORY2
FROM dbo.ITEMS
ORDER BY CATEGORY1,CATEGORY2 ASC

--Let's use the between
SELECT 
    ITEMCODE,
    ITEMNAME,
    CATEGORY1,
    CATEGORY2
    FROM dbo.ITEMS
    WHERE SALEPRICE BETWEEN 500 AND 1000
    ORDER BY SALEPRICE ASC;


--Check the null 
Select * From dbo.ITEMS
WHERE BRAND IS NULL


--Examine the transaction
SELECT FICHENO,DATE_,CUSTOMERNAME,ITEMNAME,TOTALPRICE
FROM dbo.SALES

--Let's figure out the sales that sold in Hatay
Select CUSTOMERNAME,ITEMNAME,TOTALPRICE,DISTRICT
FROM dbo.SALES
WHERE CITY='Hatay' and DISTRICT='İskenderun'

--Let's figure out the expensive sales
Select TOP 10 FICHENO,CUSTOMERNAME,TOTALPRICE,DATE_
FROM dbo.SALES
ORDER BY TOTALPRICE DESC

Select TOP 10 FICHENO,CUSTOMERNAME,TOTALPRICE,CITY,DISTRICT,DATE_
FROM dbo.SALES
ORDER BY TOTALPRICE ASC


--check the accuracy of the sales
SELECT
  FICHENO,
  ITEMNAME,
  AMOUNT,
  PRICE,
  (AMOUNT*PRICE) As CALCULATEDTOTALPRICE,
  TOTALPRICE AS RECORDEDTOTALPRICE
  FROM dbo.SALES
  WHERE (AMOUNT * PRICE) != TOTALPRICE

--aggreagete functions
SELECT
   COUNT(*) AS TotalSales,
   SUM(TOTALPRICE) AS TotalRevenue,
   AVG(TOTALPRICE) AS AverageSalePrice,
   MIN(TOTALPRICE) AS MinimumSalePrice,
   MAX(TOTALPRICE) AS MaximumSalePrice
FROM dbo.SALES


Select 
  BRAND,
  SUM(TOTALPRICE) AS TotalRevenueByBrand,
  COUNT(ID) As SatisAdedi
  FROM dbo.SALES
  GROUP BY BRAND
  ORDER BY TotalRevenueByBrand DESC


SELECT
  CATEGORY1,
  AVG(TOTALPRICE) AS AverageRevenueByCategory1,
  COUNT(ID) AS SalesCountByCategory1
  FROM dbo.SALES
  GROUP BY CATEGORY1
  ORDER BY AverageRevenueByCategory1 DESC

--Total Revenue by Month
SELECT
  MONTHNAME_,
  SUM(TOTALPRICE) AS TotalRevenueByMonth,
  COUNT(ID) AS SalesCountByMonth
  FROM dbo.SALES
  GROUP BY MONTHNAME_
  ORDER BY TotalRevenueByMonth DESC


--Total Revenue by Gender

SELECT
  CUSTOMERGENDER,
  SUM(TOTALPRICE) AS TotalRevenueByGender
  FROM dbo.SALES
  GROUP BY CUSTOMERGENDER;

-- USİNG HAVİNG
SELECT
  BRAND,
  SUM(TOTALPRICE) AS TotalRevenueByBrand
FROM dbo.SALES
GROUP BY BRAND
HAVING SUM(TOTALPRICE) > 50000
ORDER BY TotalRevenueByBrand DESC

SELECT
  CUSTOMERNAME,
  COUNT(ID) AS TotalPurchases,
  SUM(TOTALPRICE) AS TotalSpent
  FROM dbo.SALES
  GROUP BY CUSTOMERNAME
  HAVING COUNT(ID)>=5
  ORDER BY TotalSpent DESC


  SELECT 
    FICHENO, 
    CUSTOMERNAME, 
    TOTALPRICE,
    CASE 
        WHEN TOTALPRICE < 5000 THEN 'Küçük Çaplı Satış'
        WHEN TOTALPRICE BETWEEN 5000 AND 50000 THEN 'Orta Çaplı Satış'
        ELSE 'Kurumsal / Büyük Satış'
    END AS SatisSegmenti
FROM dbo.SALES;

SELECT 
  BRAND,
  SUM(TOTALPRICE) AS TotalRevenueByBrand
  FROM dbo.SALES
  WHERE BRAND ='GEZER' and CITY='Adana'
  GROUP BY BRAND
  HAVING SUM(TOTALPRICE) > 1000
  ORDER BY TotalRevenueByBrand DESC

 



Select
  S.FICHENO As ficheno,
  S.DATE_ As SalesDATE,
  S.TOTALPRICE AS TotalPrice,
  C.NAMESURNAME AS CustomerName,
  C.TELNR AS CustomerPhone
FROM dbo.SALES AS S
INNER JOIN dbo.CUSTOMERS AS C ON S.CUSTOMERCODE = C.ID
WHERE C.CITY='HATAY' AND C.TOWN='İskenderun';

