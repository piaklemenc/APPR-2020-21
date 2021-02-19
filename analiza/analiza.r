# 4. faza: Analiza podatkov

#NAPOVED RASTI NETO POVPREČNE PLAČE V SLOVENIJI
#linearna regresija


model <- lm(data=mesecne.place.slo, MESEC ~ POVPRECNA.MESECNA.PLACA.SLO)

prihodnja.leta <- data.frame(MESEC = seq(2014,2022,1))

napoved.slo <- mutate(prihodnja.leta, POVPRECNA.MESECNA.PLACA.SLO = predict(model,prihodnja.leta))

napoved.graf <- ggplot(mesecne.place.slo, aes( x = MESEC, y = POVPRECNA.MESECNA.PLACA.SLO)) + geom_point() +
  geom_smooth(method = 'lm', fullrange = TRUE, formula = y~x) + 
  geom_point(data = napoved.slo, aes( x = MESEC, y = POVPRECNA.MESECNA.PLACA.SLO)) 
