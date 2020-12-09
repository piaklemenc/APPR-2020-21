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

uvozi.place <- read_csv('podatki/place.csv', locale=locale(encoding="Windows-1250"), na=c('n','z','-','/')) %>%
  separate(MESEC,  into = c('leto', 'mesec'), sep = 'M')
  
colnames(uvozi.place) = c('STATISTICNA.REGIJA', 'SKD.DEJAVNOST', 'LETO', 'MESEC', 'NETO.MESECNA.PLACA')

uvozi.place <- uvozi.place %>%
  group_by(STATISTICNA.REGIJA, SKD.DEJAVNOST, LETO) %>%
  summarize(POVPRECNA.LETNA.PLACA = mean(NETO.MESECNA.PLACA, na.rm=TRUE))














