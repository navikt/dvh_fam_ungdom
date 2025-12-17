{{
    config(
        materialized='table'
    )
}}

with ungdomsprogram_meta_data as (
  select pk_up_meta_data, kafka_offset, kafka_mottatt_dato, kafka_topic, kafka_partition, melding from {{ source ('fam_ungdom', 'fam_up_meta_data') }}
    where kafka_mottatt_dato >= sysdate - 30 and kafka_offset not in (
      select kafka_offset from {{ source ('fam_ungdom', 'fam_up_fagsak') }})
)

select * from ungdomsprogram_meta_data