```python
# processing.py: Python script for statistical analysis and promotional lift
# Purpose: Compare test vs. control regions and quantify promotional lift

import pandas as pd
import numpy as np
from scipy import stats
import sqlite3

# Connect to SQLite database (simulating SQL output)
conn = sqlite3.connect('retail_pricing.db')
df = pd.read_sql_query("SELECT * FROM retail_pricing.sales_data", conn)

# Calculate promotional lift by category and campaign
def calculate_lift(df):
    lift_data = df[df['campaign_type'] != 'None'].groupby(['product_category', 'campaign_type', 'region'])['units_sold'].mean().unstack()
    lift_data['lift_pct'] = (lift_data['Test'] - lift_data['Control']) / lift_data['Control'] * 100
    return lift_data[['lift_pct']].reset_index()

# Perform t-test to check significance of lift
def t_test_lift(df, category, campaign):
    test_data = df[(df['product_category'] == category) & (df['campaign_type'] == campaign) & (df['region'] == 'Test')]['units_sold']
    control_data = df[(df['product_category'] == category) & (df['campaign_type'] == campaign) & (df['region'] == 'Control')]['units_sold']
    t_stat, p_value = stats.ttest_ind(test_data, control_data, equal_var=False)
    return {'category': category, 'campaign': campaign, 't_stat': t_stat, 'p_value': p_value}

# Calculate elasticity
def calculate_elasticity(df, category):
    category_data = df[df['product_category'] == category][['discount_pct', 'units_sold']].groupby('discount_pct').mean().reset_index()
    category_data['prev_units_sold'] = category_data['units_sold'].shift(1)
    category_data['elasticity'] = ((category_data['units_sold'] - category_data['prev_units_sold']) / category_data['prev_units_sold']) / (category_data['discount_pct'] / 100)
    return category_data[['discount_pct', 'elasticity']].dropna()

# Example usage
lift_results = calculate_lift(df)
print("Promotional Lift (%):")
print(lift_results)

# Run t-tests for significance
categories = df['product_category'].unique()
campaigns = df[df['campaign_type'] != 'None']['campaign_type'].unique()
t_test_results = [t_test_lift(df, cat, camp) for cat in categories for camp in campaigns]
t_test_df = pd.DataFrame(t_test_results)
print("\nT-Test Results:")
print(t_test_df)

# Calculate elasticity for each category
elasticity_results = pd.concat([calculate_elasticity(df, cat) for cat in categories])
print("\nElasticity Results:")
print(elasticity_results)

# Export results to CSV for Tableau integration
lift_results.to_csv('lift_results.csv', index=False)
t_test_df.to_csv('t_test_results.csv', index=False)
elasticity_results.to_csv('elasticity_results.csv', index=False)

conn.close()
```
