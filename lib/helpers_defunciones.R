# Auxiliares de recode


# Escolaridad
rec_escolaridad <- str_replace_all(
  "1 = 'Sin escolaridad'
  ;2 = 'Menos de tres años de primaria'
  ;3 = 'De 3 a 5 años de primaria'
  ;4 = 'Primaria completa'
  ;5 = 'Secundaria o equivalente'
  ;6 = 'Preparatoria o equivalente'
  ;7 = 'Profesional'
  ;8 = 'No aplica a menores de 6 años'
  ;9 = 'No especificada'", 
  "\n", "")

# Ocupacion
rec_ocupacion_1 <- str_replace_all("2  = 'No trabaja'
  ;11 = 'Profesionistas'
  ;12 = 'Técnicos'
  ;13 = 'Trabajadores de la educación'
  ;14 = 'Trabajadores del arte, deportes y espectáculos'
  ;21 = 'Funcionarios y directivos'
  ;41 = 'Trabajadores en actividades agrícolas, ganaderas, caza y pesca'
  ;51 = 'Personal de control en el proceso de producción industrial'
  ;52 = 'Trabajadores en la industria de la transformación'
  ;53 = 'Operadores de maquinaria fija'
  ;54 = 'Ayudantes en el proceso de producción industrial y artesanal'
  ;55 = 'Conductores de maquinaria móvil y medios de transporte'
  ;61 = 'Trabajadores administrativos de nivel intermedio'
  ;62 = 'Trabajadores administrativos de nivel inferior'
  ;71 = 'Comerciantes, empleados de comercio y agentes de ventas'
  ;72 = 'Vendedores ambulantes'
  ;81 = 'Trabajadores en servicios personales en establecimientos'
  ;82 = 'Trabajadores en servicios domésticos'
  ;83 = 'Trabajadores de fuerzas armadas, protección y vigilancia'
  ;97 = 'No aplica a menores de 12 años'
  ;98 = 'Insuficientemente especificada'
  ;99 = 'No especificada'", 
  "\n", "")

rec_ocupacion_3 <- str_replace_all(
  "2  = 'No trabaja'
  ;11 = 'Profesionistas'
  ;12 = 'Técnicos'
  ;13 = 'Trabajadores de la enseñanza'
  ;14 = 'Trabajadores del arte, espectáculos y deportes'
  ;21 = 'Funcionarios superiores de la administración pública'
  ;22 = 'Funcionarios superiores y propietarios del sector privado excepto agropecuario'
  ;31 = 'Administradores y propietarios del sector agropecuario'
  ;41 = 'Capataces y mayorales en el proceso de producción agropecuaria'
  ;42 = 'Trabajadores directos en el proceso de producción agropecuaria'
  ;43 = 'Personal de apoyo en el proceso de producción agropecuaria'
  ;51 = 'Personal de control en el proceso de producción industrial'
  ;52 = 'Trabajadores directos en el proceso de producción industrial'
  ;53 = 'Ayudantes en el proceso de producción industrial'
  ;61 = 'Trabajadores administrativos de nivel medio e inferior'
  ;71 = 'Vendedores, dependientes y agentes de ventas'
  ;72 = 'Vendedores sin establecimiento fijo'
  ;81 = 'Trabajadores en servicios al público, excepto doméstico'
  ;82 = 'Trabajadores en servicios domésticos'
  ;83 = 'Operadores de equipo de transporte, excepto particulares'
  ;84 = 'Trabajadores de fuerzas armadas, protección y vigilancia'
  ;98 = 'No clasificadas anteriormente'
  ;99 = 'No especificada'",        
  "\n", "")



# Estado Civil
rec_edocivil_3 <- str_replace_all(
  "1 = 'Soltero(a)'
  ;2 = 'Casado(a)'
  ;3 = 'Unión libre'
  ;4 = 'Separado(a)'
  ;5 = 'Divorciado(a)'
  ;6 = 'Viudo(a)'
  ;9 = 'No especificado'",
  "\n", ""
)
