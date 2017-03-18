library(ProjectTemplate)
load.project()

my_db <- src_sqlite(path = "cache/saludrepro_datos.db", create = T)


# Defunciones
tbl(my_db, sql("SELECT * FROM defunciones"))
