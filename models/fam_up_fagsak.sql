{{ 
    config(
        materialized='incremental'
    ) 
}}

with up_meta_data as (
    select * from {{ref ('up_meldinger_til_aa_pakke_ut') }}
),

pre_final as (
    select * from up_meta_data,
       json_table(melding, '$'
        columns (
            YTELSE_TYPE                 varchar2 path '$.ytelseType',
            SOKER_AKTOR_ID              varchar2 path '$.søkerAktørId',
            SAKSNUMMER                  varchar2 path '$.saksnummer',
            BEHANDLING_UUID             varchar2 path '$.behandlingUuid',
            FORRIGE_BEHANDLING_UUID     varchar2 path '$.forrigeBehandlingUuid',
            FORSTE_SOKNADSDATO          varchar2 path '$.førsteSøknadsdato',
            VEDTAKSTIDSPUNKT            varchar2 path '$.vedtakstidspunkt',
            UTBETALINGSREFERANSE        varchar2 path '$.utbetalingsreferanse',
            PROGRAMDELTAKELSE_FOM       varchar2 path '$.ungdomsprogramDeltakelsePeriode.programdeltakelseFom',
            PROGRAMDELTAKELSE_TOM       varchar2 path '$.ungdomsprogramDeltakelsePeriode.programdeltakelseTom'
        )
    ) j
),
--select * from pre_final

final as (
    select
        p.YTELSE_TYPE,
        p.SOKER_AKTOR_ID,
        p.SAKSNUMMER,
        p.BEHANDLING_UUID,
        p.FORRIGE_BEHANDLING_UUID,
        to_date(p.FORSTE_SOKNADSDATO,'yyyy-mm-dd') as FORSTE_SOKNADSDATO,
        case
            when length(p.VEDTAKSTIDSPUNKT) = 25 then
                cast(to_timestamp_tz(p.VEDTAKSTIDSPUNKT, 'yyyy-mm-dd"T"hh24:mi:ss TZH:TZM') at time zone 'Europe/Oslo' as timestamp)
            else
                cast(to_timestamp_tz(p.VEDTAKSTIDSPUNKT, 'FXYYYY-MM-DD"T"HH24:MI:SS.FXFFTZH:TZM') at time zone 'Europe/Oslo' as timestamp)
        end as VEDTAKSTIDSPUNKT,
        to_date(p.PROGRAMDELTAKELSE_FOM,'yyyy-mm-dd') as PROGRAMDELTAKELSE_FOM,
        to_date(p.PROGRAMDELTAKELSE_TOM,'yyyy-mm-dd') as PROGRAMDELTAKELSE_TOM,
        p.UTBETALINGSREFERANSE,
        nvl(ident.fk_person1, -1) as FK_PERSON1,
        p.PK_UP_META_DATA as FK_UP_META_DATA,
        p.KAFKA_OFFSET,
        p.KAFKA_TOPIC,
        p.KAFKA_PARTITION
    from pre_final p
    left join dt_person.ident_aktor_til_fk_person1_ikke_skjermet ident
      on p.SOKER_AKTOR_ID = ident.off_id
     and p.KAFKA_MOTTATT_DATO between ident.gyldig_fra_dato and ident.gyldig_til_dato
     and ident.skjermet_kode = 0
)

select
    DVH_FAM_UNGDOM.dvh_fam_up_seq.nextval as PK_UP_FAGSAK,
    FK_UP_META_DATA,
    FK_PERSON1,
    YTELSE_TYPE,
    SAKSNUMMER,
    BEHANDLING_UUID,
    FORRIGE_BEHANDLING_UUID,
    FORSTE_SOKNADSDATO,
    VEDTAKSTIDSPUNKT,
    UTBETALINGSREFERANSE,
    PROGRAMDELTAKELSE_FOM,
    PROGRAMDELTAKELSE_TOM,
    KAFKA_TOPIC,
    KAFKA_OFFSET,
    KAFKA_PARTITION,
    localtimestamp as LASTET_DATO
from final