{{
    config(
        materialized = 'table'
    )
}}

select  o.order_id,
        o.product_name,
        o.product_unit_price,
        o.quantity,
        order_total,
        o.promo_id,
        pr.discount,
        pr.status promo_status

from {{ref('fact_orders')}} o
left join {{ref('stg__promos')}} pr ON pr.promo_id = o.promo_id