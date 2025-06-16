# Retail Analytics: Customer Behavior & Gross Margin Optimization
This project analyzes customer and transactional data from a multi-store U.S. apparel and accessories retailer focused on the Boston area. The objective is to identify key drivers of gross margin performance, understand customer behavior, and develop actionable recommendations using R-based analytics.

##  Business Context:
The company seeks to optimize its pricing strategies and operational efficiency. The focus is on sales and profitability by category, including identifying which customer types and purchase patterns are most beneficial for the business.

##  Files Included:

```
├── customer_purchases.csv        # Final customer-level joined dataset
├── analytics_final_script.R      # Complete R script with data wrangling, stats, plots & modeling
├── Analytics problem.pdf         # Report containing ERD, cleaning steps, statistics, and recommendations
└── README.md                     # You're here!
```

##  Data Cleaning Summary:

- Standardized `Customer.state` to two-letter codes
- Replaced invalid age entries with median values
- Imputed missing `birthday.month` with the mode
- Filled blanks in survey responses (`in.store.experience`, `selection`) with "N/A"

## Data Wrangling & EDA:

- **Customer Summary:**  
  - Calculated total items purchased and average sale price per customer
  - Joined customer and transaction data using inner join on `customer.id`

- **Summary Statistics (sale.amount):**  
  - Mean = 60.60  
  - Median = 56.2  
  - SD = 36.26  
  - Skewness = 1.01

- **Visualizations:**  
  - Boxplot of overall sale.amount  
  - Boxplot of sale.amount by product category

- **Outlier Detection:**  
  - Identified 21 outliers using IQR method  
  - Suggested options: remove, bin, or impute

- **Blended Gross Margin by Category:**

| Category          | GM%    |
|-------------------|--------|
| Men's Apparel     | 65.53% |
| Footwear          | 63.40% |
| Women's Apparel   | 63.31% |
| Children          | 63.09% |
| Accessories       | 62.41% |
| Gifts & Lifestyle | 57.73% |

## Hypothesis Test:

- **Goal**: Is the mean GM% for Footwear significantly different from zero?
- **Test Used**: One-sample two-tailed t-test
- **Result**:  
  - t = 64.624  
  - p-value < 0.0001  
  - ✅ Reject H₀ → Footwear is significantly profitable

## Regression Analysis:

- **Model**: Linear Regression  
  - `gross.margin ~ qty + price.category + sale.amount + interaction terms + unit.cost + unit.original.retail`

- **Key Metrics**:
  - R² = 0.7127
  - Adjusted R² = 0.7124

- **Insights**:
  - 🔼 `sale.amount` increases gross margin
  - 🔽 `qty` and `unit.cost` negatively impact margin
  - 🔼 `Full Price` sales outperform markdowns
  - Interaction terms show diminishing returns on high-volume markdowns

## Recommendations:

- **Pricing Strategy**: Encourage full-price sales and reduce markdown dependency
- **Category Optimization**: Focus improvement efforts on low-margin categories (e.g., Gifts, Accessories)
- **Operational Efficiency**: Revisit bulk discounting and reduce unit costs

## Tools & Technologies:

- **Language**: R
- **Libraries**: `dplyr`, `ggplot2`, `stats`
- **Output**:

 ![Image Alt](https://github.com/PTanish01/Retail-Sales-and-Customer-Behavior-Analysis/blob/main/Screenshot%202025-06-15%20200715.jpg)
  ![Image Alt](https://github.com/PTanish01/Retail-Sales-and-Customer-Behavior-Analysis/blob/main/Screenshot%202025-06-15%20200753.jpg)
  ![Image Alt](https://github.com/PTanish01/Retail-Sales-and-Customer-Behavior-Analysis/blob/main/Screenshot%202025-06-15%20200928.jpg)
