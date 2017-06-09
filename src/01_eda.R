

library('ProjectTemplate')
load.project()


# Database connection sqlite
my_db <- src_sqlite(path = "data/salud_reproductiva.db", create = T)
my_db # tablas



# Nacimientos
nacim <- tbl(my_db, sql("select * from nacimientos"))
nacim

tab <- nacim %>% 
  group_by(filenom) %>% 
  summarise(count = n())
tab_local <- collect(tab)  



# Defunciones

defun <- tbl(my_db, sql("select * from defunciones"))
defun

