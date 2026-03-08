{{ config(materialized='table') }}

with first_model as (
    select
        id,
        case when id is null then 'null' else 'valid' end as id_status
    from {{ ref('my_first_dbt_model') }}
),

second_model as (
    select id from {{ ref('my_second_dbt_model') }}
),

summary as (
    select
        (select count(*) from first_model)                          as total_rows_first_model,
        (select count(*) from first_model where id_status = 'valid') as valid_rows_first_model,
        (select count(*) from first_model where id_status = 'null')  as null_rows_first_model,
        (select count(*) from second_model)                         as total_rows_second_model,
        (select min(id) from second_model)                          as min_id_second_model,
        (select max(id) from second_model)                          as max_id_second_model
)

select
    total_rows_first_model,
    valid_rows_first_model,
    null_rows_first_model,
    round(valid_rows_first_model * 100.0 / total_rows_first_model, 1) as valid_pct,
    round(null_rows_first_model  * 100.0 / total_rows_first_model, 1) as null_pct,
    total_rows_second_model,
    min_id_second_model,
    max_id_second_model
from summary
