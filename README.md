# geoDesp
Base de dados com os locais onde candidatos realizam suas despesas de campanha para Deputado Federal, em todos estados, nas eleições de 2018


geoDesp é uma base de dados inédita que nos auxilia a dirimir um grande problema no estudo das estratégias eleitorais: a ausência de dados que permitam identificar onde, quando e como os candidatos realizam atividades durante a campanha  eleitoral. O TSE disponibilizou os registros de receitas e gastos realizados durante a campanha de cada candidato. Dentre as muitas informações contidas ali, coletamos o número do banco e da agência do beneficiário das transações indicadas pelos candidatos e cruzamos com uma lista com endereço das agências bancárias no Brasil. A partir destes cruzamentos, pudemos georreferenciar os gastos dos candidatos ao legislativo nacional para todo o país e assim construir uma proxy das estratégias de  campanha na disputa eleitoral.

Esta base de dados inédita permitirá que consigamos avançar na compreensão de como a campanha eleitoral é construída, quais estratégias são empregadas e também como se dá a relação entre representantes e cidadãos, uma vez que será possível dissociarmos os esforço de campanha do resultado da eleição.

Database with the locations where candidates carry out their campaign expenses for Federal Deputy, in all states, in the 2018 elections

geoDesp is a unique database that helps us solve a major problem in the study of electoral strategies: the lack of data that allows us to identify where, when and how candidates carry out activities during the electoral campaign. The TSE made records of income and expenses made during each candidate's campaign available. Among the many information contained there, we collected the bank and branch number of the beneficiary of the transactions indicated by the candidates and compared it with a list of bank branch addresses in Brazil. From these crossings, we were able to georeference the expenses of candidates for the national legislature for the entire country and thus build a proxy for campaign strategies in the electoral dispute.

This unprecedented database will allow us to advance in understanding how the electoral campaign is constructed, what strategies are used and also how the relationship between representatives and citizens occurs, since it will be possible to dissociate campaign efforts from the election result.

| Variável  | Descrição                                                                                             |
|-------------------|-----------------------------------------------------|
| numcand   | Número do candidato                                                                                   |
| cnpjCand  | CNPJ da campanha do candidato                                                                         |
| cpfCand   | CPF do candidato                                                                                      |
| nome      | Nome completo do candidato conforme TSE                                                               |
| nurna     | Nome usado pelo candidato na urna                                                                     |
| partido   | Partido do candidato                                                                                  |
| valor     | Montante da movimentação em R\$                                                                       |
| cpfBene   | CPF do beneficiário                                                                                   |
| municipio | Município em que a agência se encontra                                                                |
| muncand   | Município onde o candidato efetuou a maior parte das transações                                       |
| uf        | estado em que se deu a disputa                                                                        |
| TSEcod    | Código atribuído pelo TSE ao município onde ocorreu a transação                                       |
| IBGEcod   | Código atribuído pelo IBGE ao município onde ocorreu a transação                                      |
| situacao  | Se o candidato foi eleito ou não, se é suplente e se foi eleito por quociente partidário ou por média |
| votos     | Votação do candidato no município onde houve transação                                                |
