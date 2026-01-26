--FAM_UP_META_DATA
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."PK_UP_META_DATA"                 IS '#NAVN PK_UP_META_DATA           #INNHOLD Primærnøkkel for metadata';
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."KAFKA_MOTTATT_DATO"              IS '#NAVN KAFKA_MOTTATT_DATO        #INNHOLD Dato og tid meldingen ble mottatt fra Kafka';
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."KAFKA_PARTITION"                 IS '#NAVN KAFKA_PARTITION           #INNHOLD Kafka-partisjon meldingen ble hentet fra';
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."KAFKA_TOPIC"                     IS '#NAVN KAFKA_TOPIC               #INNHOLD Kafka-topic meldingen tilhører';
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."MELDING"                         IS '#NAVN MELDING                   #INNHOLD Selve meldingsinnholdet fra Kafka';
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."KAFKA_OFFSET"                    IS '#NAVN KAFKA_OFFSET              #INNHOLD Offset i Kafka for meldingen';
COMMENT ON COLUMN "DVH_FAM_UNGDOM"."FAM_UP_META_DATA"."LASTET_DATO"                     IS '#NAVN LASTET_DATO               #INNHOLD Dato meldingen ble lastet inn i datavarehuset';

--UP_MELDINGER_TIL_AA_PAKKE_UT
COMMENT ON COLUMN DVH_FAM_UNGDOM.UP_MELDINGER_TIL_AA_PAKKE_UT.PK_UP_META_DATA           IS '#NAVN PK_UP_META_DATA           #INNHOLD Primærnøkkel fra metadata knyttet til meldingen';
COMMENT ON COLUMN DVH_FAM_UNGDOM.UP_MELDINGER_TIL_AA_PAKKE_UT.KAFKA_OFFSET              IS '#NAVN KAFKA_OFFSET              #INNHOLD Offset i Kafka for meldingen';
COMMENT ON COLUMN DVH_FAM_UNGDOM.UP_MELDINGER_TIL_AA_PAKKE_UT.KAFKA_MOTTATT_DATO        IS '#NAVN KAFKA_MOTTATT_DATO        #INNHOLD Dato og tid meldingen ble mottatt fra Kafka';
COMMENT ON COLUMN DVH_FAM_UNGDOM.UP_MELDINGER_TIL_AA_PAKKE_UT.KAFKA_TOPIC               IS '#NAVN KAFKA_TOPIC               #INNHOLD Kafka-topic meldingen ble hentet fra';
COMMENT ON COLUMN DVH_FAM_UNGDOM.UP_MELDINGER_TIL_AA_PAKKE_UT.KAFKA_PARTITION           IS '#NAVN KAFKA_PARTITION           #INNHOLD Kafka-partisjon meldingen ble hentet fra';
COMMENT ON COLUMN DVH_FAM_UNGDOM.UP_MELDINGER_TIL_AA_PAKKE_UT.MELDING                   IS '#NAVN MELDING                   #INNHOLD Selve meldingsinnholdet som må pakkes ut';

--FAM_UP_FAGSAK
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.PK_UP_FAGSAK                          IS '#NAVN PK_UP_FAGSAK              #INNHOLD Primærnøkkel for fagsak';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.FK_UP_META_DATA                       IS '#NAVN FK_UP_META_DATA           #INNHOLD Fremmednøkkel til metadata-tabellen';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.FK_PERSON1                            IS '#NAVN FK_PERSON1                #INNHOLD Datavarehusets identifikator for person (mottaker/deltaker)';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.FORSTE_SOKNADSDATO                    IS '#NAVN FORSTE_SOKNADSDATO        #INNHOLD Dato for første søknad knyttet til fagsaken';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.VEDTAKSTIDSPUNKT                      IS '#NAVN VEDTAKSTIDSPUNKT #        INNHOLD Tidspunkt for vedtak i saken';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.PROGRAMDELTAKELSE_FOM                 IS '#NAVN PROGRAMDELTAKELSE_FOM     #INNHOLD Startdato for deltakelse i ungdomsprogrammet (FOM)';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.PROGRAMDELTAKELSE_TOM                 IS '#NAVN PROGRAMDELTAKELSE_TOM     #INNHOLD Sluttdato for deltakelse i ungdomsprogrammet (TOM)';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.LASTET_DATO                           IS '#NAVN LASTET_DATO               #INNHOLD Dato raden ble lastet til datavarehus';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.YTELSE_TYPE                           IS '#NAVN YTELSE_TYPE               #INNHOLD Type ytelse knyttet til fagsaken';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.SAKSNUMMER                            IS '#NAVN SAKSNUMMER                #INNHOLD Saksnummer fra fagsystemet';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.BEHANDLING_UUID                       IS '#NAVN BEHANDLING_UUID           #INNHOLD Unik identifikator (UUID) for behandlingen';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.FORRIGE_BEHANDLING_UUID               IS '#NAVN FORRIGE_BEHANDLING_UUID   #INNHOLD Unik identifikator (UUID) for forrige behandling i saken';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_META_DATA.UTBETALINGSREFERANSE                  IS '#NAVN UTBETALINGSREFERANSE      #INNHOLD Referanse til utbetaling/oppgjør knyttet til saken';

