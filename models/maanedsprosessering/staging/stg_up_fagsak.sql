with fagsak as (
  select 
    FORSTE_SOKNADSDATO
    ,SAKSNUMMER
    ,PK_UP_FAGSAK
    ,VEDTAKSTIDSPUNKT
    ,programdeltakelse_fOM
    ,programdeltakelse_tom
    ,YTELSE_TYPE
    ,case when programdeltakelse_TOM=to_date('31.12.9999','DD.MM.YYYY') THEN add_months(programdeltakelse_fom,12)-1 
        else programdeltakelse_TOM 
    end programdeltakelse_TOM_NY 
    ,row_number() over (partiTIon by SAKSNUMMER order by VEDTAKSTIDSPUNKT DESC) rn
    from {{ source ('fam_ungdom', 'fam_up_fagsak') }}
)

select * 
from fagsak
--where vedtakstidspunkt<to_date('20260201','YYYYMMDD') 
where vedtakstidspunkt < to_date('{{ var ("max_dato") }}','YYYYMMDD') -- YYYYMMDD