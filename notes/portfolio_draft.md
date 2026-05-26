# Walmart Retail Sales Performance Analysis - Portfolio Draft

## Project Overview

This project analyzes Walmart retail sales data to identify store performance patterns, department-level trends, sales efficiency, profitability, markdown impact, and holiday demand behavior.

The main business question is:

**Which stores, departments, and time periods drive the strongest sales and profitability, and where are there signs of underperformance?**

## Business Problem

Retail businesses need to understand which stores and departments generate the most value, how sales vary across time periods, how holidays affect demand, and whether markdowns improve performance. This analysis uses SQL and Tableau to evaluate sales performance, store efficiency, profitability, and promotional/holiday trends.

## Section 1: Sales Performance Overview

I began the analysis by establishing the overall scope of the dataset, including the number of records, stores, departments, date range, total sales, estimated profit, and average profit margin.

### 1.1 Overall Sales Summary

The dataset contains 421,570 weekly sales records across 45 stores and 81 departments, covering the period from February 5, 2010 through October 26, 2012.

Across the full dataset, total sales were $6.74 billion, with estimated profit of $1.49 billion. The average weekly sales value per store-department record was $15,981.26, and the average estimated profit margin was 20.77%.

This initial summary establishes the scale of the dataset and provides a baseline for deeper analysis into store performance, sales efficiency, profitability, holiday demand, and markdown effectiveness.

### 1.2 Sales Performance by Year

Annual sales were highest in 2011 at $2.45 billion, compared to $2.29 billion in 2010 and $2.00 billion in 2012. However, the dataset ends on October 26, 2012, so 2012 should be interpreted as a partial year rather than a full-year sales decline.

Average weekly sales per record decreased slightly each year, from $16,270.28 in 2010 to $15,954.07 in 2011 and $15,694.95 in 2012. The more notable trend was the sharp decline in estimated profit margin, which dropped from 28.18% in 2010 to 24.95% in 2011 and 7.56% in 2012.

This suggests that profitability should be analyzed more closely in later sections, especially to determine whether margin changes are related to markdown activity, department mix, assumptions in the estimated profit fields, or partial-year data effects.

### 1.3 Sales Performance by Month

Monthly sales showed clear seasonal variation. July generated the highest total sales at $650.00 million, followed closely by April at $646.86 million, June at $622.63 million, and August at $613.09 million. January had the lowest total sales at $332.60 million.

Average weekly sales per record showed a different pattern. December had the highest average weekly sales per record at $19,355.70, followed by November at $17,491.03. This suggests that holiday-season periods may generate stronger sales intensity per store-department record, even when total monthly record counts are lower.

This distinction is important because total sales are influenced by the number of records available for each month, while average weekly sales per record gives a better sense of sales intensity.

### 1.4 Sales Performance by Store Type

Store Type A generated the largest share of sales, with $4.33 billion in total sales across 22 stores. Type B stores generated $2.00 billion across 17 stores, while Type C stores generated $405.50 million across 6 stores.

Type A stores also had the highest average weekly sales per record at $20,099.57, compared to $12,237.08 for Type B and $9,519.53 for Type C. This aligns with store size differences, as Type A stores had an average size of 182,231 square feet compared to 101,819 for Type B and 40,536 for Type C.

Profit margins were relatively similar between Type A and Type C stores, with Type A averaging 21.15% and Type C averaging 21.13%. Type B had a slightly lower average profit margin at 20.18%. This suggests that Type A stores drive total sales primarily through larger store size and higher volume rather than dramatically higher margin performance.

### 1.5 Top Stores by Total Sales

Store-level analysis showed that the highest-sales stores were primarily Type A stores, which aligns with their larger store sizes and higher average sales volume. Store 20 generated the highest total sales at $301.40 million, followed by Store 4 at $299.54 million and Store 14 at $289.00 million.

However, Store 10 stood out as an important exception. Although Store 10 is a Type B store, it generated $271.62 million in total sales and had sales per square foot of $2,146.97. This was higher than the larger Type A stores at the top of the sales ranking.

