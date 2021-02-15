
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


#place na gorenjskem
maxplace.gorenjska <- place.max %>% filter(STATISTICNA.REGIJA == 'Gorenjska') %>%
  arrange(MAX.LETNA.PLACA)  
  
place.gorenjska <- uvozi.place %>%filter(STATISTICNA.REGIJA == 'Gorenjska')

#zemljevid regij
place.regije$STATISTICNA.REGIJA[10] <- "Notranjsko-kraška"
place.regije$STATISTICNA.REGIJA[9] <- "Spodnjeposavska"

slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
slo1 <- tm_shape(merge(slo, place.regije,  by.x="NAME_1", by.y="STATISTICNA.REGIJA", label=paste0(NAME_1, "\n", POVPRECNA.PLACA))) + tm_polygons("POVPRECNA.PLACA") + 
  tm_text('NAME_1', size = 0.7)

#risanje
g1 <- ggplot(place.max) + aes(x=substr(SKD.DEJAVNOST, 1, 1), y=MAX.LETNA.PLACA,fill="red") + geom_col() +
  xlab("Dejavnost")
  

g2 <- ggplot(maxplace.gorenjska) + aes(x=substr(SKD.DEJAVNOST, 1, 1), y=MAX.LETNA.PLACA) + geom_col() +
  xlab("Dejavnost")

#vsota povprečnih plač regij za vsako dejavnost
g3 <- ggplot(letne.place) + aes(x=substr(SKD.DEJAVNOST, 1,1) , y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA) +
  geom_col(col = 'black') +
  xlab("Dejavnost")

#višina plač v regijah za vsako panogo
g4 <- ggplot(letne.place) + aes(x=substr(SKD.DEJAVNOST, 1,1), y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA) +
  geom_col(position="dodge",col = 'black')

#grafi po panogah
g5 <- ggplot(data=letne.place, aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA)) +
  geom_col() + facet_wrap(~ substr(SKD.DEJAVNOST, 1,1)) +
  coord_flip() + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1), legend.position="none")

#grafi po regijah
g6 <- ggplot(data=letne.place, aes(x=substr(SKD.DEJAVNOST,1,1), y=POVPRECNA.LETNA.PLACA, fill=substr(SKD.DEJAVNOST, 1,1))) +
  geom_col() + facet_wrap(~ STATISTICNA.REGIJA) +
  coord_flip() + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1), legend.position="none") +
  xlab("PANOGA")
 
#grafi plač na gorenjskem za posamezno panogo
#g7 <- ggplot(data=place.gorenjska, aes(x=MESEC, y=NETO.MESECNA.PLACA, fill=MESEC)) +
 # geom_col() + facet_wrap(~ SKD.DEJAVNOST) + 
  #theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1),legend.position="none" ) +
  #xlab("LETO") + ylab("NETO PLAČA")

#grafi plač na gorenjskem za posamezno panogo
g7 <- ggplot(data=place.gorenjska, aes(x=MESEC, y=NETO.MESECNA.PLACA, col=SKD.DEJAVNOST)) +
  geom_line() + facet_wrap(~SKD.DEJAVNOST) +
  theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1),legend.position="none" ) +
  xlab("LETO") + ylab("NETO PLAČA")








