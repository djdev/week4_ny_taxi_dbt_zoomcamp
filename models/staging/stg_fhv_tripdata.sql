{{
    config(
        materialized='view'
    )
}}

select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    dispatching_base_num,
    PUlocationID,
    DOlocationID,

    -- timestamps
    pickup_datetime,
    dropoff_datetime,

    -- trip info
    SR_Flag,
    Affiliated_base_number
from {{ source('staging','fhv_tripdata_2019') }}
where dispatching_base_num is not null 

-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}