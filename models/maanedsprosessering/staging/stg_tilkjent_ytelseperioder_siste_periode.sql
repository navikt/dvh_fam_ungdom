with tilkjent_ytelseperioder_siste_periode as (
  select 
    FK_UP_FAGSAK
    ,FOM
    ,TOM
    ,DAGSATS
    ,ROW_NUMBER () over (partition by FK_UP_FAGSAK order by FOM DESC) RN
    from {{ source ('fam_ungdom', 'fam_up_tilkjent_ytelseperioder') }}
)

select * 
from tilkjent_ytelseperioder_siste_periode 
where RN=1