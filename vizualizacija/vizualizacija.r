# 3. faza: Vizualizacija podatkov


#zemljevid regij
place.regije$STATISTICNA.REGIJA[10] <- "Notranjsko-kraška"
place.regije$STATISTICNA.REGIJA[9] <- "Spodnjeposavska"

tmap_mode("view" )
slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
slo1 <- tm_shape(merge(slo, place.regije,  by.x="NAME_1", by.y="STATISTICNA.REGIJA")) + tm_polygons("POVPRECNA.PLACA") + 
  tm_text('NAME_1', size = 0.7)+ tm_view(text.size.variable = TRUE, view.legend.position = c("right", "bottom"))


#grafi

#katera panoga v regiji ima maksimalno povprecno letno placo
g1 <- ggplot(place.max) + aes(x=STATISTICNA.REGIJA, y=MAX.LETNA.PLACA,fill=SKD.DEJAVNOST) + geom_col() +
  xlab("Regija") + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1))

#katera panoga v regiji ima minimalno povprecno letno placo
g2 <- ggplot(place.min) + aes(x=STATISTICNA.REGIJA, y=MIN.LETNA.PLACA,fill=SKD.DEJAVNOST) + geom_col() +
  xlab("Regija") + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1))


#vsota povprečnih plač regij za vsako dejavnost - koliko vsaka regija 'prispeva' k neki dejavnosti - koliko je posamezna dejavnost razvita v vsaki regiji
#=g5
g3 <- ggplot(letne.place) + aes(x=substr(SKD.DEJAVNOST, 1,1) , y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA) +
  geom_col(col = 'black') +
  xlab("Dejavnost")

#višina plač v regijah za vsako panogo - koliko je vsaka od panog razvita v posamezni regiji SHINY
g41 <- ggplot(letne.place1) + aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=SKD.DEJAVNOST) +
  geom_col(position="dodge",col = 'black')+
  theme(legend.title=element_text(size=8), legend.text=element_text(size=7), legend.key.size = unit(0.5, 'cm'))
g42 <- ggplot(letne.place2) + aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=SKD.DEJAVNOST) +
  geom_col(position="dodge",col = 'black') +
  theme(legend.title=element_text(size=8), legend.text=element_text(size=7), legend.key.size = unit(0.5, 'cm'))


#grafi po panogah - v shiny-ju
g5 <- ggplot(data=letne.place, aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA)) +
  geom_col() + facet_wrap(~ substr(SKD.DEJAVNOST, 1,1)) +
  coord_flip() + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1), legend.position="none")

#grafi po regijah - v Shiny-ju
g6 <- ggplot(data=letne.place, aes(x=substr(SKD.DEJAVNOST,1,1), y=POVPRECNA.LETNA.PLACA, fill=substr(SKD.DEJAVNOST, 1,1))) +
  geom_col() + facet_wrap(~ STATISTICNA.REGIJA) + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1), legend.position="none") +
  xlab("PANOGA")



