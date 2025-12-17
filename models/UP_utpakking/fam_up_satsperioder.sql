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
                behandling_uuid                  varchar2 path '$.behandlingUuid',
                nested path '$.satsPerioder[*]'
                columns (
                    FOM                     varchar2 path '$.fom',
                    TOM                     varchar2 path '$.tom',
                    SATS_TYPE               varchar2 path '$.satsType',
                    ANTALL_BARN             varchar2 path '$.antallBarn',
                    DAGSATS_BARNETILLEGG    varchar2 path '$.dagsatsBarnetillegg',
                    GRUNNBELOP_FAKTOR       varchar2 path '$.grunnbeløpFaktor'
                )
            )
        ) j
    where FOM is not null
),

final as (
    select
        to_date(FOM,'yyyy-mm-dd')           as FOM,
        to_date(TOM,'yyyy-mm-dd')           as TOM,
        SATS_TYPE,
        ANTALL_BARN,
        DAGSATS_BARNETILLEGG,
        GRUNNBELOP_FAKTOR,
        up_fagsak.pk_up_fagsak              as FK_UP_FAGSAK
    from pre_final
    join up_fagsak
      on pre_final.behandling_uuid  = up_fagsak.behandling_uuid
)

select
    DVH_FAM_UNGDOM.DVH_FAM_UP_SEQ.nextval as PK_UP_SATSPERIODE
    ,FK_UP_FAGSAK
    ,FOM
    ,TOM
    ,SATS_TYPE
    ,ANTALL_BARN
    ,DAGSATS_BARNETILLEGG
    ,GRUNNBELOP_FAKTOR
    ,localtimestamp as LASTET_DATO
from final