library(dplyr)
library(DT)
library(digest)
library(ggplot2)
library(knitr)
library(maptools)
library(mosaic)
library(nlme)
library(rgeos)
library(rgdal)
library(rmarkdown)
library(readr)
library(stringr)
library(shiny)
library(tidyr)
library(tibble)
library(tmap)



uvozi.place <- read_csv('podatki/place.csv', locale=locale(encoding="Windows-1250"), na=c('n','z','-','/','-Inf', 'Inf')) %>%
  separate(MESEC,  into = c('leto', 'mesec'), sep = 'M')

colnames(uvozi.place) = c('STATISTICNA.REGIJA', 'SKD.DEJAVNOST', 'LETO', 'MESEC', 'NETO.MESECNA.PLACA')
uvozi.place$LETO <- as.integer(uvozi.place$LETO)
uvozi.place$NETO.MESECNA.PLACA <- as.numeric(uvozi.place$NETO.MESECNA.PLACA)


#povprecna letna placa v vsaki regiji za vsako dejavnost
uvozi.place <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST, LETO) %>%
  summarize(POVPRECNA.LETNA.PLACA = mean(NETO.MESECNA.PLACA, na.rm=TRUE))

#max povprecna letna placa v vsaki regiji za vsako dejavnost
place.max <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MAX.LETNA.PLACA = max(POVPRECNA.LETNA.PLACA, na.rm=TRUE))

#min povprecna letna placa v vsaki regiji za vsako dejavnost
place.min <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MIN.LETNA.PLACA = min(POVPRECNA.LETNA.PLACA, na.rm=TRUE)) %>%


#max povprecnih letnih plac posamezne regije
place.gorenjska.max <- place.max %>% filter(STATISTICNA.REGIJA == 'Gorenjska') %>%
  arrange(MAX.LETNA.PLACA)  
  
place.goriska.max <- place.max %>% filter(STATISTICNA.REGIJA == 'Goriška') %>%
  arrange(MAX.LETNA.PLACA)

#zemljevid regij
source("https://raw.githubusercontent.com/jaanos/APPR-2020-21/master/lib/uvozi.zemljevid.r")
slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
tm_shape(slo) + tm_polygons("NAME_1")


#risanje
g1 <- ggplot(place.max) + aes(x=SKD.DEJAVNOST , y=MAX.LETNA.PLACA ) + geom_point()

g2 <- ggplot(place.gorenjska.max) + aes(x=SKD.DEJAVNOST, y=MAX.LETNA.PLACA) + geom_point()








