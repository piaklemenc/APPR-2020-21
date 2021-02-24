
#uvoz podatkov
uvozi.place <- read_csv('podatki/place.csv', locale=locale(encoding="Windows-1250"),
                        na=c('n','z','-','/','-Inf', 'Inf'), skip=1,
                        col_names=c('STATISTICNA.REGIJA', 'SKD.DEJAVNOST',
                                    'MESEC', 'NETO.MESECNA.PLACA')) %>%
  mutate(MESEC=parse_date(MESEC, "%YM%m"))

#povprecna letna placa v vsaki regiji za vsako dejavnost
letne.place <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST, LETO=year(MESEC)) %>%
  summarise(LETNA.PLACA=sum(NETO.MESECNA.PLACA)) %>%
  summarize(POVPRECNA.LETNA.PLACA = mean(LETNA.PLACA, na.rm=TRUE))

#prva polovica regij
vrstice1 <- grep('(Gorenjska)|(Goriška)|(Jugovzhodna Slovenija)|(Koroška)|(Obalno-kraška)|(	Osrednjeslovenska)',
                 letne.place$STATISTICNA.REGIJA)                                                    
letne.place1 <- letne.place[vrstice1,]
#druga polovica regij
vrstice2 <- grep('(	Podravska)|(Pomurska)|(Posavska)|(Primorsko-notranjska)|(Savinjska)|(	Zasavska)',
                 letne.place$STATISTICNA.REGIJA)                                                    
letne.place2 <- letne.place[vrstice2,]



#povprečna plača v regiji
place.regije <- letne.place %>%
  group_by(STATISTICNA.REGIJA) %>%
  summarise(POVPRECNA.PLACA = mean(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

#max in min povprecna letna placa v vsaki regiji za vsako dejavnost
place.max <- letne.place %>%
  group_by(STATISTICNA.REGIJA) %>%
  summarize(MAX.LETNA.PLACA = max(POVPRECNA.LETNA.PLACA, na.rm=TRUE))
place.max$SKD.DEJAVNOST <- c('D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO', 
                             'D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO' ,
                             'D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO',
                             'D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO', 
                             'K FINANČNE IN ZAVAROVALNIŠKE DEJAVNOSTI', 
                             'D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO',
                             'D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO',
                             'K FINANČNE IN ZAVAROVALNIŠKE DEJAVNOSTI',
                             'D OSKRBA Z ELEKTRIČNO ENERGIJO, PLINOM IN PARO',
                             'K FINANČNE IN ZAVAROVALNIŠKE DEJAVNOSTI',
                             'B RUDARSTVO',
                             'B RUDARSTVO')



place.min <- letne.place %>%
  group_by(STATISTICNA.REGIJA) %>%
  summarize(MIN.LETNA.PLACA = min(POVPRECNA.LETNA.PLACA, na.rm=TRUE))
place.min$SKD.DEJAVNOST <- c('N DRUGE RAZNOVRSTNE POSLOVNE DEJAVNOSTI',
                             'N DRUGE RAZNOVRSTNE POSLOVNE DEJAVNOSTI',
                             'N DRUGE RAZNOVRSTNE POSLOVNE DEJAVNOSTI',
                             'I GOSTINSTVO',
                             'N DRUGE RAZNOVRSTNE POSLOVNE DEJAVNOSTI',
                             'I GOSTINSTVO',
                             'I GOSTINSTVO',
                             'I GOSTINSTVO',
                             'I GOSTINSTVO',
                             'I GOSTINSTVO',
                             'N DRUGE RAZNOVRSTNE POSLOVNE DEJAVNOSTI',
                             'A KMETIJSTVO IN LOV, GOZDARSTVO, RIBIŠTVO')

#povprečne mesečne plače v Sloveniji
mesecne.place.slo <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, MESEC) %>%
  summarise(POVPRECNA.MESECNA.PLACA.REGIJA = mean(NETO.MESECNA.PLACA, na.rm=TRUE)) %>%
  group_by(MESEC) %>%
  summarise(POVPRECNA.MESECNA.PLACA.SLO = mean(POVPRECNA.MESECNA.PLACA.REGIJA, na.rm=TRUE))












