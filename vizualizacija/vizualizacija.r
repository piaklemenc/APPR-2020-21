# 3. faza: Vizualizacija podatkov


#zemljevid regij
place.regije$STATISTICNA.REGIJA[10] <- "Notranjsko-kraška"
place.regije$STATISTICNA.REGIJA[9] <- "Spodnjeposavska"


tmap_mode("view" )
slo1 <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
slo <- tm_shape(merge(slo1, place.regije,  by.x="NAME_1", by.y="STATISTICNA.REGIJA")) + tm_polygons("POVPRECNA.PLACA", title = "Povprečna plača (€)") + 
  tm_text('NAME_1', size = 0.8)+ tm_view(text.size.variable = TRUE, view.legend.position = c("right", "bottom")) +
  tm_layout(title="Povprečna letna plača v vsaki regiji")



#grafi

#katera panoga v regiji ima maksimalno povprecno letno placo
max.place.v.regiji <- ggplot(place.max) + aes(x=STATISTICNA.REGIJA, y=MAX.LETNA.PLACA,fill=SKD.DEJAVNOST) + geom_col() +
  xlab("Regija") + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle('Maksimalne plače v regijah') +
  ylab('Plača (€)')+
  theme(legend.title=element_text(size=8), legend.text=element_text(size=7), legend.key.size = unit(0.5, 'cm')) +
  scale_fill_discrete(name = "Panoga")
                    

#katera panoga v regiji ima minimalno povprecno letno placo
min.place.v.regiji <- ggplot(place.min) + aes(x=STATISTICNA.REGIJA, y=MIN.LETNA.PLACA,fill=SKD.DEJAVNOST) + geom_col() +
  xlab("Regija") + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1)) +
  ggtitle('Minimalne plače v regijah') +
  ylab('Plača (€)')+
  theme(legend.title=element_text(size=8), legend.text=element_text(size=7), legend.key.size = unit(0.5, 'cm'))+
  scale_fill_discrete(name = "Panoga")


#vsota povprečnih plač regij za vsako dejavnost - koliko vsaka regija 'prispeva' k neki dejavnosti 
g3 <- ggplot(letne.place) + aes(x=substr(SKD.DEJAVNOST, 1,1) , y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA) +
  geom_col(col = 'black') +
  xlab("Dejavnost") +
  ylab('Plače (€)') +
  scale_fill_discrete(name = "Regija") +
  ggtitle('Vsota plač po regijah za posamezno dejavnost')

#višina plač v regijah za vsako panogo - koliko je vsaka od panog razvita v posamezni regiji - v shiny-ju
g41 <- ggplot(letne.place1) + aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=SKD.DEJAVNOST) +
  geom_col(position="dodge",col = 'black')+
  theme(legend.title=element_text(size=8), legend.text=element_text(size=7), legend.key.size = unit(0.5, 'cm'))+
  xlab('Regija') + ylab('Plača') + scale_fill_discrete(name = "Panoga")

g42 <- ggplot(letne.place2) + aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=SKD.DEJAVNOST) +
  geom_col(position="dodge",col = 'black') +
  theme(legend.title=element_text(size=8), legend.text=element_text(size=7), legend.key.size = unit(0.5, 'cm'))+
  xlab('Regija') + ylab('Plača')+ scale_fill_discrete(name = "Panoga")


#grafi po panogah - v shiny-ju
g5 <- ggplot(data=letne.place, aes(x=STATISTICNA.REGIJA, y=POVPRECNA.LETNA.PLACA, fill=STATISTICNA.REGIJA)) +
  geom_col() + facet_wrap(~ substr(SKD.DEJAVNOST, 1,1)) +
  coord_flip() + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1), legend.position="none")

#grafi po regijah - v shiny-ju
g6 <- ggplot(data=letne.place, aes(x=substr(SKD.DEJAVNOST,1,1), y=POVPRECNA.LETNA.PLACA, fill=substr(SKD.DEJAVNOST, 1,1))) +
  geom_col() + facet_wrap(~ STATISTICNA.REGIJA) + theme(axis.text.x = element_text(size = 6, angle = 90, vjust = 0.5, hjust=1), legend.position="none") +
  xlab("PANOGA")



