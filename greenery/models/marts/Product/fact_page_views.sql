    
{{
    config(
        materialized='incremental',
        unique_key = 'event_date'
    )
}}
    
    SELECT  created_at::date event_date,
            event_type,
            product_id,
            count(distinct session_id) total_sessions,
            count(distinct user_id) as unique_users

    FROM {{ref('stg__events')}}

    {% if is_incremental() %}

    -- this filter will only be applied on an incremental run
    where event_date >= (select max(event_date) from {{ this }})

    {% endif %}
    
    group by 1,2,3