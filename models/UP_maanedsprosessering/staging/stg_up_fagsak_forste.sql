with fagsak_forste as (
    select
        PK_UP_FAGSAK
        ,VEDTAKSTIDSPUNKT
        ,SAKSNUMMER
        ,row_number() over (
            partition by SAKSNUMMER
            order by VEDTAKSTIDSPUNKT
        ) as rn
        from {{ source ('fam_ungdom', 'fam_up_fagsak') }}
) 

select * 
from fagsak_forste
where RN=1