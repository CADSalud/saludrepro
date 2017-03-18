
# Mortalidad: DEFUNCIONES INEGI
# Init: 02/01/2017
# SGMC


# 0. Archivos defunciones
# 1. Defunciones 1998 a 2015



# 0. Archivos defunciones
path.str <- "data/defunciones_generales/"
files.noms.aux <- list.files(path.str)[!str_detect(list.files(path.str), ".zip")]
parse_number(files.noms.aux)

my_db <- src_sqlite(path = "data/salud_reproductiva.db", create = T)
my_db # tablas

# 1. Defunciones 1998 a 2015
files.noms <- files.noms.aux[parse_number(files.noms.aux) >= 1998]
lapply(files.noms, function(file.u){
  # file.u <- files.noms[1]
  print(file.u)
  dbf.files <- list.files( paste0(path.str,file.u))
  path.u <- paste(path.str, file.u, sep = "")
  dat <- read.dbf( paste0(path.u, "/", dbf.files[str_detect(dbf.files, "^DEFUN")]),
                   as.is = T ) %>% 
    mutate(filenom = file.u) %>% 
    mutate_all(.funs = as.character) 
  }) %>% 
  bind_rows(.id = "id") %>% 
  db_insert_into( con = my_db$con, table = "defunciones", values = .) # insert into

tt <- tbl(my_db, sql("SELECT id, count(*) as cnt FROM defunciones group by id")) %>% 
  collect()


# 2. Causa de defunciones 1998 a 2015
files.noms <- files.noms.aux[parse_number(files.noms.aux) >= 1998]
lapply(files.noms, function(file.u){
  # file.u <- files.noms[1]
  print(file.u)
  dbf.files <- list.files( paste0(path.str,file.u))
  path.u <- paste(path.str, file.u, sep = "")
  # causa de básica de defunción clasificación internacional
  dat <- read.dbf( paste0(path.u, "/", 
                          dbf.files[str_detect(dbf.files, "^CATMINDE")]),
                   as.is = T ) %>% 
    mutate(filenom = file.u) %>% 
    mutate_all(.funs = as.character) 
  }) %>% 
  bind_rows(.id = "id") %>% 
  db_insert_into( con = my_db$con, table = "defunciones", values = .) # insert into

tt <- tbl(my_db, sql("SELECT id, count(*) as cnt FROM defunciones group by id")) %>% 
  collect()






# # ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ # 
# # 1. Defunciones 1998 a 2015
# files.noms <- files.noms.aux[parse_number(files.noms.aux) >= 1998]
# 
# # dbf.s y listas de causas de defunciones
# muertes.l <- lapply(files.noms, function(file.u){
#   # file.u <- files.noms[1]
#   # file.u
#   print(file.u)
#   
#   dbf.files <- list.files( paste0(path.str,file.u))
#   path.u <- paste(path.str, file.u, sep = "/")
#   
#   dat <- read.dbf( paste0(path.u, "/", dbf.files[str_detect(dbf.files, "^DEFUN")]),
#                    as.is = T )
#   head(dat)
#   
#   tab.f <- dat %>% 
#     mutate(SEXO = factor(SEXO, levels = 1:2, labels = c('M', 'F')),
#            OCUPACION_rec = car::recode(OCUPACION, rec_ocupacion_1),
#            ESCOLARIDA_rec = car::recode(ESCOLARIDA, rec_escolaridad),
#            year = parse_number(file.u)
#     ) %>%
#     left_join(
#       #causa de básica de defunción clasificación internacional
#       read.dbf( paste0(path.u, "/", 
#                        dbf.files[str_detect(dbf.files, "^CATMINDE")]), 
#                 as.is = T ) %>% 
#         rename(CAUSA_DEF = CLAVE, causa_CAUSA_DEF = DESCRIP),
#       by = "CAUSA_DEF"
#     ) %>% 
#     left_join(
#       #lista mexicana de defunciones
#       read.dbf( paste0(path.u, "/", 
#                        dbf.files[str_detect(dbf.files, "^LISTAMEX")]), 
#                 as.is = T ) %>% 
#         rename(LISTA_MEX = CLAVE, causa_LISTA_MEX = DESCRIP),
#       by = "LISTA_MEX"
#     ) %>% 
#     left_join(
#       #lista mexicana de defunciones por grupos
#       read.dbf( paste0(path.u, "/", 
#                        dbf.files[str_detect(dbf.files, "^LISTAMEX")]), 
#                 as.is = T ) %>% 
#         rename(GR_LISMEX = CLAVE, causa_GR_LISMEX = DESCRIP),
#       by = "GR_LISMEX"
#     ) %>% 
#     left_join(
#       #lista asamblea mundial de la salud
#       read.dbf( paste0(path.u, "/", 
#                        dbf.files[str_detect(dbf.files, "^LISTA1")]), 
#                 as.is = T ) %>% 
#         rename(LISTA1 = CLAVE, causa_LISTA1 = DESCRIP),
#       by = "LISTA1"
#     ) %>% 
#     left_join(
#       #lista de causas durante embarazo  
#       read.dbf( paste0(path.u, "/", 
#                        dbf.files[str_detect(dbf.files, "^CATMINDE")]), 
#                 as.is = T ) %>% 
#         rename(MATERNAS = CLAVE, causa_MATERNAS = DESCRIP),
#       by = "MATERNAS"
#     ) %>% 
#     mutate( ENT_OCURR  = parse_number(ENT_OCURR ), 
#             ENT_REGIS  = parse_number(ENT_REGIS ), 
#             ENT_RESID  = parse_number(ENT_RESID ), 
#             DIS_RE_OAX = parse_number(DIS_RE_OAX),
#             MUN_OCURR  = parse_number(MUN_OCURR ), 
#             MUN_REGIS  = parse_number(MUN_REGIS ), 
#             MUN_RESID  = parse_number(MUN_RESID )
#     )
#   
#   head(tab.f)
#   
#   print(n_distinct(tab.f$causa_LISTA_MEX))
#   print(n_distinct(tab.f$causa_LISTA1))
#   print(n_distinct(tab.f$causa_GR_LISMEX))
#   print(n_distinct(tab.f$causa_MATERNAS))
#   
#   return(tab.f)
# })
# 
# # intersect colnames 
# sapply(muertes.l, dim)
# sapply(muertes.l, names)
tab.colnames <- lapply(tt, function(elem){
  data.frame(
    cols = names(elem),
    year = unique(elem$filenom),
    stringsAsFactors = F)
  }) %>%
  bind_rows() %>%
  mutate(loc = 1) %>%
  spread(year, loc)
