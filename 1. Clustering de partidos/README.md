## Objetivo do projeto

O objetivo desse projeto é encontrar os partidos que mais gastaram no ano de 2022 em relação as 3 despesas abaixo:

1. COMBUSTIVEIS E LUBRIFICANTES
2. DIVULGACAO DA ATIVIDADE PARLAMENTAR	TOTAL
3. TELEFONIA

Vale resaltar que a quantidade de políticos por partido varia, então dessa forma, iremos analisar o gasto médio por político de cada partido (despesas total do partido / total de políticos).

No final iremos responder utilizando a "clusterização" qual grupo de partidos tiveram o maior gasto em 2022.

## Método aplicado

1) K-Means

## Etapas do projeto

1) Tratamento dos dados
 Download do arquivo no site <a href="https://dadosabertos.camara.leg.br/swagger/api.html#staticfile">*dados abertos*</a>
 - Consolidação dos valores gastos por partido
 - Média de gastos por partido (despesas total do partido / total de políticos)

arquivo final: gastos-2022.csv (em anexo).


2) Aplicação na linguagem R
 - Importação das bibliotecas
 - Importação dos dados
 - Método Elbow para identificar a quantidade ideal de *clusters*
 - Método K-Means para agrupar os partidos
 - Resultados Preliminar


3) Conclusão
 - Resultado analisado pelo cientista de dados
 - Resultado disponibilizado no Power BI para a comunidade tirar suas próprias concluções.
