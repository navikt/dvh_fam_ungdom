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

up_behandlingsperiode as (
    select * from {{ ref('fam_up_behandlingsperioder') }}
),

pre_final as (
    select
        j.behandling_uuid,
        to_date(j.FOM, 'YYYY-MM-DD') as FOM_DATO,
        to_date(j.TOM, 'YYYY-MM-DD') as TOM_DATO,
        j.VILKAAR,
        j.UTFALL
    from up_meta_data
    , json_table(melding, '$'
        columns (
            behandling_uuid         varchar2 path '$.behandlingUuid',
            nested path '$.behandlingsperioder[*]'
            columns (
                FOM                 varchar2 path '$.fom',
                TOM                 varchar2 path '$.tom',
                nested path '$.inngangsvilkår[*]'
                columns (
                    VILKAAR         varchar2 path '$.vilkår',
                    UTFALL          varchar2 path '$.utfall'
                )
            )
        )
    ) j
    where VILKAAR is not null
),

final as (
    select
        up_behandlingsperiode.pk_up_behandlingsperiode as FK_UP_BEHANDLINGSPERIODE,
        pre_final.VILKAAR as VILKAAR,
        pre_final.UTFALL  as UTFALL
    from pre_final
    join up_fagsak
      on pre_final.behandling_uuid  = up_fagsak.behandling_uuid
    join up_behandlingsperiode
      on up_behandlingsperiode.fk_up_fagsak = up_fagsak.pk_up_fagsak
     and trunc(up_behandlingsperiode.FOM) = trunc(pre_final.FOM_DATO)
     and trunc(up_behandlingsperiode.TOM) = trunc(pre_final.TOM_DATO)
)

select
    DVH_FAM_UNGDOM.DVH_FAM_UP_SEQ.nextval as PK_UP_INNGANGSVILKAAR
    ,FK_UP_BEHANDLINGSPERIODE
    ,VILKAAR
    ,UTFALL
    ,localtimestamp as LASTET_DATO
from final