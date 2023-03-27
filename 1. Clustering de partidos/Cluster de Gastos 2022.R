#### Clustering

### O objetivo desse estudo é segmentar os partidos para avaliar quais possuem 
### um maior nível de gastos em relação as categorias de despesas que julgo serem
### irrelevantes para um partalentar desperdiçar nosso dinheiro, tendo em vista
### que deveria ser usado para outros fins do nosso país.

# Instalação e carregamento dos pacotes
pacotes <- c("plotly", #plataforma gráfica
             "tidyverse", #carregar outros pacotes do R
             "ggrepel", #geoms de texto e rótulo para 'ggplot2' que ajudam a
             #evitar sobreposição de textos
             "knitr", "kableExtra", #formatação de tabelas
             "reshape2", #função 'melt'
             "misc3d", #gráficos 3D
             "plot3D", #gráficos 3D
             "cluster", #função 'agnes' para elaboração de clusters hierárquicos
             "factoextra", #função 'fviz_dend' para construção de dendrogramas
             "ade4", #função 'ade4' para matriz de distâncias em var. binárias
             "dplyr",
             "ggfortify")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Carregando o arquivo
base <- read.csv("gastos-2022.csv", 
                 sep = ";", 
                 dec = ",")

# Estatística descritiva dos dados
summary(base)

# Padronizando as variáveis com Z-score: (data - média) / desvio padrão
#--- Não será preciso padronizar os dados


#--------- Método K-means
# Método de Elbow para identificação do número ótimo de clusters
## Em geral, quando há a dobra é um indício do número ótimo de clusters
fviz_nbclust(base[,3:5], kmeans, method = "wss", k.max = 10)

# Número ótimo de cluster: 4
# Elaboração da clusterização não hieráquica k-means
cluster_kmeans <- kmeans(base[,3:5],
                         centers = 4)

# Visualização gráfica dos cluster
autoplot(cluster_kmeans,base,frame=TRUE)

# Incluíndo o cluster no banco de dados
base$cluster_K <- factor(cluster_kmeans$cluster)

# Visualização da base de dados
base %>%
  kable() %>%
  kable_styling(bootstrap_options = "striped", 
                full_width = FALSE,
                font_size = 20)

# Identificar a quantiade em cada cluster
summary(base$cluster_K)

# Médias dos Cluster
análise_K <- group_by(base, cluster_K) %>%
  summarise(COMBUSTIVEIS = mean(COMBUSTIVEIS),
            DIVULGACAO = mean(DIVULGACAO),
            TELEFONIA = mean(TELEFONIA))

# Analise dos cluster:
# Cluster 1 - Possui o menor gasto
# Cluster 3 - São os partidos que possuem o maior gasto, ou seja, é o grupo que a 
# proposta do estudo desejava encontrar.
# Cluster 2 e 4 - São gastos consideravéis, porém não maiores que o cluster 3

# Criando arquivo com a coluna de Cluster
write.csv(base, file = "gastos-2022-cluster.csv", row.names = F)



