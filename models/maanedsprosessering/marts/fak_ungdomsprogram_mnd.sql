{{
  config(
      materialized = 'view',
      alias = 'fak_ungdomsprogram_mnd'
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
        ,SISTE.DATO
        ,SISTE.SISTE_DATO_I_PERIODEN
        ,SISTE.UTFALL
        ,SISTE.ANTALL_BARN
        ,SISTE.SATSPERIODE_FOM
        ,SISTE.SATSPERIODE_TOM
        ,SISTE.dagsats_barnetillegg
        ,SISTE.DAGSATS_UTEN_BARNETILLEGG
        ,SISTE.FK_PERSON1_MOTTAKER
        ,SISTE.VEDTAKSTIDSPUNKT
        ,SISTE.DAGSATS_TEMP
        ,SISTE.BUDSJETT
        ,SISTE.REDUKSJON
        ,SISTE.BELOP
        ,SISTE.DAGSATS
        ,SISTE.FK_DIM_PERSON_MOTTAKER
        ,SISTE.FK_DIM_GEOGRAFI_BOSTED
        ,SISTE.BOSTED_KOMMUNE_NR
        ,SISTE.BOSTED_LAND
        ,SISTE.Alder
        ,SISTE.FYLKE_NR
        ,SISTE.FYLKE_NAVN
        ,SISTE.INNTEKT
        --current_date as last_updated
    from {{ ref('int_up_join_inntekt') }} SISTE
)

select *
from fact