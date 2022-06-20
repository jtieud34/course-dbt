{{
    config(
        materialized = 'table'
    )
}}

select users.user_id,
       users.first_name,
       users.last_name,
       users.email,
       users.phone_number,
       users.created_at,
       users.updated_at, 
       a.address_id,
       a.address,
       a.zipcode,
       a.state,
       a.country

from {{ref('stg__users')}} users
left join {{ref('stg__addresses')}} a ON users.address_id = a.address_id