# Retail Pricing & Promotion Effectiveness 📊💰

## Introduction 🌟
In the fast-paced world of e-commerce, understanding how discounts and promotional campaigns impact sales is critical for maximizing revenue. This project, conducted in 2022, dives into a simulated retail dataset to measure the effectiveness of pricing strategies and promotional campaigns. By leveraging SQL and Python, we analyzed demand elasticity and quantified promotional lift, providing actionable insights for optimizing targeted marketing spend.

The goal was to create a robust framework for evaluating how discounts influence consumer behavior and to demonstrate the potential for incremental revenue through data-driven promotion strategies.

## Literature Review 📚🔍
Inspired by studies on retail analytics from sources like Harvard Business Review and industry reports from McKinsey, we explored demand elasticity and promotional effectiveness. Previous research, such as A/B testing frameworks in e-commerce and statistical models for price sensitivity, guided our approach. These studies often use SQL for data aggregation and Python for statistical analysis, aligning with our methodology.

## Problem Statement 🎯
Can we quantify the impact of discounts and promotional campaigns on sales volume and revenue in a retail setting? This project aims to measure demand elasticity and promotional lift by comparing test and control regions, providing clear insights into how targeted promotions drive incremental sales.

## Methodology 📊🔬
We employed a two-pronged approach:
1. **SQL Modeling**: Built SQL queries to aggregate sales data and calculate demand elasticity across different discount levels.
2. **Python Analysis**: Used Python (pandas, numpy, scipy) to perform statistical comparisons between test and control regions, quantifying promotional lift.

These methods allowed us to isolate the effects of discounts and campaigns on sales performance.

## Data Collection and Preparation 📈🔍
The dataset was a simulated e-commerce dataset containing sales records, discount levels, campaign details, and regional metadata. Key variables included:
- Units sold
- Discount percentage
- Campaign type (e.g., flash sale, seasonal promotion)
- Region (test vs. control)

We used SQL to clean and aggregate the data, handling missing values and standardizing formats. Python scripts further processed the data, creating derived metrics like elasticity scores and lift percentages. The dataset was split into test and control groups to ensure robust statistical comparisons.

## Analysis and Results 📝📈
The analysis yielded the following insights:
- **Demand Elasticity**: SQL models revealed that a 10% discount increased units sold by 15% on average, with elasticity varying by product category (e.g., electronics showed higher sensitivity than apparel).
- **Promotional Lift**: Python analysis showed a 12% average lift in units sold in test regions compared to control regions during campaigns, with statistically significant results (p < 0.05).
- **Revenue Impact**: Targeted promotions in high-elasticity categories drove 8% incremental revenue, as validated through A/B testing comparisons.

Results were visualized in a Tableau dashboard, showcasing elasticity curves and lift metrics by region and category.

## Conclusion and Recommendations 🎉🔮
This project demonstrated that targeted discounts and promotions significantly influence sales, with clear variations by product category and region. We recommend:
- Prioritizing promotions in high-elasticity categories like electronics.
- Using A/B testing to refine campaign strategies before scaling.
- Integrating real-time sales data into the SQL models for dynamic pricing adjustments.

This framework can empower e-commerce teams to optimize promotional spend and drive sustainable revenue growth! 🛒🚀

### Repository Files
- `analysis.sql`: SQL queries for demand elasticity and data aggregation.
- `processing.py`: Python scripts for statistical analysis and lift calculations.
- `report.pdf`: Detailed report with methodology, results, and visualizations.
