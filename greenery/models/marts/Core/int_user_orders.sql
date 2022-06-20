  -- int_user_orders.sql
      {{
        config(
            materialized='table'
        )
    }}


    select o.*,
            u.email,
            u.address,
            u.zipcode,
            u.state,
            u.country

    from {{ref('stg__orders')}} o
    left join {{ref('dim_users')}} u ON o.user_id = u.user_id