--FAM_UP_BEHANDLINGSPERIODER
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_BEHANDLINGSPERIODER.PK_UP_BEHANDLINGSPERIODE    IS '#NAVN PK_UP_BEHANDLINGSPERIODE  #INNHOLD Primærnøkkel for behandlingsperioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_BEHANDLINGSPERIODER.FK_UP_FAGSAK                IS '#NAVN FK_UP_FAGSAK              #INNHOLD Fremmednøkkel til fagsak i ungdomsprogrammet';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_BEHANDLINGSPERIODER.FOM                         IS '#NAVN FOM                       #INNHOLD Startdato (fra og med) for behandlingsperioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_BEHANDLINGSPERIODER.TOM                         IS '#NAVN TOM                       #INNHOLD Sluttdato (til og med) for behandlingsperioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_BEHANDLINGSPERIODER.LASTET_DATO                 IS '#NAVN LASTET_DATO               #INNHOLD Dato raden ble lastet inn i datavarehuset';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_BEHANDLINGSPERIODER.UTFALL                      IS '#NAVN UTFALL                    #INNHOLD Utfallet av behandlingen (f.eks. innvilget, avslag)';

--FAM_UP_INNGANGSVILKAAR
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_INNGANGSVILKAAR.PK_UP_INNGANGSVILKAAR           IS '#NAVN PK_UP_INNGANGSVILKAAR     #INNHOLD Primærnøkkel for inngangsvilkår';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_INNGANGSVILKAAR.FK_UP_BEHANDLINGSPERIODE        IS '#NAVN FK_UP_BEHANDLINGSPERIODE  #INNHOLD Fremmednøkkel til behandlingsperiode';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_INNGANGSVILKAAR.LASTET_DATO                     IS '#NAVN LASTET_DATO               #INNHOLD Dato raden ble lastet inn i datavarehuset';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_INNGANGSVILKAAR.VILKAAR                         IS '#NAVN VILKAAR                   #INNHOLD Navn/type inngangsvilkår som er vurdert';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_INNGANGSVILKAAR.UTFALL                          IS '#NAVN UTFALL                    #INNHOLD Utfallet av vurderingen av inngangsvilkåret';

--
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.PK_UP_SATSPERIODE                  IS '#NAVN PK_UP_SATSPERIODE         #INNHOLD Primærnøkkel for satsperioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.FK_UP_FAGSAK                       IS '#NAVN FK_UP_FAGSAK              #INNHOLD Fremmednøkkel til fagsak i ungdomsprogrammet';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.FOM                                IS '#NAVN FOM                       #INNHOLD Startdato (fra og med) for satsperioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.TOM                                IS '#NAVN TOM                       #INNHOLD Sluttdato (til og med) for satsperioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.ANTALL_BARN                        IS '#NAVN ANTALL_BARN               #INNHOLD Antall barn som inngår i beregningen for satsen';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.DAGSATS_BARNETILLEGG               IS '#NAVN DAGSATS_BARNETILLEGG      #INNHOLD Dagsats for barnetillegg i perioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.GRUNNBELOP_FAKTOR                  IS '#NAVN GRUNNBELOP_FAKTOR         #INNHOLD Faktor av grunnbeløpet brukt i beregningen';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.LASTET_DATO                        IS '#NAVN LASTET_DATO               #INNHOLD Dato raden ble lastet til datavarehuset';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.DAGSATS_UTEN_BARNETILLEGG          IS '#NAVN DAGSATS_UTEN_BARNETILLEGG #INNHOLD Dagsats uten barnetillegg i perioden';
COMMENT ON COLUMN DVH_FAM_UNGDOM.FAM_UP_SATSPERIODER.SATS_TYPE                          IS '#NAVN SATS_TYPE                 #INNHOLD Type sats som gjelder for perioden';


--


--


--


