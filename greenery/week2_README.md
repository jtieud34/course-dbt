q1 repeate rate: .7983
```
with user_agg AS (

select count(user_id) as total_users_w_purchase,
      sum(case when total_orders >1 then 1 else 0 end) as repeat_purchases

from dbt_john_t.fact_user_orders
)

select repeat_purchases*1.0/total_users_w_purchase

from user_agg
```

What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

First and biggest would be the repeate purchasers segment.  Users who only browse through a few pages and never add any items to the chart.  I would want to look at LCM data (email) things like impressions, clicks, opens, click through.  How do landing pages from campaigns perform.  For Example if an email campaign has a great open rate but the landing page bounce rate is high this could be something we would flag to product marketing teams to investigate content or possible page issues causing users to not interact.

I created the suggested marts: Core, Marketing, Product.
Under core I included models for dim_products, dim_users, fact_orders, and int_user_orders.  The rationale for intermediate user_orders was the ability to include more data on the user such as country, email, zipcode.  This model could be used by product marketing managers to analyze how certain promotions are performing across different regions and optimize spend accordingly. 

Under marketing, I included a converted users model to help analyze event session performace using the conversion_flag derived from event_type 'checkout'  This flag can be used to determine by session_id the rates by which user cohorts based on event_date are converting and could be grouped by state or country to determine efficacy of content or if available performance of specific aquisition channels.

Under product I created page view facts model which leverages dbt incremental model strategy.  In my experience top of funnel events data is typically the largest dataset analyst, data publishers work with.  So using an incermental strategy to only extract, load, and transform the newest data is the most optimal way to handle such a large data source.

Q: What assumptions are you making about each model? (i.e. why are you adding each test?)

A: I stuck to the out of the box test with this greenery dataset unique and not_null. I tend to focus on the downstream metrics and construct test around critical fields used in various high visiblity metrics used by the business.  Based on that thought process I will develop test around those key columns and value ranges.  In my day job I've worked extensively with extending the basic principles of the test availble in DBT public git repo such as,  writing macros for `not_null_where`, and `unique_where` which allows me to pass arguments like model, column, condition this allows you to pass conditions to those test macros to isolate subsets of data that span long time periods which otherwide may fail with the generical out of box schema tests.

Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

A: only 1 failure on `not_null_my_first_dbt_model_id.sql`


Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.