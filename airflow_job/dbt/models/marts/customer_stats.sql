-- stats for customers
WITH customer_stats AS (
    SELECT
        DATE(invoice_date) AS order_date,
        customer_id,
        COUNT(DISTINCT invoice) AS daily_orders,
        SUM(total_amt) AS total_spent,
        MIN(total_amt) AS min_spent,
        MAX(total_amt) AS max_spent,
        SUM(quantity) AS total_quantity,
        AVG(price) AS avg_price
    FROM {{ source('transformed_data', 'online_retail_transformed') }}
    GROUP BY order_date, customer_id
)
SELECT * FROM customer_stats