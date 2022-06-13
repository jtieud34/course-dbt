1. Q: How many users do we have?
1. A: 130
```
    -- total users
    select count(distinct user_id) unique_users

    from dbt_john_t.stg__users
```

2. Q:On average, how many orders do we receive per hour?
2. A: 15.04
```
    -- average orders per hour

    with agg_orders AS (

    select  date_part('hour',created_at) hr
            ,count(distinct order_id) total_hours

    from dbt_john_t.stg__orders
    group by 1
    )

    select avg(total_hours)

    from agg_orders
```
3. Q:On average, how long does an order take from being placed to being delivered?
3. A: 3 days, 21 hours
```
    -- avg time to delivery

    with agg_orders AS (

    select  order_id,
            delivered_at-created_at diff
            

    from dbt_john_t.stg__orders
    )

    select avg(diff)

    from agg_orders
```

4. Q:How many users have only made one purchase? Two purchases? Three+ purchases?
4. A:
| purchas_freq  | frequency  |
|---|---|
| 1 | 25  |
| 2 | 28  |
| 3 | 34  |

```
    -- freq of user orders

    with user_orders AS (
    select  user_id,
            count(distinct order_id) uni_orders
            

    from dbt_john_t.stg__orders
    group by 1
    
    )

    select case 
            when uni_orders <3 then uni_orders::varchar
            else '3+'
            end as purchas_freq,
            count(*) frequency
    from user_orders
    group by 1
```
Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

5. Q:On average, how many unique sessions do we have per hour?
5. A: 39.46

```
    -- avg unique sessions per hour

    with agg_sessions as (
    select date_part('hour',created_at) event_hour,
        count(distinct session_id) unique_sessions

    from dbt_john_t.stg__events
    group by 1
    )

    select avg(unique_sessions)

    from agg_sessions
```