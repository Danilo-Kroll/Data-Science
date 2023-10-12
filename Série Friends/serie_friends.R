##--- TEXT MINING COM DADOS DA SÉRIE FRIENDS

##--- CARREGANDO PACOTES E TRATANDO OS DADOS

# Carregando os pacotes
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

# Carregando os dados da série com o pacote Friends
install.packages("friends")
library("friends")

# Visualisando as primeiras linhas do dataset
head(friends)

# Transformando em um dataframe
script <- data.frame(friends)

# Selecionado somente o dialogo dos 6 personagens principais
script_principal <-
  script %>%
    filter(speaker == 'Monica Geller' |
             speaker == 'Joey Tribbiani' |
             speaker == 'Chandler Bing' |
             speaker == 'Phoebe Buffay' |
             speaker == 'Ross Geller' |
             speaker == 'Rachel Green')

# Alterando o nome dos personagem
script_principal$speaker[script_principal$speaker == "Monica Geller"] <- "Monica"
script_principal$speaker[script_principal$speaker == "Joey Tribbiani"] <- "joey"
script_principal$speaker[script_principal$speaker == "Chandler Bing"] <- "Chandley"
script_principal$speaker[script_principal$speaker == "Phoebe Buffay"] <- "Phoebe"
script_principal$speaker[script_principal$speaker == "Ross Geller"] <- "Ross"
script_principal$speaker[script_principal$speaker == "Rachel Green"] <- "Rachel"


##--- ANÁLISE EXPLORATÓRIA DOS DADOS

# Frequência de diálogo dos 6 personagens
script_principal %>%
  group_by(speaker) %>% 
  summarise(qtd = n()) %>% 
  ggplot(., aes(x = speaker, y = qtd)) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  geom_col(fill = "steel blue") +
  labs(title = "Diálogo dos Personagens",
       x = "Personagem",
       y = "Quantidade")


# Frequêcia da famosa frase do Joey 'How you doing'
script_principal %>% 
  filter(str_detect(text, "[Hh][Oo][Ww] [Yy][Oo][Uu] [Dd][Oo][Ii][Nn]")) %>% 
  group_by(speaker) %>% 
  summarise(qtd = n()) %>% 
  ggplot() +
  aes(x = speaker, y = qtd) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  geom_col(fill = "steel blue") +
  labs(title = "Quantidade de vezes que foi falado 'how you doin'",
       x = "Personagem",
       y = "Quantidade")


##--- NPL (Text Mining)

# Tokenizando o texto
# Mantendo somente a coluna do diálogo
script_principal <- as_tibble(script_principal)
script_principal <- script_principal[,1]

# Transformando cada palavra em uma linha
script_word <- script_principal %>% unnest_tokens(word, text)

# Contagem das palavras
script_count <- script_word %>% count(word, sort = TRUE)

# Palavras faladas mais de mil vezes
top_word <- script_count %>% filter(n > 1000)

# Gráfico de Nuvem de Palavras com as 50 palavras mais usadas
# define a paleta de cores
pal <- brewer.pal(8,"Dark2")
top_word %>% with(wordcloud(word, n, random.order = FALSE, max.words = 50, colors=pal))
