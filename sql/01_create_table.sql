-- =========================================================
-- Section 1: Database Setup
-- Project: Walmart Retail Sales Performance Analysis
-- Purpose:
-- Create and load the Walmart retail sales dataset into PostgreSQL.
-- =========================================================

DROP TABLE IF EXISTS public.walmart_sales;

CREATE TABLE public.walmart_sales (
    store INT,
    dept INT,
    type TEXT,
    size INT,
    sale_date DATE,
    year INT,
    month INT,
    week INT,
    dayofyear INT,
    isholiday INT,
    weekly_sales NUMERIC,
    temperature NUMERIC,
    fuel_price NUMERIC,
    markdown1 NUMERIC,
    markdown2 NUMERIC,
    markdown3 NUMERIC,
    markdown4 NUMERIC,
    markdown5 NUMERIC,
    cpi NUMERIC,
    unemployment NUMERIC,
    total_markdown NUMERIC,
    dept_margin_base NUMERIC,
    type_adj NUMERIC,
    markdown_ratio NUMERIC,
    assumed_gross_margin_pct NUMERIC,
    profit NUMERIC,
    cogs NUMERIC,
    profit_margin_pct NUMERIC
);

-- Import command used in psql:
-- \copy public.walmart_sales FROM '/Users/antonjackson/Desktop/Walmart_Retail_Sales_Analysis/data/walmart_sales.csv' WITH (FORMAT csv, HEADER true);

-- Validation checks:
-- SELECT COUNT(*) AS total_rows FROM public.walmart_sales;
-- SELECT * FROM public.walmart_sales LIMIT 5;