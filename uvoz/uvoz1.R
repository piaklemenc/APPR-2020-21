
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

#povprečna plača v regiji
place.regije <- letne.place %>%
  group_by(STATISTICNA.REGIJA) %>%
  summarise(POVPRECNA.PLACA = mean(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

#max in min povprecna letna placa v vsaki regiji za vsako dejavnost
place.max <- letne.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MAX.LETNA.PLACA = max(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

place.min <- letne.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MIN.LETNA.PLACA = min(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

maxmin.place <- inner_join(place.max, place.min)


#place na gorenjskem
maxplace.gorenjska <- place.max %>% filter(STATISTICNA.REGIJA == 'Gorenjska') %>%
  arrange(MAX.LETNA.PLACA)  
  
place.gorenjska <- uvozi.place %>%filter(STATISTICNA.REGIJA == 'Gorenjska')







