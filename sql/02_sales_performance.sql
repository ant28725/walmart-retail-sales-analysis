-- =========================================================
-- Section 1: Sales Performance Overview
-- Project: Walmart Retail Sales Performance Analysis
-- Purpose:
-- Analyze total sales, profit, order volume, store count,
-- department count, time range, and high-level retail trends.
-- =========================================================

-- 1. Overall retail sales summary
-- Establishes the size, scope, revenue, and estimated profitability of the dataset.

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT store) AS total_stores,
    COUNT(DISTINCT dept) AS total_departments,
    MIN(sale_date) AS start_date,
    MAX(sale_date) AS end_date,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales;

-- Result Summary:
-- Total records: 421,570
-- Total stores: 45
-- Total departments: 81
-- Date range: 2010-02-05 to 2012-10-26
-- Total sales: $6,737,218,987.11
-- Estimated profit: $1,487,120,604.95
-- Average weekly sales per record: $15,981.26
-- Average profit margin: 20.77%

-- 2. Sales performance by year
-- Compares annual sales, estimated profit, average weekly sales, and profit margin.

SELECT
    year,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY year
ORDER BY year;

-- Result Summary:
-- 2010 total sales: $2,288,886,120.41 with 28.18% average profit margin.
-- 2011 total sales: $2,448,200,007.35 with 24.95% average profit margin.
-- 2012 total sales: $2,000,132,859.35 with 7.56% average profit margin.
-- 2012 is a partial year because the dataset ends on 2012-10-26.
-- Estimated profit margin declined sharply by 2012, which should be investigated in the profitability section.

-- 3. Sales performance by month
-- Compares monthly sales, estimated profit, average weekly sales, and profit margin.

SELECT
    month,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY month
ORDER BY month;

-- Result Summary:
-- July had the highest total sales at $650,000,977.25.
-- April had the second-highest total sales at $646,859,784.97.
-- January had the lowest total sales at $332,598,438.49.
-- December had the highest average weekly sales per record at $19,355.70.
-- November had the second-highest average weekly sales per record at $17,491.03.
-- Holiday-season months showed stronger average sales intensity, while total sales were also influenced by record count.

-- 4. Sales performance by store type
-- Compares store count, total sales, estimated profit, average weekly sales,
-- average store size, and profit margin by store type.

SELECT
    type,
    COUNT(DISTINCT store) AS total_stores,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(size), 2) AS avg_store_size,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY type
ORDER BY total_sales DESC;

-- Result Summary:
-- Type A stores generated the highest total sales at $4,331,014,722.75.
-- Type B stores generated $2,000,700,736.82 in total sales.
-- Type C stores generated $405,503,527.54 in total sales.
-- Type A stores had the highest average weekly sales per record at $20,099.57.
-- Type A stores were also the largest on average, with an average size of 182,231 sq ft.
-- Profit margins were similar for Type A and Type C stores, while Type B was slightly lower.
-- Type A stores drive sales primarily through higher volume and larger store size.

-- 5. Top stores by total sales
-- Identifies the highest-sales stores and compares total sales, profit,
-- average weekly sales, sales per square foot, and profit margin.

SELECT
    store,
    type,
    size,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY store, type, size
ORDER BY total_sales DESC
LIMIT 10;

-- Result Summary:
-- Store 20 had the highest total sales at $301,397,792.46.
-- Store 4 had the second-highest total sales at $299,543,953.38.
-- Most top-sales stores were Type A stores.
-- Store 10 stood out as a Type B store with $271,617,713.89 in total sales.
-- Store 10 also had the highest sales per square foot among the top-sales stores at $2,146.97.
-- This suggests that Store 10 may be a highly efficient performer despite being smaller than many Type A stores.

-- 6. Bottom stores by total sales
-- Identifies the lowest-sales stores and compares total sales against sales efficiency.

SELECT
    store,
    type,
    size,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY store, type, size
ORDER BY total_sales ASC
LIMIT 10;

-- Result Summary:
-- Store 33 had the lowest total sales at $37,160,221.96.
-- Store 44 had the second-lowest total sales at $43,293,087.84.
-- Many bottom-sales stores were smaller-format stores, so low total sales should not automatically be treated as underperformance.
-- Store 37 appeared in the bottom 10 by total sales but had strong sales efficiency at $1,859.25 sales per square foot.
-- Store 29 stood out as a potential underperformer because it was larger than many bottom-sales stores but had only $823.83 sales per square foot.
-- Store performance should be evaluated with both total sales and efficiency metrics.