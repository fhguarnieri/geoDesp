#
# Dispersão despesas 2018 SP
#

library(tidyverse)
library(stringdist)
library(rgdal)
library("maptools")
library(broom)
library(sf)
library(gridExtra)

load("extrSP.RData")
load("cidadesDF.RData")
load("cidades.RData")
load("totVot.RData")


# Verifica quais são e o número de municípios onde cada candidato fez transações

b2 <- tapply(extrUFfim$municipio, extrUFfim$numcand, function(x) table(x))
b3 <- tapply(extrUFfim$municipio, extrUFfim$numcand, function(x) length(unique(x)))
hist(b3, main = "Distribução do número de municípios em que cada candidato realizou depósitos",
     xlab = "Número de Municípios",
     ylab = "Frequência")
b3 <- data.frame("numcand" = names(b3), "numMun" = b3)

tmp <- merge(extrUFfim, b3, by = "numcand", all.x = T)


# Calcula a proporção dos depósitos no município mais ferquente sobre o total
# de cada candidato

pratio <- tapply(tmp$municipio, tmp$numcand, function(x) max(table(x),0)/sum(table(x)+1))
boxplot(pratio[pratio > 0])

numMunCand <- tapply(tmp$numMun,tmp$situacao, median)
boxplot(tmp$numMun ~ tmp$situacao, cex.axis = 0.7, xlab = "",ylab = "")

## Ve proporção dos votos totais que vieram dos locais onde fez campanha
## Exemplo de como a base pode ser comparada com outras bases como a de resultados eleitorais


totVot <- data.frame("id" = names(totVot), "votos" = totVot)
agMun <- aggregate(votos ~ municipio + numcand, data = extrUFfim, FUN = mean)
votBase <- tapply(agMun$votos, agMun$numcand, sum)
votBase <- data.frame("id" = names(votBase), "votos" = votBase)

votBase <- votBase %>% right_join(totVot, by = "id")

summary(votBase[2]/votBase[3])


#################### MAPAS #######################################################################



map <- ggplot() + geom_polygon(data = cidades,
                               aes(x = long, y = lat, group = group),
                               colour = "darkgrey",
                               fill = NA,
                               size = 0.3)



map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$tdesp)),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Distribuição e valor (em log10) das movimentações dos candidatos a deputado federal em Sâo Paulo")



# Votação dos 6 mais votados

e1 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1720')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Eduardo Bolsonaro")

e2 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1771')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Joice Hasselmann")

e3 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1000')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Celso Russomano")

e4 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2555')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Kim Kataguiri")

e5 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2222')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Francisco Everardo")

e6 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1200')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Tabata Amaral")

grid.arrange(e1,e2,e3)


# Votação dos seis mais votados entre os eleitos por média

em1 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2533')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "David Bezerra Soares")

em2 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4515')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Eduardo Cury")

em3 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2277')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Miguel Lombardi")


map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2577')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Adriano Eli Correia")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2020')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Gilberto Nascimento")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2550')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Eugenio José  Zuliani")

grid.arrange(em1,em2,em3)

# Os seis mais votados entre os suplentes

s1 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4547')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Miguel Haddad")

s2 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1152')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Arnaldo Faria  de Sá")

s3 <- map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2511')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Missionário José Olimpio")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'5555')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Eleuses Paiva")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4577')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Carlos Bezerra Jr.")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4000')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Luiz Lauro Filho")

grid.arrange(s1,s2,s3)


# Os seis mais votados entre os não-eleitos

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1818')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Kayo Amado")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'5151')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Adilson Barroso")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2828')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Levy Fidelix")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'9090')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Ricardo Teixeira")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1800')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Marcos Papa.")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1808')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Wellington Nogueira")

# Número de municípios por partido

barplot(tapply(extrSPr$municipio,extrSPr$partido, function(x) length(unique(x))), cex.names = 0.7, las = 2)

barplot(table(extrSPr$partido)/tapply(extrSPr$numcand,extrSPr$partido, function(x) length(unique(x))), cex.names = 0.7, las = 2)

munPart <- tapply(extrSPr$municipio, extrSPr$partido, function(x) length(unique(x)))

# PMDB

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1515')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Baleia  Rossi")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1551')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Herculano Passos Jr.")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1500')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Paulo Mansur")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1555')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Junji Abe")

#map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log(cidades.df$'1588')),colour = "black", size = 0.3) +
#  coord_equal() +
#  scale_fill_gradient(low = "#3300CC", high = "#CC00CC", na.value = NA) +
#  labs(title = "Vitor Rodrigues")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1507')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Antonio Matias dos Santos")


# PR

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2222')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Tiririca")

map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2240')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Policial Katia  Sastre")

pr1 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2200')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Capitão Augusto")

pr2 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2299')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Marcio Alvino")

pr3 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2233')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC", na.value = NA) +
  labs(title = "Paulo Freire Costa")

pr4 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2277')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Miguel Lombardi")

pr5 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2244')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Luiz Carlos Motta")

pr6 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'2255')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Milton Monti")

grid.arrange(pr1, pr2, pr3, pr4, pr5, pr6, nrow = 3)


# PSDB

psdb1 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4585')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Bruna Furlan")

psdb2 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4500')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Carlos Sampaio")

psdb3 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4510')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Vitor Lipi")

psdb4 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4580')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Samuel Moreira")

psdb5 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4551')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC", na.value = NA) +
  labs(title = "Vanderlei Macris")

psdb6 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'4515')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Eduardo Cury")



grid.arrange(psdb1,psdb2,psdb3,psdb4,psdb5,psdb6, nrow = 3)


# PT

pt1 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1313')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Rui Falcão")

pt2 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1370')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Carlos Zaratini")

pt3 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1353')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Nilton Tatto")

pt4 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1354')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Alexandre Padilha")

pt5 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1322')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC", na.value = NA) +
  labs(title = "Arlindo Chinaglia")

pt6 <-  map + geom_polygon(data = cidades.df,  aes(long,lat,group = group, fill = log10(cidades.df$'1398')),colour = "black", size = 0.3) +
  coord_equal() +
  scale_fill_gradient(low = "#3300CC", high = "#CC00CC",na.value = NA) +
  labs(title = "Paulo Teixeira")



grid.arrange(pt1,pt2,pt3,pt4,pt5,pt6, nrow = 3)
