library(dplyr)
library(ggplot2)

#3.1 Calculate the number of items purchased and average item sale price per customer
customer_summary <- sales %>%
  filter(!is.na(customer.id)) %>%  # Exclude rows with missing customer.id
  group_by(customer.id) %>%
  summarise(
    total_items_purchased = sum(qty, na.rm = TRUE),
    average_sale_price = mean(sale.amount / qty, na.rm = TRUE))

print(customer_summary)

#3.2 Join the customer-level transaction data with the cleaned customer data
customer_purchases <- customer_summary %>%
  inner_join(customers_Foundations_assnt_Final, by = "customer.id")  #inner join

print(customer_purchases)

# Specify the full path where the file should be saved
file_path <- "/Users/mrinalikarthik/Desktop/customer_purchases.csv"

# Export the DataFrame to the specified path
write.csv(customer_purchases, file = file_path, row.names = FALSE)

#4.1 Compute the mean, median, standard deviation, and skewness coefficient for sale amount, using the data in the 'sales' file.
mu.sales <- mean(sales$sale.amount)
me.sales <- median(sales$sale.amount)
sd.sales <- sd(sales$sale.amount)

#4.2 Produce well-formatted boxplots
# 1. Boxplot for the distribution of sale amount for all sales records
ggplot(sales, aes(x = sale.amount)) +
  geom_boxplot(fill = "skyblue", color = "pink") +
  labs(title = "Distribution of Sale Amount (All Sales Records)",
       y = "Sale Amount",
       x = "All Sales") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5))

# 2. Boxplot for the distribution of sale amount by product category
ggplot(sales, aes(x = category, y = sale.amount)) +
  geom_boxplot(fill = "gold", color = "black") +
  labs(title = "Distribution of Sale Amount by Product Category",
       x = "Product Category",
       y = "Sale Amount") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5))

#4.3
blended_gross_margin <- sales %>%
  group_by(category) %>%
  summarise(
    total_sale_amount = sum(sale.amount, na.rm = TRUE),
    total_ext_cost = sum(ext.cost, na.rm = TRUE),
    blended_gross_margin = ((total_sale_amount - total_ext_cost) / total_sale_amount) * 100)

print(blended_gross_margin)

# Specify the full path where the file should be saved
file.path <- "/Users/mrinalikarthik/Desktop/blended_gross_margin"

# Export the DataFrame to the specified path
write.csv(blended_gross_margin, file = file_path, row.names = FALSE)

#4.4 Calculate Outliers 
Q1 <- quantile(sales$sale.amount, 0.25)
Q3 <- quantile(sales$sale.amount, 0.75)
IQR <- Q3 - Q1

lower_bound <- Q1 - 1.5 * IQR
upper_bound <- Q3 + 1.5 * IQR

outliers <- sales$sale.amount[sales$sale.amount < lower_bound | sales$sale.amount > upper_bound]
print(outliers)

#5. Hypothesis Test 
footwear_gm <- subset(sales, category == "Footwear")$gross.margin

t_test_result <- t.test(footwear_gm, mu = 0)

print(t_test_result)

#6. Regression Analysis 
regression.model.1 <- lm(formula = gross.margin ~ qty + price.category + 
    sale.amount + price.category*sale.amount + unit.cost + unit.original.retail, data = sales)
summary (regression.model.1)
  
