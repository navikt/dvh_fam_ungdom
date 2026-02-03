with fagsak_siste as (
  select 
    a.FORSTE_SOKNADSDATO
    ,a.SAKSNUMMER
    ,a.PK_UP_FAGSAK
    ,a.VEDTAKSTIDSPUNKT
    ,a.PROGRAMDELTAKELSE_FOM
    ,a.PROGRAMDELTAKELSE_TOM
    ,a.PROGRAMDELTAKELSE_TOM_NY
    ,a.RN 
    ,( SELECT MAX(TOM) FROM {{ source ('fam_ungdom', 'fam_up_behandlingsperioder') }}
        WHERE FK_UP_FAGSAK=a.PK_UP_FAGSAK
        AND UTFALL='OPPFYLT'
    ) BEHANDLINGSPERIODER_TOM_MAX
    from {{ ref ('stg_up_fagsak') }} a
)

select * 
from fagsak_siste
where rn = 1