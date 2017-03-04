
# Natalidad: Nacimientos INEGI
# Init: 06/01/2017
# SGMC

# 0. Archivos nacimientos
# 1. Defunciones 1990 a 2015

# 0. Archivos nacimientos
path.str <- "data/natalidad_base_datos/"
files.noms.aux <- list.files(path.str)[!str_detect(list.files(path.str), ".zip")]
parse_number(files.noms.aux)

# 1. Defunciones 1990 a 2015
files.noms <- files.noms.aux[parse_number(files.noms.aux) <= 2015]

nacimientos.l <- lapply(files.noms, function(file.u){
  # file.u <- files.noms[25]
  # file.u
  print(file.u)
  
  dbf.files <- list.files( paste0(path.str,file.u))
  path.u <- paste(path.str, file.u, sep = "/")
  
  dat <- read.dbf( paste0(path.u, "/", dbf.files[str_detect(dbf.files, "^NACIM")]),
                   as.is = T )
  head(dat)
  
  tab.f <- dat %>% 
    mutate(year = parse_number(file.u),
            ENT_OCURR  = parse_number(ENT_OCURR ), 
            ENT_REGIS  = parse_number(ENT_REGIS ), 
            ENT_RESID  = parse_number(ENT_RESID ), 
            MUN_OCURR  = parse_number(MUN_OCURR ), 
            MUN_REGIS  = parse_number(MUN_REGIS ), 
            MUN_RESID  = parse_number(MUN_RESID )
    )
  
  print(dim(tab.f))
  
  return(tab.f)
})
sapply(nacimientos.l, dim)
sapply(nacimientos.l, names)

tab.colnames <- lapply(nacimientos.l, function(elem){
  data.frame(
    cols = names(elem), 
    year = unique(elem$year), 
    stringsAsFactors = F)
  }) %>% 
  rbind_all() %>% 
  mutate(loc = 1) %>% 
  spread(year, loc)
colnames.selec <- tab.colnames$cols[apply(is.na(tab.colnames), 1, sum) == 0]  
write_csv(data.frame(colnames.selec), "doc/colnames_nac1.csv")

sapply(nacimientos.l, function(elem){
  print(elem$year %>% unique)
  elem.f <- elem %>% 
    dplyr::select(one_of(colnames.selec))
  sapply(elem.f, class)
})

# dataframe final
nacim_1 <- lapply(nacimientos.l, function(elem){
    print(elem$year %>% unique)
    elem.f <- elem %>% 
      dplyr::select(one_of(colnames.selec))
    elem.f
  }) %>% 
  rbind_all()
head(nacim_1)
apply(is.na(nacim_1), 2, sum)

nacim_2 <- lapply(nacimientos.l, function(elem){
    print(elem$year %>% unique)
    elem.f <- elem %>% 
      dplyr::select(one_of(colnames.selec))
    elem.f
  }) %>% 
  rbind_all()
head(nacim_1)
apply(is.na(nacim_1), 2, sum)