This suggests that Store 10 may be one of the most efficient high-performing stores in the dataset. While Type A stores dominate total sales, sales per square foot provides a more nuanced view of store performance by accounting for store size.

### 1.6 Bottom Stores by Total Sales

The lowest total-sales stores were generally smaller-format stores. Store 33 had the lowest total sales at $37.16 million, followed by Store 44 at $43.29 million and Store 5 at $45.48 million.

However, low total sales did not always mean poor efficiency. Several smaller stores had reasonable sales per square foot despite lower total sales. For example, Store 37 generated $1,859.25 in sales per square foot, despite appearing in the bottom 10 by total sales.

Store 29 stood out as a more concerning potential underperformer. It generated $77.14 million in total sales, but its store size was 93,638 square feet and its sales per square foot were only $823.83. This suggests that store performance should be evaluated using efficiency metrics such as sales per square foot, not total sales alone.

### Section 1 Summary: Sales Performance Overview

The Walmart dataset contains 421,570 weekly sales records across 45 stores and 81 departments from February 2010 through October 2012. Total sales were $6.74 billion, with estimated profit of $1.49 billion and an average estimated profit margin of 20.77%.

Sales were highest in 2011, but 2012 should be interpreted carefully because the dataset ends in October 2012. Monthly sales showed seasonal variation, with July generating the highest total sales and December showing the highest average weekly sales per record.

Store Type A dominated total sales and average weekly sales, largely because Type A stores were much larger on average. However, store-level analysis showed that total sales alone can be misleading. Store 10, a Type B store, ranked among the highest-sales stores and had especially strong sales per square foot. On the other hand, some low-sales stores were simply smaller stores, while Store 29 stood out as a potential underperformer due to low sales per square foot relative to its size.

Overall, the sales performance overview showed that store performance should be evaluated using both total sales and efficiency metrics rather than revenue alone.

## Section 2: Store Efficiency

After reviewing total sales performance, I analyzed store efficiency to understand how well each store performed relative to its physical size. Total sales can be misleading because larger stores naturally generate more revenue. To account for this, I used sales per square foot and profit per square foot as efficiency metrics.

### 2.1 Store Efficiency Overview

Across the 45 stores in the dataset, average sales per square foot were $1,214.19, while average profit per square foot was $272.61.

There was a wide range in store efficiency. The lowest-performing store generated $618.19 in sales per square foot, while the highest-performing store generated $2,205.58 in sales per square foot. This means the most efficient store generated roughly 3.57 times more sales per square foot than the least efficient store.

Profit per square foot showed a similar spread, ranging from $133.83 to $554.27. This suggests that store performance varies significantly when adjusted for physical footprint, making efficiency metrics important for evaluating store performance beyond total sales alone.

### 2.2 Top Stores by Sales Efficiency

The top stores by sales per square foot were not necessarily the largest stores. Store 43, a Type C store, had the highest sales efficiency at $2,205.58 per square foot and the highest profit per square foot at $554.27. This suggests that smaller-format stores can outperform larger stores when performance is adjusted for store size.

Store 10, a Type B store, also stood out with $2,146.97 in sales per square foot and $460.32 in profit per square foot. Unlike many smaller efficient stores, Store 10 also ranked among the highest stores by total sales, making it a strong performer from both a revenue and efficiency perspective.

Overall, this analysis shows that Type A stores dominate total sales, but Type B and Type C stores can outperform on efficiency metrics.

### 2.3 Bottom Stores by Sales Efficiency

The lowest-efficiency stores by sales per square foot were primarily Type B and Type A stores with larger physical footprints. Store 9 had the lowest sales efficiency at $618.19 per square foot, followed by Store 15 at $720.35 and Store 21 at $771.35.

This analysis revealed that underperformance is not limited to small stores. Store 32, a Type A store with 203,007 square feet, generated only $821.74 in sales per square foot. Store 28, another large Type A store with 206,302 square feet, generated $917.41 in sales per square foot.

These stores may represent potential underperformance because they require large operating footprints but generate relatively low sales efficiency. This supports using sales per square foot as a stronger performance metric than total sales alone.

### 2.4 Store Efficiency Categories

