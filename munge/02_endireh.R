
# ENDIREH: Encuesta Nacional Sobre la Dinámica de las Relaciones en los Hogares  
# Init: 021/08/2017
# SGMC

# Tabla Roles

library(foreign)
library(tidyverse)
library(forcats)
library(stringr)


# TSDem: Demos ----

tab <- read.dbf("data/endireh/base_datos_endireh2016_dbf/TSDem.DBF") 

df.demos.endireh <- tab %>% 
  as_tibble  %>% 
  mutate(PAREN = fct_recode(PAREN,
                            `Jefe` = "1" ,
                            `Esposo(a) o compañero(a)` = "2" ,
                            `Hijo(a)` = "3" ,
                            `Nieto(a)` = "4", 
                            `Yerno o nuera` = "5" ,
                            `Hermano(a)` = "6" ,
                            `Otros parientes` = "7" ,
                            `No parientes` = "8" ,
                            `Empleado(a) doméstico(a)` = "9"))

cache("df.demos.endireh")

# TB_SEC_XV: Roles ----
tab <- read.dbf("data/endireh/base_datos_endireh2016_dbf/TB_SEC_XV.dbf") 
head(tab)

vars.p15 <- select(tab, starts_with("P15_")) %>% names

recode_col_p15 <- function(col){
  col <- factor(col, 
         levels = c(1, 2, 9), 
         labels = c("Sí", "No", "Ne"))
  return(col)
}

df.roles <- tab %>% 
  as_tibble() %>% 
  mutate_at(.vars = vars.p15,
            .funs = recode_col_p15) %>% 
  mutate(T_INSTRUM = fct_recode(T_INSTRUM,
                                `casada residente` = "A1",
                                `casada ausente` = "A2",
                                `separada/divorciada` = "B1",
                                `viuda` = "B2",
                                `soltera` = "C1",
                                `soltera s/novio` = "C2"
                                ),
         dominio = fct_recode(DOMINIO, 
                              `C/U` = "U",
                              `C/U` = "C")) %>% 
  dplyr::select(ID_VIV, ID_MUJ, 
                dominio, T_INSTRUM, 
                FAC_VIV, FAC_MUJ,
                P15_1_1:P15_1_9) %>% 
  gather(variable, value, P15_1_1:P15_1_9) %>% 
  mutate(codigo = factor( 
    parse_number(str_sub(variable, -1, -1)),
    levels = 1:9,
    labels = c("mujeres resp cuidado",
               "hombres ganan mas",
               "igual resp dinero",
               "ambos resp cuidado y tareas",
               "mujeres divertirse noche",
               "hombres mejores puestos",
               "mujeres trabajo descuido hijos",
               "sin escotes para no molesten",
               "sexo cuando esposo quiera"
               ))
    )
  

cache("df.roles")
