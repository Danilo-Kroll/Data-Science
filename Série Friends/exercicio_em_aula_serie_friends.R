# Exemplo com o script da Série Friends

# https://medium.com/swlh/text-analytics-on-friends-tv-series-10-episodes-42875804f3a6

# https://github.com/NeilEcosse/text_analysis_friends

# https://github.com/rfordatascience/tidytuesday/issues/254


### Aplicação Dkroll

#Pacotes utilizados
pacotes <- c("tidytext","ggplot2","dplyr","tibble","wordcloud","stringr","SnowballC","widyr","janeaustenr")

if(sum(as.numeric(!pacotes %in% installed.packages())) != 0){
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for(i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break()}
  sapply(pacotes, require, character = T) 
} else {
  sapply(pacotes, require, character = T) 
}

# Pacotes
library("dplyr")
library("tidytext")
library("ggplot2")
library("tibble")
library("wordcloud")
library("stringr")
library("SnowballC")

# Carregando os dados com o pacote Friends
install.packages("friends")
library("friends")

# Trnaformando em um dataframe
text <- data.frame(friends)

# Analise exploratória dos dados

# Frequecia de dialogo dos 6 personagens





# Uso do formato tibble com a coluna dos dialogos
text_df <- tibble(line = 1:67373, text = text$text)

# Tokenizando o texto
df <-  text_df %>% unnest_tokens(word, text)

#Stop Words personalizado com o nome dos personagens
stop_words_friends <- c("joey","monica","ross","raquel","phoebe","chandler")
df_sem_stop_words <- df %>% anti_join(stop_words_friends)

# Contagem das palavras
conta <- df %>% count(word, sort = TRUE) 

# Palavras faladas mais de mil vezes
top20 <-conta %>% filter(n > 1000)

# Gráfico de Nuvem de Palavras com as 50 palavras mais usadas
# define a paleta de cores
pal <- brewer.pal(8,"Dark2")
top20 %>% with(wordcloud(word, n, random.order = FALSE, max.words = 50, colors=pal))


#grafico

#Para facilitar a visualização

df %>%
  count(word, sort = TRUE) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n, word)) +
  geom_col() 