colnames.selec <- tab.colnames$cols[apply(is.na(tab.colnames), 1, sum) == 0]

# # dataframe final
# defunc_1 <- lapply(muertes.l, function(elem){
#   print(elem$year %>% unique)
#   # elem.f <- elem[, names(elem) %in% colnames.selec20]
#   elem.f <- elem %>% 
#     dplyr::select(one_of(colnames.selec))
#   elem.f
#   }) %>% 
#   rbind_all()
# 
# head(defunc_1 %>% data.frame())
# names(defunc_1)
# # rdata
# cache('defunc_1')
# load("cache/defunc_1.RData")
# 
# # sqlite
# my_db <- src_sqlite(path = "cache/saludrepro_datos.db", create = T)
# defunc_sqlite <- copy_to(my_db, defunc_1, name = "defunciones", temporary = FALSE)
# 
# tbl(my_db, sql("SELECT * FROM defunciones"))
# tbl(my_db, sql("SELECT ANIO_OCUR, COUNT(*) as cnt FROM defunciones"))
# 
# 
# 
# # # 2. Defunciones 1990 a 1997
# # files.noms <- files.noms.aux[parse_number(files.noms.aux) <= 1997]
# # 
# # muertes.l <- lapply(files.noms, function(file.u){
# #   # file.u <- files.noms[1]
# #   # file.u
# #   print(file.u)
# #   
# #   dbf.files <- list.files( paste0(path.str,file.u))
# #   path.u <- paste(path.str, file.u, sep = "/")
# #   
# #   dat <- read.dbf( paste0(path.u, "/", dbf.files[str_detect(dbf.files, "^DEFUN")]),
# #                    as.is = T )
# #   head(dat)
# #   
# #   
# #   tab.f <- dat %>% 
# #     mutate(SEXO = factor(SEXO, levels = 1:2, labels = c('M', 'F')),
# #            OCUPACION_rec = car::recode(OCUPACION, rec_ocupacion_3),
# #            ESCOLARIDA_rec = car::recode(ESCOLARIDA, rec_escolaridad),
# #            year = parse_number(file.u)
# #     ) %>% 
# #     left_join(
# #       #causa de básica de defunción clasificación internacional
# #       read.dbf( paste0(path.u, "/", 
# #                        dbf.files[str_detect(dbf.files, "^DETALLADA")]), 
# #                 as.is = T ) %>% 
# #         rename(CAUSA_DEF = CLAVE, causa_CAUSA_DEF = DESCRIP),
# #       by = "CAUSA_DEF"
# #     ) %>% 
# #     left_join(
# #       #lista de básica de defunción 
# #       read.dbf( paste0(path.u, "/", 
# #                        dbf.files[str_detect(dbf.files, "^LISBASMIN")]), 
# #                 as.is = T ) %>% 
# #         rename(LISTA_BAS = CLAVE, causa_LISTA_BAS = DESCRIP),
# #       by = "LISTA_BAS"
# #     ) %>% 
# #     left_join(
# #       #causa de básica de defunción clasificación internacional
# #       read.dbf( paste0(path.u, "/", 
# #                        dbf.files[str_detect(dbf.files, "^DETALLADA")]), 
# #                 as.is = T ) %>% 
# #         rename(MATERNAS = CLAVE, causa_MATERNAS = DESCRIP),
# #       by = "MATERNAS"
# #     )
# #   head(tab.f)
# #   
# #   print(n_distinct(tab.f$causa_LISTA_BAS))
# #   print(n_distinct(tab.f$causa_MATERNAS))
# #   
# #   return(tab.f)
# # })
# # 
# # # intersect colnames 
# # sapply(muertes.l, dim)
# # sapply(muertes.l, names)
# # tab.colnames <- lapply(muertes.l, function(elem){
# #   data.frame(
# #     cols = names(elem), 
# #     year = unique(elem$year), 
# #     stringsAsFactors = F)
# # }) %>% 
# #   rbind_all() %>% 
# #   mutate(loc = 1) %>% 
# #   spread(year, loc)
# # colnames.selec <- tab.colnames$cols[apply(is.na(tab.colnames), 1, sum) == 0]  
# # 
# # # dataframe final
# # defunc_2 <- lapply(muertes.l, function(elem){
# #   print(elem$year %>% unique)
# #   elem.f <- elem %>% 
# #     dplyr::select(one_of(colnames.selec))
# #   elem.f
# #   }) %>% 
# #   rbind_all()
# # 
# # # rdata
# # cache('defunc_2')
# # # sqlite
# # # my_db <- src_sqlite(path = "cache/defunc_2.sqlite3", create = T)
# # # defunc_2_sqlite <- copy_to(my_db, defunc_2, temporary = FALSE)
# # 
