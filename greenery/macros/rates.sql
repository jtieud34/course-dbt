{% macro funne_rates(stage,step1,step1) %}

select s1.count1*1.0/s2.count2 as {{stage}}

  from (
  select  count(distinct session_id) count1

  from {{ref('fact_page_views')}}
  where event_type = '{{step1}}'

  ) s1,
  )
  select  count(distinct session_id) count2

  from {{ref('fact_page_views')}}
  where event_type = '{{step2}}'

) s2

{% endmacro %}