To make store efficiency easier to interpret, I classified stores into high, average, and low efficiency categories using sales per square foot. Stores above one standard deviation from the average were labeled high efficiency, while stores below one standard deviation from the average were labeled low efficiency.

This classification identified 5 high-efficiency stores, 33 average-efficiency stores, and 7 low-efficiency stores. The high-efficiency group included Stores 43, 10, 42, 37, and 23. These stores generated the strongest sales relative to their physical footprint.

The low-efficiency group included Stores 8, 29, 32, 25, 21, 15, and 9. Store 9 had the lowest sales efficiency at $618.19 per square foot. Store 32 also stood out because it was a large Type A store with 203,007 square feet but only $821.74 in sales per square foot.

This classification provides a clearer way to identify stores that may deserve closer review than ranking by total sales alone.

### Section 2 Summary: Store Efficiency

Store efficiency analysis showed that total sales alone does not fully explain store performance. Across all 45 stores, average sales per square foot were $1,214.19, but performance ranged from $618.19 to $2,205.58 per square foot.

The highest-efficiency stores were not necessarily the largest stores. Store 43, a Type C store, had the highest sales efficiency at $2,205.58 per square foot and the highest profit per square foot at $554.27. Store 10, a Type B store, also stood out because it ranked near the top in both total sales and sales per square foot.

Using sales per square foot, I classified stores into high, average, and low efficiency groups. The high-efficiency group contained 5 stores and averaged $1,990.36 in sales per square foot. The low-efficiency group contained 7 stores and averaged only $768.90 in sales per square foot.

This means high-efficiency stores generated roughly 2.59 times more sales per square foot than low-efficiency stores. Several low-efficiency stores had large physical footprints, including Store 32 and Store 28, suggesting that some larger stores may require closer review for underperformance relative to size.

## Section 3: Profitability Analysis

After analyzing sales volume and store efficiency, I examined profitability to understand whether the highest-sales stores were also the strongest profit performers. This section compares stores and departments by total profit, profit margin, and profit per square foot.

### 3.1 Overall Profitability Summary

Across the full dataset, total sales were $6.74 billion and estimated profit was $1.49 billion. Total cost of goods sold was approximately $5.25 billion.

The overall profit margin, calculated as total profit divided by total sales, was 22.07%. The average record-level profit margin was 20.77%, and average estimated profit per record was $3,527.58.

This establishes the baseline profitability context before comparing stores and departments by total profit, profit margin, and profit efficiency.

### 3.2 Top Stores by Total Profit

The top stores by total profit were very similar to the top stores by total sales. Store 20 generated the highest estimated profit at $68.38 million, followed by Store 4 at $67.35 million and Store 14 at $66.37 million. These stores were all large Type A stores with high total sales volume.

Store 10 continued to stand out as an important exception. Although it is a Type B store, it generated $58.24 million in estimated profit and ranked among the top profit-generating stores. More importantly, Store 10 produced $460.32 in profit per square foot, which was higher than the larger Type A stores above it in total profit.

This suggests that while large Type A stores dominate total profit, Store 10 is a strong efficiency performer because it combines high total profit with high profit per square foot.

### 3.3 Bottom Stores by Total Profit

The bottom stores by total profit were mostly smaller stores with lower overall sales volume. Store 33 had the lowest estimated profit at $9.41 million, followed by Store 5 at $9.63 million and Store 44 at $10.66 million.

However, low total profit did not always indicate weak profitability. Several bottom-profit stores had strong overall profit margins. For example, Store 33 had a 25.34% profit margin, Store 44 had a 24.62% margin, and Store 36 had a 25.66% margin.

This suggests that some stores appear low-profit mainly because they are smaller or lower-volume locations, not because they have poor margins. Store 29 remained a more concerning underperformance candidate because it had a larger footprint, relatively low sales per square foot, and low profit per square foot.

### 3.4 Top Departments by Total Profit

Department-level profitability analysis showed that a small group of departments generated the highest estimated profit. Department 92 led the dataset with $136.79 million in estimated profit, followed by Department 38 at $97.70 million and Department 95 at $94.77 million.

Department 92 was especially strong because it combined high sales volume with a strong profit margin. It generated $483.94 million in total sales and had an overall profit margin of 28.27%.

