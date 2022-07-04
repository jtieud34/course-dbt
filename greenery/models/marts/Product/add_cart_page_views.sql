select  event_date,
        event_type,
        product_id,
        total_sessions,
        unique_users

from {{ref('fact_page_views')}}
where event_type = 'add_to_cart'