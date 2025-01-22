WITH base AS (
    SELECT
        EXTRACT(YEAR FROM invoice_date::DATE) AS order_year,
        EXTRACT(MONTH FROM invoice_date::DATE) AS order_month,
        customer_id,
        SUM(total_amt) AS total_spent,
        COUNT(DISTINCT invoice) AS total_orders,
        COUNT(DISTINCT customer_id) AS unique_customers
    FROM {{ source('transformed_data', 'online_retail_transformed') }}
    GROUP BY order_year, order_month, customer_id
),
monthly_summary AS (
    SELECT
        order_year, order_month,
        COUNT(DISTINCT customer_id) AS unique_customers,
        SUM(total_orders) AS total_orders,
        SUM(total_spent) AS total_revenue,
        AVG(total_spent) AS avg_spent_per_order,
        AVG(total_orders) AS avg_order_per_customer
    FROM base
    GROUP BY order_year, order_month
)
SELECT * FROM monthly_summary
