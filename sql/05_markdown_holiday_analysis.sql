-- =========================================================
-- Section 4: Markdown and Holiday Impact
-- Project: Walmart Retail Sales Performance Analysis
-- Purpose:
-- Analyze how holidays and markdown activity relate to sales,
-- profit, profit margin, and promotional effectiveness.
-- =========================================================

-- 1. Holiday vs non-holiday performance
-- Compares sales, profit, margin, and markdown activity between holiday and non-holiday weeks.

SELECT
    isholiday,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(total_markdown), 2) AS total_markdown,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(total_markdown), 2) AS avg_markdown_per_record
FROM public.walmart_sales
GROUP BY isholiday
ORDER BY isholiday;

-- Result Summary:
-- Non-holiday weeks generated $6,231,919,435.55 in total sales and $1,386,756,674.55 in estimated profit.
-- Holiday weeks generated $505,299,551.56 in total sales and $100,363,930.40 in estimated profit.
-- Average weekly sales per record were higher during holiday weeks: $17,035.82 vs $15,901.45.
-- Holiday weeks had much higher average markdown activity: $15,729.58 vs $5,999.44 per record.
-- Overall profit margin was lower during holiday weeks: 19.86% vs 22.25%.
-- Holiday weeks increased sales intensity, but heavier markdown activity may have reduced margin performance.

-- 2. Markdown level analysis
-- Groups records by markdown activity to compare sales, profit, and margin outcomes.

WITH markdown_groups AS (
    SELECT
        CASE
            WHEN total_markdown = 0 THEN 'No Markdown'
            WHEN total_markdown > 0 AND total_markdown < 5000 THEN 'Low Markdown'
            WHEN total_markdown >= 5000 AND total_markdown < 20000 THEN 'Medium Markdown'
            ELSE 'High Markdown'
        END AS markdown_bucket,
        weekly_sales,
        profit,
        total_markdown
    FROM public.walmart_sales
)

SELECT
    markdown_bucket,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(total_markdown), 2) AS total_markdown,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(total_markdown), 2) AS avg_markdown_per_record
FROM markdown_groups
GROUP BY markdown_bucket
ORDER BY
    CASE markdown_bucket
        WHEN 'No Markdown' THEN 1
        WHEN 'Low Markdown' THEN 2
        WHEN 'Medium Markdown' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- No-markdown records had an average weekly sales value of $15,871.52 and a 27.82% profit margin.
-- High-markdown records had the highest average weekly sales value at $19,971.10.
-- However, high-markdown records had the lowest profit margin at 7.55%.
-- Average profit per record declined from $4,415.91 for no-markdown records to $1,507.01 for high-markdown records.
-- Markdown activity appears to increase sales intensity but substantially reduce profitability.

-- 3. Markdown impact by holiday status
-- Combines holiday status and markdown activity to evaluate how promotions
-- perform during holiday and non-holiday weeks.

WITH markdown_groups AS (
    SELECT
        isholiday,
        CASE
            WHEN total_markdown = 0 THEN 'No Markdown'
            WHEN total_markdown > 0 AND total_markdown < 5000 THEN 'Low Markdown'
            WHEN total_markdown >= 5000 AND total_markdown < 20000 THEN 'Medium Markdown'
            ELSE 'High Markdown'
        END AS markdown_bucket,
        weekly_sales,
        profit,
        total_markdown
    FROM public.walmart_sales
)

SELECT
    isholiday,
    markdown_bucket,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(total_markdown), 2) AS avg_markdown_per_record
FROM markdown_groups
GROUP BY isholiday, markdown_bucket
ORDER BY
    isholiday,
    CASE markdown_bucket
        WHEN 'No Markdown' THEN 1
        WHEN 'Low Markdown' THEN 2
        WHEN 'Medium Markdown' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- High-markdown records had the highest average weekly sales in both holiday and non-holiday weeks.
-- Non-holiday high-markdown records averaged $19,949.34 in weekly sales.
-- Holiday high-markdown records averaged $20,068.15 in weekly sales.
-- Non-holiday high-markdown records had a 7.79% profit margin.
-- Holiday high-markdown records had a 6.45% profit margin.
-- No-markdown records had much stronger margins: 27.80% for non-holiday weeks and 28.11% for holiday weeks.
-- Markdown-heavy holiday promotions increased sales intensity but substantially reduced profitability.

-- 4. Markdown impact by store type
-- Evaluates whether markdown activity affects sales and profitability differently
-- across Store Types A, B, and C.

WITH markdown_groups AS (
    SELECT
        type,
        CASE
            WHEN total_markdown = 0 THEN 'No Markdown'
            WHEN total_markdown > 0 AND total_markdown < 5000 THEN 'Low Markdown'
            WHEN total_markdown >= 5000 AND total_markdown < 20000 THEN 'Medium Markdown'
            ELSE 'High Markdown'
        END AS markdown_bucket,
        weekly_sales,
        profit,
        total_markdown
    FROM public.walmart_sales
)

SELECT
    type,
    markdown_bucket,
    COUNT(*) AS total_records,
    ROUND(SUM(weekly_sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales_per_record,
    ROUND(AVG(profit), 2) AS avg_profit_per_record,
    ROUND(100.0 * SUM(profit) / NULLIF(SUM(weekly_sales), 0), 2) AS overall_profit_margin_pct,
    ROUND(AVG(total_markdown), 2) AS avg_markdown_per_record
FROM markdown_groups
GROUP BY type, markdown_bucket
ORDER BY
    type,
    CASE markdown_bucket
        WHEN 'No Markdown' THEN 1
        WHEN 'Low Markdown' THEN 2
        WHEN 'Medium Markdown' THEN 3
        ELSE 4
    END;

-- Result Summary:
-- Type A high-markdown records had the highest average weekly sales at $22,599.99 but a much lower 7.98% profit margin.
-- Type A no-markdown records had a 28.21% profit margin.
-- Type B high-markdown records averaged $14,816.46 in weekly sales but had only a 6.24% profit margin.
-- Type B no-markdown records had a 27.25% profit margin.
-- Type C did not appear in the high-markdown group, but margin still declined from 26.56% with no markdowns to 15.61% with medium markdowns.
-- Markdown-heavy periods increased sales intensity but consistently reduced profitability across store types.

-- 5. Markdown correlation summary
-- Calculates correlations between markdown activity and sales, profit, and profit margin.

SELECT
    ROUND(CORR(total_markdown, weekly_sales)::numeric, 4) AS markdown_sales_corr,
    ROUND(CORR(total_markdown, profit)::numeric, 4) AS markdown_profit_corr,
    ROUND(CORR(total_markdown, profit_margin_pct)::numeric, 4) AS markdown_margin_corr
FROM public.walmart_sales
WHERE total_markdown IS NOT NULL;

-- Result Summary:
-- Correlation between total markdown and weekly sales: 0.0652.
-- Correlation between total markdown and profit: -0.1442.
-- Correlation between total markdown and profit margin: -0.5750.
-- Markdown activity had only a weak positive relationship with sales but a much stronger negative relationship with margin.
-- Markdown strategy should be evaluated by profit and margin impact, not sales lift alone.