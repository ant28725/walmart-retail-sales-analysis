-- =========================================================
-- Section 6: Tableau Dashboard Views
-- Project: Walmart Retail Sales Performance Analysis
-- Purpose:
-- Create cleaned, analysis-ready SQL views for Tableau dashboards.
-- These views include calculated fields for sales performance,
-- store efficiency, profitability, markdown activity, and holiday impact.
-- =========================================================

CREATE OR REPLACE VIEW public.walmart_dashboard_view AS
WITH store_metrics AS (
    SELECT
        store,
        MAX(type) AS store_type,
        MAX(size) AS store_size,
        SUM(weekly_sales) AS store_total_sales,
        SUM(profit) AS store_total_profit,
        SUM(weekly_sales) / NULLIF(MAX(size), 0) AS sales_per_sqft,
        SUM(profit) / NULLIF(MAX(size), 0) AS profit_per_sqft
    FROM public.walmart_sales
    GROUP BY store
),

efficiency_thresholds AS (
    SELECT
        AVG(sales_per_sqft) AS avg_sales_per_sqft,
        STDDEV(sales_per_sqft) AS stddev_sales_per_sqft,
        AVG(profit_per_sqft) AS avg_profit_per_sqft,
        STDDEV(profit_per_sqft) AS stddev_profit_per_sqft
    FROM store_metrics
),

store_categories AS (
    SELECT
        s.store,
        s.store_type,
        s.store_size,
        s.store_total_sales,
        s.store_total_profit,
        s.sales_per_sqft,
        s.profit_per_sqft,
        CASE
            WHEN s.sales_per_sqft >= e.avg_sales_per_sqft + e.stddev_sales_per_sqft THEN 'High Efficiency'
            WHEN s.sales_per_sqft <= e.avg_sales_per_sqft - e.stddev_sales_per_sqft THEN 'Low Efficiency'
            ELSE 'Average Efficiency'
        END AS efficiency_category,
        CASE
            WHEN s.profit_per_sqft >= e.avg_profit_per_sqft + e.stddev_profit_per_sqft THEN 'High Profit Efficiency'
            WHEN s.profit_per_sqft <= e.avg_profit_per_sqft - e.stddev_profit_per_sqft THEN 'Low Profit Efficiency'
            ELSE 'Average Profit Efficiency'
        END AS profit_efficiency_category
    FROM store_metrics s
    CROSS JOIN efficiency_thresholds e
)

SELECT
    w.store,
    w.dept,
    w.type,
    w.size,
    w.sale_date,
    w.year,
    w.month,
    w.week,
    w.dayofyear,
    w.isholiday,
    w.weekly_sales,
    w.temperature,
    w.fuel_price,
    w.markdown1,
    w.markdown2,
    w.markdown3,
    w.markdown4,
    w.markdown5,
    w.cpi,
    w.unemployment,
    w.total_markdown,
    w.dept_margin_base,
    w.type_adj,
    w.markdown_ratio,
    w.assumed_gross_margin_pct,
    w.profit,
    w.cogs,
    w.profit_margin_pct,

    sc.store_total_sales,
    sc.store_total_profit,
    ROUND(sc.sales_per_sqft::numeric, 2) AS sales_per_sqft,
    ROUND(sc.profit_per_sqft::numeric, 2) AS profit_per_sqft,
    sc.efficiency_category,
    sc.profit_efficiency_category,

    CASE
        WHEN w.isholiday = 1 THEN 'Holiday Week'
        ELSE 'Non-Holiday Week'
    END AS holiday_status,

    CASE
        WHEN w.total_markdown = 0 THEN 'No Markdown'
        WHEN w.total_markdown > 0 AND w.total_markdown < 5000 THEN 'Low Markdown'
        WHEN w.total_markdown >= 5000 AND w.total_markdown < 20000 THEN 'Medium Markdown'
        ELSE 'High Markdown'
    END AS markdown_bucket,

    CASE
        WHEN w.size < 75000 THEN 'Small Store'
        WHEN w.size >= 75000 AND w.size < 150000 THEN 'Medium Store'
        ELSE 'Large Store'
    END AS store_size_category,

    CASE
        WHEN w.profit_margin_pct < 0.15 THEN 'Low Margin'
        WHEN w.profit_margin_pct >= 0.15 AND w.profit_margin_pct < 0.25 THEN 'Medium Margin'
        ELSE 'High Margin'
    END AS profit_margin_category,

    CASE
        WHEN w.weekly_sales < 0 THEN 'Negative Sales'
        WHEN w.weekly_sales = 0 THEN 'Zero Sales'
        ELSE 'Positive Sales'
    END AS sales_record_status

FROM public.walmart_sales w
LEFT JOIN store_categories sc
    ON w.store = sc.store;

    -- View check:
-- SELECT COUNT(*) AS total_rows
-- FROM public.walmart_dashboard_view;
--
-- Expected result:
-- 421,570 rows