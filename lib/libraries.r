

library(rvest)
library(gsubfn)
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
library(lubridate)

options(gsubfn.engine="R")

# Uvozimo funkcije za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
