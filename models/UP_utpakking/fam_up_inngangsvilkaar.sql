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
    select * 
    from {{ ref('fam_up_behandlingsperioder') }}
),

pre_final as (
    select *
    from up_meta_data
        ,json_table(melding, '$'
            columns (
                behandling_uuid          varchar2 path '$.behandlingUuid', -- for join
                nested path '$.behandlingsperioder[*]'
                columns (
                    FOM             varchar2 path '$.fom',
                    TOM             varchar2 path '$.tom',
                    nested path '$.inngangsvilkår[*]'
                    columns (
                        VILKAAR     varchar2 path '$.vilkår',
                        UTFALL      varchar2 path '$.utfall'
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
)

select
    DVH_FAM_UNGDOM.DVH_FAM_UP_SEQ.nextval as PK_UP_INNGANGSVILKAAR
    ,FK_UP_BEHANDLINGSPERIODE
    ,VILKAAR
    ,UTFALL
    ,localtimestamp as LASTET_DATO
from final