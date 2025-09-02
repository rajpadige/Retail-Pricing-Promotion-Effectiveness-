```sql
-- analysis.sql: SQL queries for Retail Pricing & Promotion Effectiveness project
-- Purpose: Aggregate sales data and calculate demand elasticity

-- Create schema and table for simulated e-commerce dataset
CREATE SCHEMA IF NOT EXISTS retail_pricing;

CREATE TABLE IF NOT EXISTS retail_pricing.sales_data (
    sale_id INT PRIMARY KEY,
    product_category VARCHAR(50),
    region VARCHAR(20),
    units_sold INT,
    unit_price DECIMAL(10,2),
    discount_pct DECIMAL(5,2),
    campaign_type VARCHAR(50),
    sale_date DATE
);

-- Insert sample data (simplified for demonstration)
INSERT INTO retail_pricing.sales_data VALUES
(1, 'Electronics', 'Test', 100, 200.00, 10.00, 'Flash Sale', '2022-06-01'),
(2, 'Electronics', 'Control', 80, 200.00, 0.00, 'None', '2022-06-01'),
(3, 'Apparel', 'Test', 150, 50.00, 15.00, 'Seasonal', '2022-06-01'),
(4, 'Apparel', 'Control', 120, 50.00, 0.00, 'None', '2022-06-01');

-- Query 1: Calculate average units sold and revenue by category and discount
SELECT 
    product_category,
    discount_pct,
    AVG(units_sold) AS avg_units_sold,
    AVG(units_sold * unit_price * (1 - discount_pct/100)) AS avg_revenue
FROM retail_pricing.sales_data
GROUP BY product_category, discount_pct
ORDER BY product_category, discount_pct;

-- Query 2: Demand elasticity (percentage change in units sold vs. discount)
WITH elasticity AS (
    SELECT 
        product_category,
        region,
        discount_pct,
        AVG(units_sold) AS avg_units_sold,
        LAG(AVG(units_sold)) OVER (PARTITION BY product_category ORDER BY discount_pct) AS prev_units_sold
    FROM retail_pricing.sales_data
    GROUP BY product_category, region, discount_pct
)
SELECT 
    product_category,
    region,
    discount_pct,
    CASE 
        WHEN prev_units_sold IS NOT NULL 
        THEN ((avg_units_sold - prev_units_sold) / prev_units_sold) / (discount_pct / 100)
        ELSE NULL 
    END AS elasticity
FROM elasticity
WHERE prev_units_sold IS NOT NULL;

-- Query 3: Promotional lift in test vs. control regions
SELECT 
    product_category,
    campaign_type,
    AVG(CASE WHEN region = 'Test' THEN units_sold END) AS test_units_sold,
    AVG(CASE WHEN region = 'Control' THEN units_sold END) AS control_units_sold,
    (AVG(CASE WHEN region = 'Test' THEN units_sold END) - 
     AVG(CASE WHEN region = 'Control' THEN units_sold END)) / 
     AVG(CASE WHEN region = 'Control' THEN units_sold END) * 100 AS lift_pct
FROM retail_pricing.sales_data
WHERE campaign_type != 'None'
GROUP BY product_category, campaign_type;
```
