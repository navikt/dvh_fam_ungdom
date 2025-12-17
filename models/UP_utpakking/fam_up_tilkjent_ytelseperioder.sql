{{
    config(
        materialized='incremental'
    )
}}

with up_meta_data as (
    select * from {{ ref('up_meldinger_til_aa_pakke_ut') }}
),

up_fagsak as (
    select * from {{ ref('fam_up_fagsak') }}
),

pre_final as (
    select *
    from up_meta_data
        ,json_table(melding, '$'
            columns (
                behandling_uuid       varchar2 path '$.behandlingUuid',
                nested path '$.tilkjentYtelsePerioder[*]'
                columns (
                    FOM          varchar2 path '$.fom',
                    TOM          varchar2 path '$.tom',
                    DAGSATS      varchar2 path '$.dagsats',
                    REDUKSJON    varchar2 path '$.reduksjon',
                    KLASSEKODE   varchar2 path '$.klassekode'
                )
            )
        ) j
    where FOM is not null
),

final as (
    select
        to_date(FOM,'yyyy-mm-dd') as FOM,
        to_date(TOM,'yyyy-mm-dd') as TOM,
        DAGSATS,
        REDUKSJON,
        KLASSEKODE,
        up_fagsak.pk_up_fagsak    as FK_UP_FAGSAK
    from pre_final
    join up_fagsak
      on pre_final.behandling_uuid  = up_fagsak.behandling_uuid
)

select
    DVH_FAM_UNGDOM.DVH_FAM_UP_SEQ.nextval as PK_UP_TILKJENT_YTELSEPERIODE
    ,FK_UP_FAGSAK
    ,FOM
    ,TOM
    ,DAGSATS
    ,REDUKSJON
    ,KLASSEKODE
    ,localtimestamp as LASTET_DATO
from final