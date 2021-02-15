
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

#max povprecna letna placa v vsaki regiji za vsako dejavnost
place.max <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MAX.LETNA.PLACA = max(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

#min povprecna letna placa v vsaki regiji za vsako dejavnost
place.min <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MIN.LETNA.PLACA = min(POVPRECNA.LETNA.PLACA, na.rm=TRUE)) %>%


#max povprecnih letnih plac posamezne regije
maxplace.gorenjska <- place.max %>% filter(STATISTICNA.REGIJA == 'Gorenjska') %>%
  arrange(MAX.LETNA.PLACA)  
  
maxplace.goriska <- place.max %>% filter(STATISTICNA.REGIJA == 'Goriška') %>%
  arrange(MAX.LETNA.PLACA)

#zemljevid regij

slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
tm_shape(slo) + tm_polygons("NAME_1")


#risanje
g1 <- ggplot(place.max) + aes(x=SKD.DEJAVNOST , y=MAX.LETNA.PLACA ) + geom_point()

g2 <- ggplot(place.gorenjska.max) + aes(x=substr(SKD.DEJAVNOST, 1, 1), y=MAX.LETNA.PLACA) + geom_col() +
  xlab("Dejavnost")








