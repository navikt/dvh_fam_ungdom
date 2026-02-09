with dim_tid_dag as (
  select 
    dim_nivaa
    ,DAG_I_UKE
    ,DATO
    ,AAR_MAANED
    ,GYLDIG_FLAGG
    ,SISTE_DATO_I_PERIODEN
    from {{ source ('kode_verk', 'dim_tid') }}
)

select * 
from dim_tid_dag 