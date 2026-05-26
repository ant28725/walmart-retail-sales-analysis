-- =========================================================
-- Section 3: Profitability Analysis
-- Project: Walmart Retail Sales Performance Analysis
-- Purpose:
-- Analyze total profit, profit margin, profit per square foot,
-- and differences between sales volume and profitability.
-- =========================================================

-- 1. Overall profitability summary
-- Establishes total sales, estimated profit, COGS, and overall profit margin.

SELECT
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(cogs), 2) AS total_cogs,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_record_profit_margin_pct,
    ROUND(AVG(profit), 2) AS avg_profit_per_record
FROM public.walmart_sales;

-- Result Summary:
-- Total records: 421,570
-- Total sales: $6,737,218,987.11
-- Total estimated profit: $1,487,120,604.95
-- Total estimated COGS: $5,250,186,543.72
-- Overall profit margin: 22.07%
-- Average record-level profit margin: 20.77%
-- Average profit per record: $3,527.58

-- 2. Top stores by total profit
-- Identifies the stores generating the highest estimated profit and compares
-- total profit against profit margin and profit per square foot.

SELECT
    store,
    type,
    size,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(cogs), 2) AS total_cogs,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
    ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft
FROM public.walmart_sales
GROUP BY store, type, size
ORDER BY total_profit DESC
LIMIT 10;

-- Result Summary:
-- Store 20 had the highest estimated profit at $68,384,583.11.
-- Store 4 had the second-highest estimated profit at $67,347,113.21.
-- Store 14 had the third-highest estimated profit at $66,366,471.44.
-- Most top-profit stores were large Type A stores.
-- Store 10 stood out as a Type B store with $58,236,351.99 in estimated profit.
-- Store 10 had $460.32 profit per square foot, higher than the larger Type A stores ranked above it by total profit.
-- Total profit is strongly related to sales volume, but profit per square foot reveals additional efficiency differences.

-- 3. Bottom stores by total profit
-- Identifies the stores generating the lowest estimated profit and compares
-- total profit against profit margin and profit per square foot.

SELECT
    store,
    type,
    size,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(cogs), 2) AS total_cogs,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
    ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft
FROM public.walmart_sales
GROUP BY store, type, size
ORDER BY total_profit ASC
LIMIT 10;

-- Result Summary:
-- Store 33 had the lowest estimated profit at $9,414,875.46.
-- Store 5 had the second-lowest estimated profit at $9,625,920.16.
-- Store 44 had the third-lowest estimated profit at $10,657,819.51.
-- Several bottom-profit stores still had strong profit margins, including Store 33 at 25.34%, Store 44 at 24.62%, and Store 36 at 25.66%.
-- Low total profit often reflected smaller store size or lower sales volume rather than weak margins.
-- Store 29 remained a potential underperformance candidate because of its larger footprint and low profit per square foot.

-- 4. Top departments by total profit
-- Identifies which departments generate the highest estimated profit
-- and compares total profit against sales volume and profit margin.

SELECT
    dept,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(cogs), 2) AS total_cogs,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record
FROM public.walmart_sales
GROUP BY dept
ORDER BY total_profit DESC
LIMIT 10;

-- Result Summary:
-- Department 92 had the highest estimated profit at $136,788,038.75.
-- Department 38 had the second-highest estimated profit at $97,695,049.79.
-- Department 95 had the third-highest estimated profit at $94,766,628.71.
-- Department 92 combined high sales volume with a strong 28.27% profit margin.
-- Department 91 had the highest profit margin among the top-profit departments at 30.80%.
-- Department 72 generated high sales but had a lower profit margin at 17.48%.
-- Department profitability should be evaluated using both total profit and margin.

-- 5. Bottom departments by total profit
-- Identifies departments with the lowest estimated profit, while filtering
-- for departments with at least 100 records to reduce noise from extremely rare departments.

SELECT
    dept,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(cogs), 2) AS total_cogs,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record
FROM public.walmart_sales
GROUP BY dept
HAVING COUNT(*) >= 100
ORDER BY total_profit ASC
LIMIT 10;

-- Result Summary:
-- Department 78 had the lowest estimated profit at $488.99 across 235 records.
-- Department 77 generated $2,549.11 in estimated profit across 150 records.
-- Many bottom-profit departments were very low-volume departments rather than major underperformers.
-- Department 47 showed unusual results, with negative total sales but positive estimated profit.
-- Department 47 should be treated as a data quality or special-case issue.
-- Low total department profit should be evaluated alongside sales volume, margin, and data quality checks.

