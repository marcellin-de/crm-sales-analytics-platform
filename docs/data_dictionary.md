# Data Dictionary

## customers

| Column | Description |
|---|---|
| customer_id | Unique identifier of the customer |
| customer_name | Customer company name |
| industry | Customer industry |
| company_size | Size segment of the company |
| country | Customer country |
| region_id | Region identifier |
| created_at | Customer creation date |

## products

| Column | Description |
|---|---|
| product_id | Unique identifier of the product |
| product_name | Product name |
| category | Product category |
| unit_price | Standard unit price |
| created_at | Product creation date |

## sales_reps

| Column | Description |
|---|---|
| sales_rep_id | Unique identifier of the sales representative |
| sales_rep_name | Sales representative full name |
| email | Sales representative email |
| region_id | Assigned region |
| hire_date | Hiring date |

## regions

| Column | Description |
|---|---|
| region_id | Unique identifier of the region |
| region_name | Region name |
| country | Country of the region |

## orders

| Column | Description |
|---|---|
| order_id | Unique identifier of the order |
| customer_id | Customer identifier |
| sales_rep_id | Sales representative identifier |
| order_date | Date of the order |
| order_status | Status of the order |
| payment_status | Payment status |

## order_items

| Column | Description |
|---|---|
| order_item_id | Unique identifier of the order item |
| order_id | Order identifier |
| product_id | Product identifier |
| quantity | Quantity sold |
| unit_price | Unit price at the time of sale |
| discount | Discount applied |

## opportunities

| Column | Description |
|---|---|
| opportunity_id | Unique identifier of the opportunity |
| customer_id | Customer identifier |
| sales_rep_id | Sales representative identifier |
| created_date | Opportunity creation date |
| close_date | Opportunity closing date |
| stage | Opportunity stage |
| expected_revenue | Expected revenue |
| probability | Probability of closing |