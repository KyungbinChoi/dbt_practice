WITH base AS (
    SELECT
        DATE(invoice_date) AS order_date,
        customer_id,
        COUNT(DISTINCT invoice) AS total_orders,
        SUM(total_amt) AS total_spent
    FROM {{ source('transformed_data', 'online_retail_transformed') }}
    GROUP BY order_date, customer_id
),
customer_stats AS (
    SELECT
        order_date,
        MIN(total_spent) AS min_spent,
        MAX(total_spent) AS max_spent,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_spent) AS pct_25_spent,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_spent) AS pct_50_spent,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_spent) AS pct_75_spent,
        MIN(total_orders) AS min_orders,
        MAX(total_orders) AS max_orders,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_orders) AS pct_25_orders,
        PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY total_orders) AS pct_50_orders,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_orders) AS pct_75_orders
    FROM base
    GROUP BY order_date
)
SELECT * FROM customer_stats