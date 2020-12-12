library(dplyr)
library(tidyr)
library(readr)
library(tibble)
library(ggplot2)
library(tibble)
library(tmap)
library(maptools)
library(rgeos)
library(rgdal)
library(tibble)
library(stringr)
library(tmap)
library(knitr)
library(rmarkdown)
library(shiny)
library(DT)
library(digest)
library(mosaic)

uvozi.place <- read_csv('podatki/place.csv', locale=locale(encoding="Windows-1250"), na=c('n','z','-','/','-Inf')) %>%
  separate(MESEC,  into = c('leto', 'mesec'), sep = 'M')
  
colnames(uvozi.place) = c('STATISTICNA.REGIJA', 'SKD.DEJAVNOST', 'LETO', 'MESEC', 'NETO.MESECNA.PLACA')

uvozi.place <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST, LETO) %>%
  summarize(POVPRECNA.LETNA.PLACA = mean(NETO.MESECNA.PLACA, na.rm=TRUE))

uvozi.place2 <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST) %>%
  summarize(MAX.LETNA.PLACA = max(POVPRECNA.LETNA.PLACA, na.rm=TRUE)) 


source("https://raw.githubusercontent.com/jaanos/APPR-2020-21/master/lib/uvozi.zemljevid.r")
slo <- uvozi.zemljevid("https://biogeo.ucdavis.edu/data/gadm3.6/shp/gadm36_SVN_shp.zip", "gadm36_SVN_1", encoding="UTF-8")
tm_shape(slo) + tm_polygons("NAME_1")

















