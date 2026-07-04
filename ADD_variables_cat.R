library(readr)
library(tidyverse)
library(gtExtras)
library(gt)
library(naniar)
library(skimr)

datos <- readRDS("datos_refact.rds")

# Se va a realizar un ADD sobre las variables del dataset
# calculando centralización, dispersión, T.F
# se realiza en un archivo a parte para posteriormente
# elegir las variables que tengan más importancia 
# sobre el análisis.
# (2/3) cat. y num.


############### #####################
# CATEGÓRICAS # # Tablas frecuencias:
############### #####################

### SALUD FÍSICA POR NIVELES ###
datos %>% 
  group_by(salud_fisica_cat) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Clases de Salud Física (Intervalos)",
             subtitle = "Valores de Salud Física, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(salud_fisica_cat = "Salud Física",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
Se observa que la gran mayoría de personas no presentan ningún día 
con problemas de salud física (0 días con molestias generales, dolores...)
siendo un 63.1% (160052 registros).
Aquí vemos como los datos estan sesgados a derechas
(sesgo positivo), indicando que la mayoría de datos se encuentran en 0 (origen)
y tienen una cola larga hacía derecha 
(llegando a la minoría `problemas crónicos`).
Esto nos indica que la mayoría de personas (registros) no han presentado
ningún día con mala salud física.

Las personas con `problemas ocasionales` son una cuarta parte 
de los datos 24.7% (62555 registros). Posiblemente gente con enfermedades/lesiones 
leves, estrés físico/mental, dolores generales.

Por último la minoría de personas tienen `problemas crónicos` siendo un total de 
registros menor que en los otros dos 12.2% (31073), aun siendo un porcentaje menor,
este total de registros es elevado siendo el grupo crítico de estudio y análisis. 
Probablemente aquí se concentren gran parte de los diabéticos.
'''

### salud_general ###
datos %>% 
  group_by(salud_general) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Clases de Salud General",
             subtitle = "Valores de Salud General, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(salud_general = "Salud General",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
Variable balanceada en términos generales, con poca dispersión y alta concentración de 
datos en la zona central.
Presentando la gran mayoría de datos en el centro de las clases (alrededor del 70%).

Zona crítica de análisis: Salud General `Regular` y `Mala`cola derecha (17.2% datos),
donde entran problemas físicos y de cuidado de personas (posibilidad de pre-diabetes ó diabetes).
'''

### salud_mental_cat ###
datos %>% 
  group_by(salud_mental_cat) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Clases de Salud Mental",
             subtitle = "Valores de Salud General, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(salud_mental_cat = "Salud Mental",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
Variable sesgada a derechas (sesgo positivo), concentrando un 69.3% de datos en el origen (0 días).
Con una cola larga hasta los 30 días, disminuyendo de manera progresiva.

Clases críticas: `Problemas crónicos` 9.2% de los datos (problemas entre 15 a 30 días). 
Aunque los problemas ocasionales representan una parte significativa de la muestra, 
el grupo de afección crónica se identifica como el nicho crítico de estudio.
'''


### DIABETES (V. OBJ) ###
datos %>% 
  group_by(diabetes) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Clases de Diabetes",
             subtitle = "Valores de Diabetes, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(diabetes = "Tipos / Niveles de Diabetes",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
La alta concentración está en el tipo `No diabético`. Esto nos indica 
un fuerte desbalanceo de clases, concentrando un 84.2% (213703 regsitros)
de los datos en esta zona (siendo un total de registros de este tipo extremadamente elevado).

El tipo de registro `Pre-diabetes` en este estudio es mínimo, siendo un 1.8% (4631 registros),
probablemente sean personas de indicios a una pre-diabetes tipo 2 o gente que desconoce que tiene
diabetes.

Por último el tipo de registro `Diabetes` se compone de un 13.9% (35346) de los datos. Algo 
elevado que puede dar pie posteriormente a encontrar relaciones/correlaciones con otras variables
para la realización del análisis (de forma bivariante con otras variables). Esta es nuestro tipo
de registro crítico / de estudio.
'''

### IMC CAT (Intervalos) ###
datos %>% 
  group_by(imc_cat) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Clases de IMC (Intervalos)",
             subtitle = "Clases/Intervalos de IMC, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(imc_cat = "Intervalos IMC",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