Department 91 also stood out because it had the highest profit margin among the top-profit departments at 30.80%, despite generating less total sales than Departments 92, 38, and 95. In contrast, Department 72 generated $305.73 million in sales but had a lower profit margin of 17.48%.

This suggests that department performance should be evaluated using both total profit and margin. High sales departments often drive the most profit, but profit margin helps identify which departments are more profitable relative to sales volume.

### 3.5 Bottom Departments by Total Profit

The departments with the lowest total profit were generally very low-volume departments. Department 78 generated only $488.99 in estimated profit across 235 records, while Department 77 generated $2,549.11 across 150 records.

Because these departments had very low sales volume, they should not automatically be interpreted as major underperformers. Instead, they appear to be small departments that contribute very little to total profit.

Department 47 showed an unusual result, with negative total sales but positive estimated profit. This created a negative profit margin and should be treated as a data quality issue or special-case department rather than a standard profitability pattern.

Overall, bottom-department analysis suggests that low total profit is often driven by low sales volume, while margin and data quality checks are needed before making business decisions about department performance.

### 3.6 Highest-Margin Departments

After analyzing total department profit, I also reviewed departments by overall profit margin while filtering for meaningful sales volume. This helped identify departments that were profitable relative to sales, not just departments with the highest total sales.

Department 91 had the strongest overall profit margin at 30.80%, followed by Department 13 at 28.76% and Department 92 at 28.27%. Department 92 was especially important because it ranked first in total profit while also maintaining one of the highest profit margins.

This suggests that Department 92 is one of the strongest departments overall because it combines high sales volume, high total profit, and strong margin performance. Department 91 also appears strategically valuable because it has the highest margin among meaningful-volume departments, even though it does not generate as much total sales as Department 92.

### 3.7 Store Profit Efficiency Categories

To evaluate profitability relative to store size, I classified stores using profit per square foot. Stores above one standard deviation from the average were labeled high profit efficiency, while stores below one standard deviation were labeled low profit efficiency.

The high profit-efficiency group included Stores 43, 42, 37, 10, and 23. Store 43 had the highest profit efficiency at $554.27 per square foot, while Store 10 again stood out as a strong performer because it combined high total sales, high sales per square foot, and high profit per square foot.

The low profit-efficiency group included Stores 29, 25, 21, 15, and 9. Store 9 had the lowest profit per square foot at $133.83, while Store 29 continued to appear as a potential underperformance candidate due to its low sales and profit efficiency.

This analysis suggests that profit efficiency is driven less by margin alone and more by how effectively stores convert their physical footprint into sales and profit.

### Section 3 Summary: Profitability Analysis

The profitability analysis showed that total sales and total profit were closely related, but profit efficiency and margin analysis provided a more complete view of store and department performance.

Across the full dataset, total sales were $6.74 billion, estimated profit was $1.49 billion, and the overall profit margin was 22.07%. The top stores by total profit were mostly large Type A stores, including Store 20, Store 4, and Store 14. However, Store 10 continued to stand out as a strong performer because it combined high total profit with high profit per square foot.

Department-level analysis showed that Department 92 was the strongest overall profit driver, generating $136.79 million in estimated profit with a 28.27% profit margin. Department 91 had the highest margin among meaningful-volume departments at 30.80%, making it strategically valuable despite lower total sales than Department 92.

Profit efficiency analysis showed that high profit-efficiency stores averaged $472.99 in profit per square foot, while low profit-efficiency stores averaged only $155.77. This means high profit-efficiency stores generated roughly 3.04 times more profit per square foot than low profit-efficiency stores.

Overall, profitability should be evaluated using a combination of total profit, profit margin, and profit per square foot. Total profit identifies the largest contributors, while profit efficiency highlights which stores generate the most value relative to their physical footprint.

## Section 4: Markdown and Holiday Impact

After analyzing sales, store efficiency, and profitability, I examined whether holidays and markdowns were associated with stronger sales and profit outcomes. This section compares holiday vs non-holiday performance and evaluates whether higher markdown activity appears to improve sales or profitability.

