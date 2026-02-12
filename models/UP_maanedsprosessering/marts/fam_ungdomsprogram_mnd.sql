{{
  config(
    materialized='incremental',
    unique_key = ['STAT_AARMND', 'gyldig_flagg'],
    incremental_strategy='delete+insert'
  ) 
}}

with fact as (
    select 
        SISTE.SAKSNUMMER 
        ,SISTE.PROGRAMDELTAKELSE_FOM
        ,SISTE.PROGRAMDELTAKELSE_TOM
        ,SISTE.PROGRAMDELTAKELSE_TOM_NY 
        ,SISTE.FK_UP_FAGSAK 
        ,SISTE.BEHANDLINGSPERIODER_TOM_MAX
        ,SISTE.STAT_AARMND 
        ,SISTE.STAT_AARMND_DT
        ,SISTE.ANTALL_DAGER
        ,SISTE.UTBET_FOM
        ,SISTE.UTBET_TOM
        --,SISTE.DATO
        ,SISTE.SISTE_DATO_I_PERIODEN
        ,SISTE.UTFALL
        ,SISTE.ANTALL_BARN
        ,SISTE.SATSPERIODE_FOM
        ,SISTE.SATSPERIODE_TOM
        ,SISTE.dagsats_barnetillegg
        ,SISTE.DAGSATS_UTEN_BARNETILLEGG
        ,SISTE.FK_PERSON1_MOTTAKER
        ,SISTE.VEDTAKSTIDSPUNKT
        --,SISTE.DAGSATS_TEMP
        ,SISTE.BUDSJETT
        ,SISTE.REDUKSJON
        ,SISTE.BELOP
        ,SISTE.DAGSATS
        ,SISTE.FK_DIM_PERSON_MOTTAKER
        ,SISTE.FK_DIM_GEOGRAFI_BOSTED
        ,SISTE.BOSTED_KOMMUNE_NR
        ,SISTE.BOSTED_LAND
        ,SISTE.Alder
        ,CASE
          WHEN SISTE.Alder < 25 THEN 'LAV' 
          Else 'HØY'
          END SATS_TYPE_KALK
        ,SISTE.FYLKE_NR
        ,SISTE.FYLKE_NAVN
        ,SISTE.INNTEKT
        ,SISTE.YTELSE_TYPE
        ,SISTE.SATS_TYPE
        ,SISTE.FK_DIM_ALDER
        ,{{ var("gyldig_flagg") }} GYLDIG_FLAGG
        ,TO_DATE('{{ var("max_vedtaksdato") }}', 'yyyymmdd') MAX_VEDTAKSDATO
        ,'{{ var("periode_type") }}' PERIODE_TYPE
        ,localtimestamp AS lastet_dato
    from {{ ref('int_up_join_inntekt') }} SISTE
)

select
    dvh_fam_ungdom.dvh_fam_up_seq.nextval as PK_FAK_UNGDOMSPROGRAM_MND
    ,SAKSNUMMER 
    ,PROGRAMDELTAKELSE_FOM
    ,PROGRAMDELTAKELSE_TOM
    ,PROGRAMDELTAKELSE_TOM_NY PROGRAMDELTAKELSE_TOM_KALK
    ,FK_UP_FAGSAK 
    ,BEHANDLINGSPERIODER_TOM_MAX
    ,STAT_AARMND 
    ,STAT_AARMND_DT
    ,ANTALL_DAGER
    ,UTBET_FOM
    ,UTBET_TOM
    --,DATO
    ,SISTE_DATO_I_PERIODEN
    ,UTFALL
    ,ANTALL_BARN
    ,SATSPERIODE_FOM
    ,SATSPERIODE_TOM
    ,dagsats_barnetillegg
    ,DAGSATS_UTEN_BARNETILLEGG
    ,FK_PERSON1_MOTTAKER
    ,VEDTAKSTIDSPUNKT
    --,DAGSATS_TEMP
    ,BUDSJETT
    ,REDUKSJON
    ,BELOP
    ,FK_DIM_ALDER
    ,'UP_VEDTAK' KILDESYSTEM
    ,YTELSE_TYPE
    ,DAGSATS
    ,FK_DIM_PERSON_MOTTAKER
    ,FK_DIM_GEOGRAFI_BOSTED
    ,BOSTED_KOMMUNE_NR
    ,BOSTED_LAND
    ,Alder
    ,SATS_TYPE_KALK
    ,FYLKE_NR
    ,FYLKE_NAVN
    ,INNTEKT
    ,SATS_TYPE
    ,GYLDIG_FLAGG
    ,max_vedtaksdato
    ,PERIODE_TYPE
    ,lastet_dato
from fact
