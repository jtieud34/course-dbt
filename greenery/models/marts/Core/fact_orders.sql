select  o.order_id,
        o.user_id,
        u.email,
        o.created_at,
        -- order details
        p.name as product_name,
        p.price as product_unit_price,
        it.quantity,
        -- costs
        o.order_cost,
        o.promo_id,
        pr.discount,
        pr.status promo_status,
        o.shipping_cost,
        o.order_total,
        -- shipping
        o.address_id,
        a.address,
        a.state,
        a.zipcode,
        a.country,
        o.tracking_id,
        o.shipping_service,
        -- status
        o.status,
        o.estimated_delivery_at,
        o.delivered_at,
        case
            when o.status = 'delivered' then o.estimated_delivery_at::date-o.delivered_at::date
        end as variance_estimate_actual_time_to_delivery,      
        case
            when o.status = 'delivered' then o.created_at::date-o.delivered_at::date
        end as time_to_delivery


from {{ref('stg__orders')}} o
left join {{ref('dim_users')}} u ON u.user_id = o.user_id
left join {{ref('stg__order_items')}} it ON it.order_id = o.order_id
left join {{ref('dim_products')}} p ON p.product_id = it.product_id
left join {{ref('stg__addresses')}} a ON o.address_id = a.address_id
left join {{ref('stg__promos')}} pr ON pr.promo_id = o.promo_id