### 4.1 Holiday vs Non-Holiday Performance

Holiday weeks showed stronger average sales but weaker margin performance. Average weekly sales per record were $17,035.82 during holiday weeks compared to $15,901.45 during non-holiday weeks, representing higher sales intensity during holiday periods.

However, holiday weeks also had much higher markdown activity. Average markdown per record was $15,729.58 during holiday weeks compared to $5,999.44 during non-holiday weeks. Despite stronger average sales, holiday weeks had a lower overall profit margin of 19.86%, compared to 22.25% for non-holiday weeks.

This suggests that holidays may increase sales volume, but heavier promotional activity can reduce margin performance. From a business perspective, holiday periods appear valuable for demand generation but should be evaluated carefully for profitability.

### 4.2 Markdown Level Analysis

Markdown activity showed a clear tradeoff between sales volume and profitability. Records with high markdown activity had the highest average weekly sales per record at $19,971.10, compared to $15,871.52 for records with no markdown activity.

However, profitability declined sharply as markdown activity increased. Records with no markdowns had an overall profit margin of 27.82%, while high-markdown records had a profit margin of only 7.55%. Average profit per record also fell from $4,415.91 for no-markdown records to $1,507.01 for high-markdown records.

This suggests that markdowns may help increase sales intensity, but they can significantly reduce margin performance. From a business perspective, markdowns should be evaluated not only by their impact on sales, but also by their effect on profit and margin.

### 4.3 Markdown Impact by Holiday Status

Combining holiday status with markdown activity showed that high markdowns were associated with the highest average weekly sales in both holiday and non-holiday weeks. Non-holiday high-markdown records averaged $19,949.34 in weekly sales, while holiday high-markdown records averaged $20,068.15.

However, high markdown activity also had the weakest margin performance. Non-holiday high-markdown records had an overall profit margin of 7.79%, while holiday high-markdown records had an even lower margin of 6.45%.

By comparison, no-markdown records had much stronger profit margins in both holiday and non-holiday periods. Non-holiday no-markdown records had a 27.80% profit margin, while holiday no-markdown records had a 28.11% margin.

This suggests that markdowns may drive stronger sales intensity, especially during holiday periods, but they substantially reduce profitability. Holiday promotions should therefore be evaluated by both sales lift and margin impact rather than sales alone.

### 4.4 Markdown Impact by Store Type

Markdown analysis by store type showed a consistent tradeoff between sales intensity and profitability. For Type A stores, high-markdown records had the highest average weekly sales at $22,599.99, compared to $19,926.00 for no-markdown records. However, profit margin dropped from 28.21% with no markdowns to 7.98% with high markdowns.

Type B stores showed a similar pattern. High-markdown records averaged $14,816.46 in weekly sales, compared to $12,164.83 for no-markdown records, but profit margin declined from 27.25% to 6.24%.

Type C stores did not appear in the high-markdown group, but still showed margin compression as markdown activity increased. Type C no-markdown records had a 26.56% profit margin, while medium-markdown records had a 15.61% margin.

This suggests that markdowns may increase sales intensity across store types, but they consistently reduce profitability. Markdown strategy should therefore be evaluated by store type, sales lift, and margin impact rather than sales growth alone.

### 4.5 Markdown Correlation Summary

To summarize the relationship between markdown activity and business outcomes, I calculated correlations between total markdown amount, weekly sales, profit, and profit margin.

Markdown activity had a weak positive correlation with weekly sales at 0.0652, suggesting that higher markdowns were only slightly associated with higher sales. Markdown activity had a negative correlation with profit at -0.1442 and a stronger negative correlation with profit margin at -0.5750.

This supports the earlier bucketed analysis: markdowns may help increase sales intensity, but they are much more clearly associated with lower margin performance. From a business perspective, markdown effectiveness should be judged by profit and margin impact, not sales lift alone.

### Section 4 Summary: Markdown and Holiday Impact

The markdown and holiday analysis showed that holidays and markdowns were associated with higher sales intensity, but weaker margin performance.

