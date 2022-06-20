{{
    config(
        materialized='incremental',
        unique_key = 'event_date'
    )
}}

    with users AS (

      select user_id,
              address,
              zipcode,
              state,
              country

      from {{ref('dim_users')}}
    )


      SELECT  created_at,
            created_at::date event_date,
              event_type,
              e.user_id,
              zipcode,
              state,
              country,
              session_id,
              case
                when event_type = 'checkout' then TRUE
                else FALSE
              end as conversion_flag

      FROM {{ref('stg__events')}} e 
      left join users u on e.user_id = u.user_id
        {% if is_incremental() %}


        where event_date >= (select max(event_date) from {{ this }})

        {% endif %}