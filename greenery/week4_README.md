## Week 4 Project Answers

### PART 1: dbt Snapshots

#### Run dbt snapshot again and see how the data has changed for those two orders

  ```
select * from dbt.snapshots."orders_snapshot" where dbt_valid_to is not null
   ```

### PART 2: Modeling challenge

#### Please create any additional dbt models needed to help answer these questions from our product team, and put your answers in a README in your repo.

  ```
select s2.count2*1.0/s1.count1 as add_to_chart_rate

  from (
  select  sum(total_sessions) count1

  from dbt_john_t.fact_page_views
  where event_type = 'page_view'

  ) s1,
  (
  select  sum(total_sessions) count2

  from dbt_john_t.fact_page_views
  where event_type = 'add_to_cart'

) s2
   ```

add to cart rate
```
0.53
```



  ```
select s2.count2*1.0/s1.count1 as checkout_rate

  from (
  select  sum(total_sessions) count1

  from dbt_john_t.fact_page_views
  where event_type = 'add_to_cart'

  ) s1,
  (
  select  sum(total_sessions) count2

  from dbt_john_t.fact_page_views
  where event_type = 'checkout'

) s2
   ```

checkout rate
```
0.36
```

3A.  Based on my experience using DBT in my current role, I would highly reccomend scheduled model audits.  Specifically, to review layers and refine any duplicative joins or transformations.  I find often the largest focus on peer reviews is final output accuracy.  It goes without saying we have to get the final output correct but often times we move at such a fast pace debt tech becomes common place.

3B.  I'm partial to Airflow because I have been using it now for 2+ years.  With infra setup by our core data infra team it is quite easy for analyst and data scientist to create DAGs that call dbt commands where we can leveral model selection syntax to achieve simple and complex models along with their parent/child nodes.