

library('ProjectTemplate')
load.project()


# Database connection sqlite
my_db <- src_sqlite(path = "data/salud_reproductiva.db", create = T)
my_db # tablas

# tbl_counts <- tbl(my_db, sql("select filenom, count(filenom) from nacimientos group by filenom"))

# Nacimientos
# prueba edad padre
tab.nacim <- tbl(my_db, 
                 sql("select * from nacimientos where filenom == 'natalidad_base_datos_2015_dbf'")
                 ) %>% 
  group_by(EDAD_PADN, EDAD_MADN) %>%
  tally #%>%
  # collect()
tab.nacim.c <- tab.nacim %>% 
  collect
cache("tab.nacim.c")


load("cache/tab.nacim.c.RData")
tab.nacim.c %>% 
  ungroup %>% 
  mutate_if(is.character, parse_number) %>% 
  filter(EDAD_MADN < 20,
         EDAD_PADN < 99) %>% 
  ggplot(aes(x = factor(EDAD_PADN), 
             y = factor(EDAD_MADN), 
             fill = n)) + 
  geom_tile() 

tab.nacim.c %>% 
  filter(EDAD_MADN < 20) %>% 
  unite(E)

# Defunciones
defun <- tbl(my_db, sql("select * from defunciones"))
defun

tbl_counts <- tbl(my_db, sql("select filenom, count(filenom) from defunciones group by filenom"))