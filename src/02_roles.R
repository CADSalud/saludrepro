
library(ProjectTemplate)
load.project()

load("cache/df.roles.RData")

df.roles

tab <- df.roles %>% 
  group_by(codigo, value) %>% 
  summarise(n = n(),
            n_pond = sum(FAC_MUJ)) %>% 
  group_by(codigo) %>% 
  mutate(porc = 100*n_pond/sum(n_pond), 
         value = as.character(value))

ggplot(tab, aes(x = codigo, 
                     y = porc,
                     fill = value)) +
  geom_bar(position  = "stack",
           stat = "identity") + 
  coord_flip()

tab <- df.roles %>% 
  filter(value != "Ne") %>% 
  group_by(codigo, value, dominio) %>% 
  summarise(n = n(),
            n_pond = sum(FAC_MUJ)) %>% 
  group_by(codigo, dominio) %>% 
  mutate(porc = 100*n_pond/sum(n_pond), 
         value = as.character(value))
tab %>% 
  filter(value == "Sí") %>% 
  ggplot(aes(x = codigo, 
                y = porc, 
                fill = dominio)) +
  geom_bar(stat = "identity", 
           position  = "dodge") +
  ggtitle("Respuesta Sí") +
  coord_flip() 



# CA edo civil ----

tab <- df.roles %>% 
  filter(value != "Ne") %>% 
  group_by(codigo, value, T_INSTRUM) %>% 
  summarise(n = n(),
            n_pond = sum(FAC_MUJ)) %>% 
  ungroup() %>% 
  filter(value == "Sí") %>% 
  dplyr::select(codigo:T_INSTRUM, n_pond) %>% 
  spread(T_INSTRUM, n_pond)

mat.tab <- tab[, -c(1,2)] %>% 
  as.matrix()
rownames(mat.tab) <- tab$codigo

CA(mat.tab)


# DEMOS ----

tab.demos <- df.roles %>% 
  left_join(
    df.demos.endireh %>% 
      dplyr::select(ID_VIV, ID_MUJ, 
                    PAREN, SEXO, EDAD,
                    NIV) %>% 
      mutate(edad_cut = cut_width(parse_number(EDAD),  10) ),
    by = c("ID_VIV", "ID_MUJ")
    ) 
  
tab.demos %>% data.frame() %>% head
	
# edad
tab <- tab.demos %>% 
  filter(value != "Ne") %>% 
  group_by(codigo, value, edad_cut) %>% 
  summarise(n = n(),
            n_pond = sum(FAC_MUJ)) %>% 
  ungroup() %>% 
  filter(value == "Sí") %>% 
  dplyr::select(codigo:edad_cut, n_pond) %>% 
  spread(edad_cut, n_pond)

mat.tab <- tab[, -c(1,2)] %>% 
  as.matrix()
rownames(mat.tab) <- tab$codigo

CA(mat.tab)

# parentesco
tab <- tab.demos %>% 
  filter(value != "Ne") %>% 
  group_by(codigo, value, PAREN) %>% 
  summarise(n = n(),
            n_pond = sum(FAC_MUJ)) %>% 
  ungroup() %>% 
  filter(value == "Sí") %>% 
  dplyr::select(codigo:PAREN, n_pond) %>% 
  spread(PAREN, n_pond)

mat.tab <- tab[, -c(1,2)] %>% 
  as.matrix()
rownames(mat.tab) <- tab$codigo

CA(mat.tab)


# Nivel
tab <- tab.demos %>% 
  filter(value != "Ne", 
         NIV != '99') %>% 
  group_by(codigo, value, NIV) %>% 
  summarise(n = n(),
            n_pond = sum(FAC_MUJ)) %>% 
  ungroup() %>% 
  filter(value == "Sí") %>% 
  dplyr::select(codigo:NIV, n_pond) %>% 
  spread(NIV, n_pond) 

mat.tab <- tab[, -c(1,2)] %>% 
  as.matrix()
rownames(mat.tab) <- tab$codigo

CA(mat.tab)

