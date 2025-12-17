{{
    config(
        materialized='incremental'
    )
}}

with up_meta_data as (
    select * from {{ref ('up_meldinger_til_aa_pakke_ut')}} 
),

up_fagsak as (
    select * from {{ref ('fam_up_fagsak')}}
),


pre_final as (
    select *
    from up_meta_data
        ,json_table(melding, '$'
            columns (
                -- legg til annet jeg trenger? f.eks saksnummer?
                nested path '$.behandlingsperioder[*]'
                columns (
                    FOM             varchar2 path '$.fom',
                    TOM             varchar2 path '$.tom',
                    UTFALL          varchar2 path '$.utfall'
                )
            )
        ) j
    where FOM is not null
),


final as (
    select
        to_date(periode_fom,'yyyy-mm-dd') as FOM,
        to_date(periode_tom,'yyyy-mm-dd') as TOM,
        UTFALL,
        up_fagsak.pk_up_fagsak as FK_UP_FAGSAK
    from pre_final
    join up_fagsak
      on pre_final.kafka_offset     = up_fagsak.kafka_offset
     and pre_final.saksnummer       = up_fagsak.saksnummer
     --and pre_final.behandling_uuid  = up_fagsak.behandling_uuid
)

select
    DVH_FAM_UNGDOM.DVH_FAM_UP_SEQ.nextval as PK_UP_BEHANDLINGSPERIODE
    ,FK_UP_FAGSAK
    ,FOM
    ,TOM
    ,UTFALL
    ,LASTET_DATO
from final

