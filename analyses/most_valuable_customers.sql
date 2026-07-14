with fct_orders as (
 select * from {{ ref('fct_orders')}}
),
dim_customers as (
 select * from {{ ref('dim_customers' )}}
)


SELECT
  cust.customer_id,
  cust.first_name,
  SUM(ord.total_amount) AS global_paid_amount -- Ensure this references 'ord'
FROM fct_orders AS ord
LEFT JOIN dim_customers AS cust 
  ON ord.customer_id = cust.customer_id
WHERE ord.is_order_completed = 1
GROUP BY 1, 2 -- Using numbers 1, 2 is safer and cleaner in BigQuery
ORDER BY 3 DESC

