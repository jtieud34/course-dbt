  -- fact_user_orders.sql
      {{
        config(
            materialized='table'
        )
    }}


    select user_id,
            count(order_id) as total_orders

    from {{ref('int_user_orders')}}
    group by 1