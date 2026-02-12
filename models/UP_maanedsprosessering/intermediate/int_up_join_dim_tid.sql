with siste_dim_tid_dag as (
  select 
    SISTE.SAKSNUMMER 
    ,SISTE.PROGRAMDELTAKELSE_FOM
    ,SISTE.PROGRAMDELTAKELSE_TOM
    ,SISTE.PROGRAMDELTAKELSE_TOM_NY 
    ,SISTE.PK_UP_FAGSAK FK_UP_FAGSAK -- Husk å bruke disse aliasene videre
    ,SISTE.BEHANDLINGSPERIODER_TOM_MAX
    ,SISTE.YTELSE_TYPE

    ,DIM_TID_DAG.AAR_MAANED STAT_AARMND -- Husk å ta med ALLE kolonner for hver nye view
    ,TRUNC(DIM_TID_DAG.DATO,'mm') STAT_AARMND_DT
    ,COUNT(DISTINCT DIM_TID_DAG.DATO) ANTALL_DAGER
    ,MIN(DIM_TID_DAG.DATO) UTBET_FOM
    ,MAX(DIM_TID_DAG.DATO) UTBET_TOM
    ,DIM_TID_DAG.DATO -- Jeg la til selv, tror jeg trenger det for behandlingsperioder?
    ,DIM_TID_MND.SISTE_DATO_I_PERIODEN
    
    from {{ ref ('stg_up_fagsak_siste') }} SISTE
    join {{ ref ('stg_up_dim_tid') }} DIM_TID_DAG
    on DIM_TID_DAG.dim_nivaa=1 
    AND DIM_TID_DAG.DAG_I_UKE BETWEEN 1 AND 5 
    AND DIM_TID_DAG.DATO>=SISTE.PROGRAMDELTAKELSE_FOM 
    AND DIM_TID_DAG.DATO<= SISTE.BEHANDLINGSPERIODER_TOM_MAX 

    join {{ ref ('stg_up_dim_tid') }} DIM_TID_MND
    ON DIM_TID_DAG.AAR_MAANED=DIM_TID_MND.AAR_MAANED -- Må bruke aliasen på siste? 
    AND DIM_TID_MND.DIM_NIVAA=3 
    AND DIM_TID_MND.GYLDIG_FLAGG=1 

    WHERE DIM_TID_DAG.AAR_MAANED BETWEEN {{ var ( "periode_fra", "to_char(add_months(sysdate,-5),'YYYYMM')" )}} AND  {{  var ( "periode_til" , "to_char(add_months(sysdate,14),'YYYYMM')" )}} --TODO fjern

 group by
    SISTE.SAKSNUMMER 
    ,SISTE.PROGRAMDELTAKELSE_FOM
    ,SISTE.PROGRAMDELTAKELSE_TOM
    ,SISTE.PROGRAMDELTAKELSE_TOM_NY 
    ,SISTE.PK_UP_FAGSAK 
    ,SISTE.YTELSE_TYPE
    ,SISTE.BEHANDLINGSPERIODER_TOM_MAX
    ,DIM_TID_DAG.AAR_MAANED -- Bruk kildekolonnen, ikke alias
    ,trunc(DIM_TID_DAG.DATO,'mm') 
    ,DIM_TID_DAG.DATO 
    ,DIM_TID_MND.SISTE_DATO_I_PERIODEN
)

select * 
from siste_dim_tid_dag

