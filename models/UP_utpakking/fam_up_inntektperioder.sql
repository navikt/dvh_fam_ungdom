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
                behandling_uuid      varchar2 path '$.behandlingUuid',
                nested path '$.inntektPerioder[*]'
                columns (
                    FOM         varchar2 path '$.fom',
                    TOM         varchar2 path '$.tom',
                    INNTEKT     varchar2 path '$.inntekt'
                )
            )
        ) j
    where FOM is not null
),

final as (
    select
        to_date(FOM,'yyyy-mm-dd') as FOM,
        to_date(TOM,'yyyy-mm-dd') as TOM,
        INNTEKT,
        up_fagsak.pk_up_fagsak    as FK_UP_FAGSAK
    from pre_final
    join up_fagsak
      on pre_final.behandling_uuid  = up_fagsak.behandling_uuid
)

select
    DVH_FAM_UNGDOM.DVH_FAM_UP_SEQ.nextval as PK_UP_INNTEKTPERIODE,
    FK_UP_FAGSAK,
    FOM,
    TOM,
    INNTEKT,
    localtimestamp as LASTET_DATO
from final