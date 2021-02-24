# 4. faza: Analiza podatkov

#NAPOVED RASTI NETO POVPREČNE PLAČE V SLOVENIJI
#linearna regresija




model <- lm(POVPRECNA.MESECNA.PLACA.SLO ~ MESEC, data=mesecne.place.slo)

#napoved za vsak prvi mesec v letu

prihodnja.leta <- data.frame(MESEC = c("2014-01-01", "2015-01-01", "2015-01-01", "2016-01-01", "2017-01-01", "2018-01-01", "2019-01-01",
                                       
                                       "2020-01-01", "2021-01-01", "2022-01-01", "2023-01-01", "2024-01-01", "2025-01-01"))

prihodnja.leta$MESEC <- as.Date(prihodnja.leta$MESEC)

napoved.slo <- mutate(prihodnja.leta, POVPRECNA.MESECNA.PLACA.SLO = predict(model,prihodnja.leta))

napoved.graf <- ggplot(mesecne.place.slo, aes( x = MESEC, y = POVPRECNA.MESECNA.PLACA.SLO)) + geom_point() +
  
  geom_smooth(method = 'lm', fullrange = TRUE, formula = y~x) + 
  
  geom_point(data = napoved.slo, aes( x = MESEC, y = POVPRECNA.MESECNA.PLACA.SLO)) +
  xlab("Leto") + ylab("Mesečna plača (€)")