-- 6. Highest-margin departments
-- Identifies departments with the strongest overall profit margins,
-- while filtering for meaningful sales volume and record count.

SELECT
    dept,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record
FROM public.walmart_sales
GROUP BY dept
HAVING COUNT(*) >= 1000
   AND SUM(weekly_sales) > 0
ORDER BY overall_profit_margin_pct DESC
LIMIT 10;

-- Result Summary:
-- Department 91 had the highest overall profit margin at 30.80%.
-- Department 13 had the second-highest margin at 28.76%.
-- Department 92 had the third-highest margin at 28.27%.
-- Department 92 is especially strong because it ranked first in total profit and third in profit margin.
-- Department 91 is strategically valuable because it has the strongest margin among meaningful-volume departments.

-- 7. Store profit efficiency categories
-- Classifies stores into High, Average, and Low Profit Efficiency groups
-- using profit per square foot compared to the overall average and standard deviation.

WITH store_profitability AS (
    SELECT
        store,
        type,
        size,
        ROUND(SUM(weekly_sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
        ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
        ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft
    FROM public.walmart_sales
    GROUP BY store, type, size
),

profit_thresholds AS (
    SELECT
        AVG(profit_per_sqft) AS avg_profit_per_sqft,
        STDDEV(profit_per_sqft) AS stddev_profit_per_sqft
    FROM store_profitability
)

SELECT
    s.store,
    s.type,
    s.size,
    s.total_sales,
    s.total_profit,
    s.overall_profit_margin_pct,
    s.profit_per_sqft,
    s.sales_per_sqft,
    CASE
        WHEN s.profit_per_sqft >= t.avg_profit_per_sqft + t.stddev_profit_per_sqft THEN 'High Profit Efficiency'
        WHEN s.profit_per_sqft <= t.avg_profit_per_sqft - t.stddev_profit_per_sqft THEN 'Low Profit Efficiency'
        ELSE 'Average Profit Efficiency'
    END AS profit_efficiency_category
FROM store_profitability s
CROSS JOIN profit_thresholds t
ORDER BY s.profit_per_sqft DESC;

-- Result Summary:
-- High Profit Efficiency stores included Stores 43, 42, 37, 10, and 23.
-- Low Profit Efficiency stores included Stores 29, 25, 21, 15, and 9.
-- Store 43 had the highest profit per square foot at $554.27.
-- Store 9 had the lowest profit per square foot at $133.83.
-- Store 10 continued to stand out as a strong performer across total sales, sales efficiency, and profit efficiency.
-- Profit efficiency appears tied more closely to space productivity than margin alone.

-- 8. Store profit efficiency category summary
-- Summarizes store count and average profit per square foot by profit efficiency category.

WITH store_profitability AS (
    SELECT
        store,
        type,
        size,
        ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft
    FROM public.walmart_sales
    GROUP BY store, type, size
),

profit_thresholds AS (
    SELECT
        AVG(profit_per_sqft) AS avg_profit_per_sqft,
        STDDEV(profit_per_sqft) AS stddev_profit_per_sqft
    FROM store_profitability
),

categorized AS (
    SELECT
        s.store,
        s.type,
        s.size,
        s.profit_per_sqft,
        CASE
            WHEN s.profit_per_sqft >= t.avg_profit_per_sqft + t.stddev_profit_per_sqft THEN 'High Profit Efficiency'
            WHEN s.profit_per_sqft <= t.avg_profit_per_sqft - t.stddev_profit_per_sqft THEN 'Low Profit Efficiency'
            ELSE 'Average Profit Efficiency'
        END AS profit_efficiency_category
    FROM store_profitability s
    CROSS JOIN profit_thresholds t
)

SELECT
    profit_efficiency_category,
    COUNT(*) AS store_count,
    ROUND(AVG(profit_per_sqft), 2) AS avg_profit_per_sqft
FROM categorized
GROUP BY profit_efficiency_category
ORDER BY
    CASE profit_efficiency_category
        WHEN 'High Profit Efficiency' THEN 1
        WHEN 'Average Profit Efficiency' THEN 2
        ELSE 3
    END;

-- Result Summary:
-- High Profit Efficiency: 5 stores, averaging $472.99 profit per square foot.
-- Average Profit Efficiency: 35 stores, averaging $260.67 profit per square foot.
-- Low Profit Efficiency: 5 stores, averaging $155.77 profit per square foot.
-- High profit-efficiency stores generated roughly 3.04x more profit per square foot than low profit-efficiency stores.