pega_usuario <- function(usuario){
  out <- tryCatch(
    {
      lookup_users(usuario, token = token)
    },
    error = function(cond){
      message(paste("Usuario sem tweets:", usuario))
      message(cond)
      return(data.frame())
    },
    warning=function(cond) {
      message(paste("URL caused a warning:", usuario))
      message("Here's the original warning message:")
      message(cond)
      # Choose a return value in case of warning
      return(data.frame())
    },
    finally = {
      message(paste("Processed usuario:", usuario))
      assign("i", value= i+1, envir = .GlobalEnv)
      if(i==899){
        assign("i", value=0, envir = .GlobalEnv)
        assign("x", value=x+1, envir = .GlobalEnv)
        print(x)
        Sys.sleep(910)
      }
    }
  )
  return(out)
}


#Importa as bibliotecas e cria as variaveis necessarias
library(tidyverse)
library(rtweet)
library(openxlsx)
i=0
x=0
token <- readRDS("xxxxxx")

#Importa os dados
base <- read_csv("base.csv")

#Cria o vetor de usuarios
users <- unique(base$username)

#Cria o data frame com os dados do rtweet para score
df_data_users <- map_dfr(users, pega_usuario)