Las clases de esta variable (derivada de la clase numérica `imc_valor`) 
presentan un balanceo de datos general entre
un IMC 18.5 (inicio a peso normal) y > 30 (obesidad). Teniendo un total de datos repartidos
de la siguiente forma: 
  Peso normal (IMC entre 18.5-24.9): 27.2%
  Sobrepeso (IMC 25-29.9): 37.0%
  Obesidad (IMC > 30): 34.6%
(98.8% de los datos)

La clase altamente desbalanceada es: Bajo peso (IMC < 18.5): 1.2%.

Las clases críticas de estudio son para valores con un IMC > 25 (+ 70% de datos), 
donde entramos en zonas de sobrepeso
y obesidad. El nivel de datos es alto y similar (útil para ANOVA), 
por lo que realizar un análisis bivariante y inferencia con esta
variable (numérica ó esta categórica, dependiendo del caso) será clave. 
'''

### VARIABLES BINARIAS (CATEGÓRICAS; Sí, No) ###
# Recopilamos todas las binarias en una sola tabla de comparación
datos %>%
  select(presion_arterial_alta, colesterol_alto, chequeo_colesterol, ataque_cerebral, 
         ataque_cardiaco, actividad_fisica, consumo_de_fruta, consumo_de_verduras, 
         consumo_de_alcohol_alto, seguro_medico, no_acudir_al_medico_por_coste, 
         dificultad_caminar, fumador) %>%
  pivot_longer(everything(), names_to = "Variable", values_to = "Respuesta") %>%
  group_by(Variable, Respuesta) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(Variable) %>%
  mutate(Porcentaje = n / sum(n)) %>%
  filter(Respuesta %in% c("No", "Sí")) %>% # Nos enfocamos en la prevalencia del factor de riesgo
  arrange(desc(Porcentaje)) %>%
  gt() %>% 
  gt_theme_guardian() %>%
  tab_header(title = "Factores de Riesgo y Hábitos (Binarios)",
             subtitle = "Porcentaje de respuestas en la muestra total") %>%
  fmt_percent(columns = Porcentaje, decimals = 1) %>%
  cols_label(n = "Frecuencias Absoluta (Sí/No)", Porcentaje = "Porcentaje (%)")

'''
Variables con desbalanceo de datos al valor crítico de estudio `Sí` extremadamente elevado:
    - chequeo_colesterol (96.3% Sí)
    - seguro_medico (95.1% Sí)
    - consumo_de_verduras (81.1% Sí)

Variables con desbalanceo de datos al valor crítico de estudio `No` extremadamente elevado:
    - ataque_cerebral (95.9% No)
    - consumo_de_alcohol_alto (94.4% No)
    - no_acudir_al_medico_por_coste (91.6% No)
    - ataque_cardiaco (90.6% No)
    - dificultad_caminar (83.2% No)

Variables balanceadas en Sí/No:
    - fumador (55.7% No; 44.3% Sí)
    - presion_arterial_alta (57.1% No; 42.9% Sí)
    - colesterol_alto (57.6% No; 42.4% Sí)
    - consumo_de_fruta (63.4% No; 36.6% Sí)
    - actividad_fisica (75.5% Sí; 24.3% No)


De nuevo, el desbalanceo de datos da pie a realizar posteriormente análisis más profundos bivariantes
para tener correlaciones entre las distintas variables binarias y otras numéricas ó categóricas. 
Las variables más interesantes para análisis y estudio son: 
  - fumador, presion_arterial_alta, colesterol_alto, actividad_fisica

Estas son las variables de estudio más robustas, ya que tienen un balanceo de datos muy elevado,
lo que permite realizar análisis bivariantes y modelados con grupos equilibrados.

Las variables más críticas:
  - chequeo_colesterol, seguro_medico, ataque_cerebral, consumo_de_alcohol_alto, no_acudir_al_medico_por_coste
    ataque_cardiaco

Estas son las variables de estudio más desbalanceadas y críticas para un análisis estadístico. Tienen sucesos muy 
minoritarios en comparación, pero de alta gravedad.

Variables punto intermedio:
  - consumo_de_fruta, dificultad_caminar, consumo_de_verduras

Estas variables están en un punto intermedio entre el desbalanceo máximo y un balanceo estándar (50/50; 60/40)

