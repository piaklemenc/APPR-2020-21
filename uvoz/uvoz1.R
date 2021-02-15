
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

#max povprecna letna placa v vsaki regiji za vsako dejavnost
place.max <- letne.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MAX.LETNA.PLACA = max(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

#min povprecna letna placa v vsaki regiji za vsako dejavnost
place.min <- letne.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MIN.LETNA.PLACA = min(POVPRECNA.LETNA.PLACA, na.rm=TRUE))


#max povprecnih letnih plac posamezne regije
maxplace.gorenjska <- place.max %>% filter(STATISTICNA.REGIJA == 'Gorenjska') %>%
  arrange(MAX.LETNA.PLACA)  
  
maxplace.goriska <- place.max %>% filter(STATISTICNA.REGIJA == 'Goriška') %>%
  arrange(MAX.LETNA.PLACA)

#zemljevid regij
place.regije$STATISTICNA.REGIJA[10] <- "Notranjsko-kraška"
place.regije$STATISTICNA.REGIJA[9] <- "Spodnjeposavska"

slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
slo1 <- tm_shape(merge(slo, place.regije,  by.x="NAME_1", by.y="STATISTICNA.REGIJA", label=paste0(NAME_1, "\n", POVPRECNA.PLACA))) + tm_polygons("POVPRECNA.PLACA") + 
  tm_text('NAME_1', size = 0.7)

#risanje
g1 <- ggplot(place.max) + aes(x=SKD.DEJAVNOST , y=MAX.LETNA.PLACA ) + geom_point()

g2 <- ggplot(maxplace.gorenjska) + aes(x=substr(SKD.DEJAVNOST, 1, 1), y=MAX.LETNA.PLACA) + geom_col() +
  xlab("Dejavnost")