Holiday weeks had higher average weekly sales per record than non-holiday weeks, but holiday weeks also had much higher markdown activity and lower overall profit margin. Average weekly sales were $17,035.82 during holiday weeks compared to $15,901.45 during non-holiday weeks, while profit margin declined from 22.25% to 19.86%.

Markdown level analysis showed an even stronger tradeoff. High-markdown records had the highest average weekly sales at $19,971.10, but the lowest profit margin at only 7.55%. No-markdown records had a much stronger profit margin of 27.82%.

This pattern remained consistent when comparing holiday and non-holiday weeks and when breaking markdown activity down by store type. High-markdown holiday records had an especially low profit margin of 6.45%, despite having the highest average weekly sales.

The correlation summary supported the same conclusion. Markdown activity had only a weak positive correlation with weekly sales at 0.0652, but a stronger negative correlation with profit margin at -0.5750. Overall, markdowns appear to increase sales intensity, but at a substantial margin cost.

## Section 5: Recommendations

Based on the sales performance, store efficiency, profitability, and markdown analysis, I developed recommendations focused on improving store performance evaluation, protecting profitability, and making promotion strategy more margin-aware.

### Recommendation 1: Evaluate stores using both total sales and sales per square foot

Total sales alone can be misleading because larger stores naturally generate more revenue. Type A stores dominated total sales, but several Type B and Type C stores outperformed on sales per square foot.

Store 43, a Type C store, had the highest sales efficiency at $2,205.58 per square foot and the highest profit efficiency at $554.27 per square foot. Store 10, a Type B store, also stood out because it ranked highly in both total sales and sales per square foot.

The business should evaluate stores using both total revenue and efficiency metrics such as sales per square foot and profit per square foot.

### Recommendation 2: Review large low-efficiency stores for possible underperformance

Several large stores appeared in the low-efficiency group, suggesting that some stores may not be generating enough sales relative to their physical footprint.

Store 32, a Type A store with 203,007 square feet, generated only $821.74 in sales per square foot. Store 28, another large Type A store with 206,302 square feet, generated $917.41 in sales per square foot. Store 9 had the lowest sales efficiency overall at $618.19 per square foot.

These stores should not automatically be closed or downsized, but they should be reviewed for possible issues such as local market demand, department mix, inventory strategy, staffing, layout, or promotional effectiveness.

### Recommendation 3: Use high-efficiency stores as performance benchmarks

The analysis identified several stores that performed strongly relative to size. Store 43, Store 10, Store 42, Store 37, and Store 23 were classified as high-efficiency stores based on sales per square foot.

Store 10 is especially useful as a benchmark because it ranked highly in both total sales and efficiency metrics. Although it is a Type B store, it generated $271.62 million in total sales, $58.24 million in estimated profit, $2,146.97 in sales per square foot, and $460.32 in profit per square foot.

The business should study high-efficiency stores to identify operational practices, department mix, local demand patterns, or layout strategies that could be applied to lower-efficiency stores.

### Recommendation 4: Protect high-profit and high-margin departments

Department 92 was the strongest overall profit driver, generating $136.79 million in estimated profit with a 28.27% profit margin. Department 91 had the highest margin among meaningful-volume departments at 30.80%.

These departments should be prioritized in inventory planning, shelf space decisions, and performance monitoring. High-profit departments drive total profitability, while high-margin departments can help protect profitability even when sales volume fluctuates.

The business should evaluate department performance using both total profit and profit margin rather than total sales alone.

### Recommendation 5: Reevaluate markdown strategy using margin impact, not sales lift alone

Markdown-heavy records had the highest average weekly sales, but the weakest margin performance. High-markdown records averaged $19,971.10 in weekly sales but had only a 7.55% profit margin. No-markdown records had a much stronger profit margin of 27.82%.

The correlation analysis supported this pattern. Total markdown activity had only a weak positive correlation with weekly sales at 0.0652, but a stronger negative correlation with profit margin at -0.5750.

This suggests that markdowns may increase sales intensity, but at a substantial margin cost. The business should evaluate markdown campaigns based on profit lift, margin impact, and inventory objectives rather than sales lift alone.

### Recommendation 6: Plan holiday promotions around profitability, not just sales

