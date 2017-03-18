library(ProjectTemplate)
load.project()

my_db <- src_sqlite(path = "data/saludrepro_datos.db", create = T)


# Defunciones

defun.sql <- tbl(my_db, sql("SELECT * FROM defunciones"))
tbl(my_db, sql("SELECT id, count(*) as cnt FROM defunciones group by id")) %>% 
  collect()