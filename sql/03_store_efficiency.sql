-- =========================================================
-- Section 2: Store Efficiency
-- Project: Walmart Retail Sales Performance Analysis
-- Purpose:
-- Analyze store performance relative to store size using
-- sales per square foot, profit per square foot, and efficiency rankings.
-- =========================================================

-- 1. Store efficiency overview
-- Establishes average, minimum, and maximum store efficiency using
-- sales per square foot and profit per square foot.

WITH store_efficiency AS (
    SELECT
        store,
        type,
        size,
        ROUND(SUM(weekly_sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft,
        ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
        ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
        ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
    FROM public.walmart_sales
    GROUP BY store, type, size
)

SELECT
    COUNT(*) AS total_stores,
    ROUND(AVG(sales_per_sqft), 2) AS avg_sales_per_sqft,
    ROUND(MIN(sales_per_sqft), 2) AS min_sales_per_sqft,
    ROUND(MAX(sales_per_sqft), 2) AS max_sales_per_sqft,
    ROUND(AVG(profit_per_sqft), 2) AS avg_profit_per_sqft,
    ROUND(MIN(profit_per_sqft), 2) AS min_profit_per_sqft,
    ROUND(MAX(profit_per_sqft), 2) AS max_profit_per_sqft
FROM store_efficiency;

-- Result Summary:
-- Total stores: 45
-- Average sales per square foot: $1,214.19
-- Minimum sales per square foot: $618.19
-- Maximum sales per square foot: $2,205.58
-- Average profit per square foot: $272.61
-- Minimum profit per square foot: $133.83
-- Maximum profit per square foot: $554.27
-- The highest-efficiency store generated roughly 3.57x more sales per square foot than the lowest-efficiency store.

-- 2. Top stores by sales efficiency
-- Identifies the stores generating the most sales and profit relative to store size.

SELECT
    store,
    type,
    size,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft,
    ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY store, type, size
ORDER BY sales_per_sqft DESC
LIMIT 10;

-- Result Summary:
-- Store 43 had the highest sales efficiency at $2,205.58 sales per square foot.
-- Store 43 also had the highest profit efficiency at $554.27 profit per square foot.
-- Store 10 ranked second with $2,146.97 sales per square foot.
-- Several Type C stores appeared among the top efficiency performers despite lower total sales.
-- Type A stores dominate total sales, but Type B and Type C stores can outperform on sales efficiency.

-- 3. Bottom stores by sales efficiency
-- Identifies stores with the lowest sales and profit relative to store size.

SELECT
    store,
    type,
    size,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft,
    ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
    ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
FROM public.walmart_sales
GROUP BY store, type, size
ORDER BY sales_per_sqft ASC
LIMIT 10;

-- Result Summary:
-- Store 9 had the lowest sales efficiency at $618.19 sales per square foot.
-- Store 15 had the second-lowest sales efficiency at $720.35 sales per square foot.
-- Store 21 had the third-lowest sales efficiency at $771.35 sales per square foot.
-- Several low-efficiency stores had large footprints, including Store 32 with 203,007 sq ft and Store 28 with 206,302 sq ft.
-- Low efficiency among larger stores may indicate underperformance relative to operating footprint.

-- 4. Store efficiency categories
-- Classifies stores into High, Average, and Low Efficiency groups
-- using sales per square foot compared to the overall average and standard deviation.

WITH store_efficiency AS (
    SELECT
        store,
        type,
        size,
        ROUND(SUM(weekly_sales), 2) AS total_sales,
        ROUND(SUM(profit), 2) AS total_profit,
        ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft,
        ROUND(SUM(profit) / MAX(size), 2) AS profit_per_sqft,
        ROUND(AVG(profit_margin_pct) * 100, 2) AS avg_profit_margin_pct
    FROM public.walmart_sales
    GROUP BY store, type, size
),

efficiency_thresholds AS (
    SELECT
        AVG(sales_per_sqft) AS avg_sales_per_sqft,
        STDDEV(sales_per_sqft) AS stddev_sales_per_sqft
    FROM store_efficiency
)

SELECT
    s.store,
    s.type,
    s.size,
    s.total_sales,
    s.total_profit,
    s.sales_per_sqft,
    s.profit_per_sqft,
    s.avg_profit_margin_pct,
    CASE
        WHEN s.sales_per_sqft >= t.avg_sales_per_sqft + t.stddev_sales_per_sqft THEN 'High Efficiency'
        WHEN s.sales_per_sqft <= t.avg_sales_per_sqft - t.stddev_sales_per_sqft THEN 'Low Efficiency'
        ELSE 'Average Efficiency'
    END AS efficiency_category
FROM store_efficiency s
CROSS JOIN efficiency_thresholds t
ORDER BY s.sales_per_sqft DESC;

-- Result Summary:
-- High Efficiency stores: 5
-- Average Efficiency stores: 33
-- Low Efficiency stores: 7
-- High Efficiency stores included Stores 43, 10, 42, 37, and 23.
-- Low Efficiency stores included Stores 8, 29, 32, 25, 21, 15, and 9.
-- Store 9 had the lowest sales efficiency at $618.19 sales per square foot.
-- Store 32 stood out as a large Type A store with low sales efficiency at $821.74 sales per square foot.

-- 5. Store efficiency category summary
-- Summarizes store count and average sales per square foot by efficiency category.

WITH store_efficiency AS (
    SELECT
        store,
        type,
        size,
        ROUND(SUM(weekly_sales) / MAX(size), 2) AS sales_per_sqft
    FROM public.walmart_sales
    GROUP BY store, type, size
),

efficiency_thresholds AS (
    SELECT
        AVG(sales_per_sqft) AS avg_sales_per_sqft,
        STDDEV(sales_per_sqft) AS stddev_sales_per_sqft
    FROM store_efficiency
),

categorized AS (
    SELECT
        s.store,
        s.type,
        s.size,
        s.sales_per_sqft,
        CASE
            WHEN s.sales_per_sqft >= t.avg_sales_per_sqft + t.stddev_sales_per_sqft THEN 'High Efficiency'
            WHEN s.sales_per_sqft <= t.avg_sales_per_sqft - t.stddev_sales_per_sqft THEN 'Low Efficiency'
            ELSE 'Average Efficiency'
        END AS efficiency_category
    FROM store_efficiency s
    CROSS JOIN efficiency_thresholds t
)

SELECT
    efficiency_category,
    COUNT(*) AS store_count,
    ROUND(AVG(sales_per_sqft), 2) AS avg_sales_per_sqft
FROM categorized
GROUP BY efficiency_category
ORDER BY
    CASE efficiency_category
        WHEN 'High Efficiency' THEN 1
        WHEN 'Average Efficiency' THEN 2
        ELSE 3
    END;

-- Result Summary:
-- High Efficiency: 5 stores, averaging $1,990.36 sales per square foot.
-- Average Efficiency: 33 stores, averaging $1,191.05 sales per square foot.
-- Low Efficiency: 7 stores, averaging $768.90 sales per square foot.
-- High-efficiency stores generated roughly 2.59x more sales per square foot than low-efficiency stores.