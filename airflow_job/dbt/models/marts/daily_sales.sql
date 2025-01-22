WITH base AS (
    SELECT
        DATE(invoice_date) AS order_date,
        customer_id,
        SUM(total_amt) AS total_spent,
        COUNT(DISTINCT invoice) AS total_orders,
        COUNT(DISTINCT customer_id) AS unique_customers
    FROM {{ source('transformed_data', 'online_retail_transformed') }}
    GROUP BY order_date, customer_id
),
daily_summary AS (
    SELECT
        order_date,
        COUNT(DISTINCT customer_id) AS unique_customers,
        SUM(total_orders) AS total_orders,
        SUM(total_spent) AS total_revenue,
        AVG(total_spent) AS avg_spent_per_order
    FROM base
    GROUP BY order_date
)
SELECT * FROM daily_summary
