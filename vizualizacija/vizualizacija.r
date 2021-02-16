# 3. faza: Vizualizacija podatkov

# Uvozimo zemljevid.
zemljevid <- uvozi.zemljevid("http://baza.fmf.uni-lj.si/OB.zip", "OB",
                             pot.zemljevida="OB", encoding="Windows-1250")
# Če zemljevid nima nastavljene projekcije, jo ročno določimo
proj4string(zemljevid) <- CRS("+proj=utm +zone=10+datum=WGS84")

levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
  { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(obcine$obcina))

# Izračunamo povprečno velikost družine
povprecja <- druzine %>% group_by(obcina) %>%
  summarise(povprecje=sum(velikost.druzine * stevilo.druzin) / sum(stevilo.druzin))


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