Dependiendo el análisis y enfoque estadístico, todas las variables son útiles en unos casos y otros. No se deben 
obviar ningunas.
'''

# salud_general, salud_mental_cat, sexo, edad_label, nivel_educacion, nivel_de_ingresos

### sexo ###
datos %>% 
  group_by(sexo) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Sexos",
             subtitle = "Registros Mujeres y Hombres, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(sexo = "Sexos",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
clases balanceada, sin mayor importancia. Útiles para estudios y análisis.
'''

### edad_label ###
datos %>% 
  group_by(edad_label) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Categorías de Edades",
             subtitle = "Edades, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(edad_label = "Edades",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
Variable con sesgo negativo (sesgado a izquierdas). 
Concentración de datos en zona adulta (50 a 70 años: 57.7% datos).
Zona de crítica de análisis: > 50 años (mayoría de datos + 80%).
En base a su distribución, y al ser edades es una variable muy útil como predictora en Regresiones.
'''

### nivel_de_educacion ###
datos %>% 
  group_by(nivel_de_educacion) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Niveles de Educación",
             subtitle = "Valores en Clases, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(nivel_de_educacion = "Niveles",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

  '''
  Variable desbalanceada. Mayoría de datos en gente con estudios.
  94.6% de los datos con secundaria completa como mínimo (hasta universitarios licenciados). 

  Clases cŕiticas de análisis: Gente sin estudios, con estudios primarios o 
  secundaria incompleta, 5.4% de los datos. Siendo gente que tal vez no tenga recursos
  o conocimentos básicos en cudidados físicos, mentales, médicos, etc.  

  Esta variable nos 
  permitirá ver si el nivel educativo actúa como un factor protector frente a la enfermedad.
  '''

### nivel_de_ingresos ###
datos %>% 
  group_by(nivel_de_ingresos) %>%
  summarise(
    Frequency_Abs = n(),
  ) %>% 
  mutate(
    Frequency_Abs_Accumulate = cumsum(Frequency_Abs),
    Frequency_Rel = Frequency_Abs / sum(Frequency_Abs),
    Frequency_Rel_Accumulate =  cumsum(Frequency_Rel)
  ) %>%
  gt() %>% 
  gt_theme_guardian() %>% 
  tab_header(title = "Niveles de Ingresos",
             subtitle = "Ingresos, Frecuencias Relativas y Acumuladas") %>%
  fmt_percent(columns = c(Frequency_Rel, Frequency_Rel_Accumulate), decimals = 1) %>%
  cols_label(nivel_de_ingresos = "Intervalos/Niveles de Ingreso",
             Frequency_Abs = "Frecuencia Absoluta", 
             Frequency_Abs_Accumulate = "Frecuencia Absoluta Acumulada",
             Frequency_Rel = "Frecuencia Relativa",
             Frequency_Rel_Accumulate = "Frecuencia Relativa Acumulada")

'''
Variable desbalanceada. Mayoría de datos con gente de altos niveles de ingreso.
77.2% de los datos para gente con ingresos > 25k.

Niveles críticos: Gente con pocos ingresos, < 25k. Probablemente gente que no pueda
pagarse seguros de médico privados (en caso de no haber públicos), gente con recursos 
mínimos y propensos a tener un cuidado inferior a gente con altos ingresos.

Esta variable nos permitirá
ver si el ingreso actúa como un factor protector frente a las enfermedades. Útil para realizar
un ANOVA de dos vías con `nivel_de_estudios`, ya que generalmente suelen ir relacionados estos factores.
'''


'''
Resumen de variables categórica para Qmd:

- Indicar que `nivel_de_estudios` y `nivel_de_ingresos` tienen datos similares, útil para ANOVA
de dos vías.

- Edad tipo de variable útil como variable predictora para regresiones por su distribución y tipo de dato. 
  Útil para relacionar con IMC. 

- Variables Binarias: Dependiendo el análisis y enfoque estadístico, todas las variables son útiles en unos casos y otros. 
  No se deben obviar ningunas. 

- `salud_mental_cat`, `salud_fisica_cat` y `salud_general` distribución de datos similares, pueden tener 
  correlación. Útiles para regresiones.

- `diabetes` variable desbalanceada, teniendo la clase de diabéticos minoritaria. Útil para relacionar en ANOVA
  con IMC, y las diferentes variables de salud (numéricas, no las categóricas).  
'''