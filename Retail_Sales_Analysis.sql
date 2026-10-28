-- What is the overall scale of the business's recorded sales?

SELECT
    SUM(Sales_Amount) AS Total_Sales_Revenue,
    SUM(Quantity_Sold) AS Total_Quantity_Sold,
    COUNT(*) AS Total_Sales_Records,
    COUNT(DISTINCT Product_ID) AS Distinct_Products
FROM innomatics.default.sales_dataset;


-- Which five products contribute the most to recorded sales revenue?

SELECT
    Product_ID,
    SUM(Sales_Amount) AS Total_Sales_Revenue,
    SUM(Quantity_Sold) AS Total_Quantity_Sold
FROM innomatics.default.sales_dataset
GROUP BY Product_ID
ORDER BY Total_Sales_Revenue DESC
LIMIT 5;


-- Which regions perform best, and which may need further investigation?

SELECT
    Region,
    SUM(Sales_Amount) AS Total_Sales_Revenue,
    SUM(Quantity_Sold) AS Total_Quantity_Sold
FROM innomatics.default.sales_dataset
GROUP BY Region
ORDER BY Total_Sales_Revenue DESC;



-- How does recorded sales revenue change over time?

SELECT
    DATE_TRUNC('MONTH', Sale_Date) AS Sales_Month,
    SUM(Sales_Amount) AS Total_Sales_Revenue
FROM innomatics.default.sales_dataset
GROUP BY DATE_TRUNC('MONTH', Sale_Date)
ORDER BY Sales_Month ASC;


-- Which product categories contribute most to recorded sales?

SELECT
    Product_Category,
    SUM(Sales_Amount) AS Total_Sales_Revenue,
    ROUND(
        SUM(Sales_Amount) * 100.0 /
        SUM(SUM(Sales_Amount)) OVER (),
        2
    ) AS Sales_Percentage
FROM innomatics.default.sales_dataset
GROUP BY Product_Category
ORDER BY Total_Sales_Revenue DESC;