Holiday weeks had higher average weekly sales per record than non-holiday weeks, but they also had much higher markdown activity and lower profit margins. Holiday weeks averaged $17,035.82 in weekly sales per record compared to $15,901.45 for non-holiday weeks, but profit margin fell from 22.25% to 19.86%.

High-markdown holiday records had an especially low profit margin of 6.45%. This suggests that holiday promotions may drive demand, but they should be designed carefully to avoid unnecessary margin erosion.

The business should monitor holiday promotions using both sales and profitability KPIs.

### Recommendation Summary

The analysis suggests that Walmart store performance should be evaluated using a combination of revenue, efficiency, and profitability metrics. Large stores dominate total sales, but smaller stores can outperform on sales and profit per square foot.

Store-level reviews should focus on large low-efficiency stores, while high-efficiency stores should be studied as performance benchmarks. Department-level decisions should prioritize both high-profit and high-margin departments.

The strongest promotional insight is that markdowns appear to increase sales intensity but substantially reduce margin performance. Holiday and markdown strategies should therefore be evaluated based on profit and margin impact, not sales lift alone.

## Section 6: Tableau Dashboard Preparation

To prepare the Walmart analysis for Tableau, I created a SQL view called `walmart_dashboard_view`. This view keeps the original weekly sales records while adding calculated fields for store efficiency, profit efficiency, markdown activity, holiday status, store size category, profit margin category, and sales record status.

Creating these fields in SQL keeps the Tableau dashboard cleaner and ensures that the same business logic is used consistently across visuals and filters.

# Walmart Retail Sales Performance Analysis

## Overview

This project analyzes Walmart retail sales data across 45 stores and 81 departments to identify sales performance patterns, store efficiency differences, profitability drivers, markdown impact, and holiday demand behavior.

The main business question was:

**Which stores, departments, and time periods drive the strongest sales and profitability, and where are there signs of underperformance?**

## Business Problem

Retail businesses need to understand which stores generate the most value, which departments drive profitability, how seasonal periods affect demand, and whether promotional markdowns improve business performance.

Total sales alone can be misleading because larger stores naturally generate more revenue. This analysis uses SQL and Tableau to evaluate performance using a combination of sales volume, profit, profit margin, sales per square foot, profit per square foot, holiday impact, and markdown effectiveness.

## Tools Used

- PostgreSQL
- SQL
- Tableau Public
- VS Code
- GitHub

## Dataset

The dataset contains 421,570 weekly sales records across 45 Walmart stores and 81 departments from February 5, 2010 through October 26, 2012.

Fields include store number, department, store type, store size, date, weekly sales, holiday flag, temperature, fuel price, CPI, unemployment, markdown values, estimated profit, cost of goods sold, and profit margin.

## Analysis Process

I structured the analysis into five phases:

1. **Sales Performance Overview**  
   I analyzed total sales, profit, store count, department count, yearly trends, monthly patterns, store type performance, and top/bottom stores by sales.

2. **Store Efficiency**  
   I evaluated stores using sales per square foot and profit per square foot to identify stores that outperformed or underperformed relative to physical size.

3. **Profitability Analysis**  
   I compared stores and departments by total profit, profit margin, and profit efficiency to determine whether the highest-sales stores were also the strongest profit performers.

4. **Markdown and Holiday Impact**  
   I analyzed holiday vs non-holiday performance and evaluated whether markdown activity improved sales, profit, or margin outcomes.

5. **Recommendations**  
   I translated the findings into business recommendations focused on store evaluation, underperformance review, department strategy, and promotional decision-making.

## Key Findings

### 1. Walmart sales totaled $6.74 billion across the dataset.

The dataset contained 421,570 weekly sales records across 45 stores and 81 departments. Total sales were $6.74 billion, with estimated profit of $1.49 billion and an overall profit margin of 22.07%.

### 2. Type A stores dominated total sales, but not necessarily efficiency.

Type A stores generated the highest total sales at $4.33 billion and had the highest average weekly sales per record. This was partly driven by store size, as Type A stores were much larger on average than Type B and Type C stores.

However, store efficiency analysis showed that smaller Type B and Type C stores could outperform larger Type A stores when measured by sales per square foot and profit per square foot.

