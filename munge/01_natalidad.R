
# Natalidad: Nacimientos INEGI
# Init: 06/01/2017
# SGMC

# 0. Archivos nacimientos
# 1. Defunciones 1998 a 2015

# 0. Archivos nacimientos
path.str <- "data/natalidad_base_datos/"
files.noms.aux <- list.files(path.str)[!str_detect(list.files(path.str), ".zip")]
parse_number(files.noms.aux)

my_db <- src_sqlite(path = "data/salud_reproductiva.db", create = T)
my_db # tablas



# 1. Defunciones 1998 a 2015
files.noms <- files.noms.aux[parse_number(files.noms.aux) >= 1998]
lapply(files.noms[1:3], function(file.u){
  # file.u <- files.noms[25]
  print(file.u)
  dbf.files <- list.files( paste0(path.str,file.u))
  path.u <- paste(path.str, file.u, sep = "/")
  dat <- read.dbf( paste0(path.u, "/", dbf.files[str_detect(dbf.files, "^NACIM")]),
                   as.is = T )
  tab.f <- dat %>% 
    mutate(filenom = file.u) %>% 
    # a caracter para evitar problemas en bind_rows
    mutate_all(.funs = as.character) 
  }) %>% 
  bind_rows() %>% 
  db_insert_into( con = my_db$con, table = "nacimientos", values = .) # insert into



# 
# sapply(nacimientos.l, dim)
# sapply(nacimientos.l, names)
# 
# tab.colnames <- lapply(nacimientos.l, function(elem){
#   data.frame(
#     cols = names(elem), 
#     year = unique(elem$year), 
#     stringsAsFactors = F)
#   }) %>% 
#   rbind_all() %>% 
#   mutate(loc = 1) %>% 
#   spread(year, loc)
# colnames.selec <- tab.colnames$cols[apply(is.na(tab.colnames), 1, sum) == 0]  
# write_csv(data.frame(colnames.selec), "doc/colnames_nac1.csv")
# 
# sapply(nacimientos.l, function(elem){
#   print(elem$year %>% unique)
#   elem.f <- elem %>% 
#     dplyr::select(one_of(colnames.selec))
#   sapply(elem.f, class)
# })
# 
# # dataframe final
# nacim_1 <- lapply(nacimientos.l, function(elem){
#     print(elem$year %>% unique)
#     elem.f <- elem %>% 
#       dplyr::select(one_of(colnames.selec))
#     elem.f
#   }) %>% 
#   rbind_all()
# head(nacim_1)
# apply(is.na(nacim_1), 2, sum)
# 
# nacim_2 <- lapply(nacimientos.l, function(elem){
#     print(elem$year %>% unique)
#     elem.f <- elem %>% 
#       dplyr::select(one_of(colnames.selec))
#     elem.f
#   }) %>% 
#   rbind_all()
# head(nacim_2)
# apply(is.na(nacim_2), 2, sum)