### 3. Store 10 stood out as a high-performing efficiency benchmark.

Store 10, a Type B store, generated $271.62 million in total sales and $58.24 million in estimated profit. It also produced $2,146.97 in sales per square foot and $460.32 in profit per square foot.

This made Store 10 a strong performer across both total revenue and efficiency metrics.

### 4. Store efficiency varied widely across locations.

Average sales per square foot across all stores were $1,214.19, but performance ranged from $618.19 to $2,205.58 per square foot.

High-efficiency stores averaged $1,990.36 in sales per square foot, while low-efficiency stores averaged only $768.90. This means high-efficiency stores generated roughly 2.59 times more sales per square foot than low-efficiency stores.

### 5. Profit efficiency showed a similar performance gap.

High profit-efficiency stores averaged $472.99 in profit per square foot, while low profit-efficiency stores averaged $155.77. This means high profit-efficiency stores generated roughly 3.04 times more profit per square foot than low profit-efficiency stores.

Store 43 had the highest profit per square foot at $554.27, while Store 9 had the lowest at $133.83.

### 6. Department 92 was the strongest overall profit driver.

Department 92 generated the highest estimated profit at $136.79 million and had a strong profit margin of 28.27%. Department 91 had the highest margin among meaningful-volume departments at 30.80%.

This showed that department performance should be evaluated using both total profit and profit margin.

### 7. Holiday weeks increased sales intensity but reduced margin.

Holiday weeks had higher average weekly sales per record at $17,035.82 compared to $15,901.45 for non-holiday weeks. However, holiday weeks had much higher markdown activity and a lower profit margin of 19.86%, compared to 22.25% for non-holiday weeks.

### 8. Markdown-heavy periods increased sales but reduced profitability.

High-markdown records had the highest average weekly sales at $19,971.10, but the lowest profit margin at only 7.55%. No-markdown records had a much stronger profit margin of 27.82%.

Correlation analysis supported this finding. Markdown activity had only a weak positive correlation with weekly sales at 0.0652, but a stronger negative correlation with profit margin at -0.5750.

## Recommendations

### 1. Evaluate stores using both total sales and efficiency metrics.

Total sales alone can be misleading because larger stores naturally generate more revenue. Store performance should be evaluated using sales, profit, sales per square foot, and profit per square foot.

### 2. Review large low-efficiency stores for potential underperformance.

Stores such as Store 32, Store 28, and Store 9 should be reviewed for possible issues related to local market demand, department mix, layout, staffing, inventory strategy, or promotional effectiveness.

### 3. Use high-efficiency stores as performance benchmarks.

Stores 43, 10, 42, 37, and 23 were strong performers based on sales per square foot. Store 10 is especially useful as a benchmark because it ranked highly in both total sales and efficiency metrics.

### 4. Protect high-profit and high-margin departments.

Department 92 should be prioritized as a major profit driver, while Department 91 should be monitored as a high-margin department. Department strategy should consider both total profit and profit margin.

### 5. Reevaluate markdown strategy using margin impact.

Markdown-heavy records generated higher average sales but substantially weaker margins. Markdown campaigns should be evaluated by profit lift, margin impact, and inventory objectives rather than sales lift alone.

### 6. Plan holiday promotions around profitability.

Holiday periods increased sales intensity but lowered profit margin, especially when markdown activity was high. Holiday promotions should be monitored using both sales and profitability KPIs.

## Limitations

This dataset includes estimated profit, COGS, and margin fields, so profitability findings depend on those assumptions. The dataset also ends in October 2012, making 2012 a partial year that should not be directly compared to complete years without context.

The dataset does not include detailed store operating costs, labor costs, rent, inventory stockouts, local competition, customer traffic, or actual promotion campaign details. These fields would improve future store performance and markdown effectiveness analysis.

## Links

- Tableau Dashboard: [PASTE_TABLEAU_LINK_HERE](https://public.tableau.com/app/profile/anton.jackson3576/viz/Walmartdashboard_17726474850320/Dashboard1)
- GitHub Repository: https://github.com/ant28725/walmart-retail-sales-analysis