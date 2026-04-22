library(readr)
library(tidyverse)
library(gtExtras)
library(gt)
library(naniar)
library(skimr)
library(moments)

datos <- readRDS("datos_refact.rds")

# v. num: imc_valor; salud_fisica; salud_mental; edad_int

datos %>%
  summarise(
    n = n(),
    Media = mean(imc_valor, na.rm = TRUE),
    Mediana = median(imc_valor, na.rm = TRUE),
    SD = sd(imc_valor, na.rm = TRUE),
    IQR = IQR(imc_valor, na.rm = TRUE), # Robusto
    MAD = mad(imc_valor, na.rm = TRUE), # Ultra-robusto
    Asimetria = skewness(imc_valor, na.rm = TRUE),
    Curtosis = kurtosis(imc_valor, na.rm = TRUE)
  ) %>%
  gt() %>%
  tab_header(
    title = "Análisis Estadístico: Variable IMC",
    subtitle = "Comparativa entre estadísticos clásicos y robustos"
  ) %>%
  cols_label(n = "Registros") %>% 
  fmt_number(columns = everything(), decimals = 2) %>%
  gt_theme_guardian()

'''
Media y mediana similares
SD, IQR, MAD: medidas de dispersión pequeñas (se tienen en cuenta todas al tener media similar a mediana),
poca dispersión de datos.
Asimetría > 0: Sesgo a derecha (cola larga a derecha)
Curtosis 14: Leptocúrtica (datos concentrados en el centro)

Aunque la media y la mediana presentan valores cercanos, 
la asimetría positiva indica un ligero sesgo a la derecha provocado por valores extremos de obesidad.
La mayoría de datos se concentran en la zona central derecha, teniendo poca dispersión, pero al 
tener una curtosis tan elevada (14 >> 3): tenemos una campana Leptocúrtica con "colas pesadas".
'''

calcular_moda <- function(x) {
  x <- x[!is.na(x)] # Elimina NAs para que no de error
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

datos %>%
  summarise(
    n = n(),
    Media = mean(salud_fisica, na.rm = TRUE),
    Mediana = median(salud_fisica, na.rm = TRUE),
    Moda = calcular_moda(salud_fisica), 
    SD = sd(salud_fisica, na.rm = TRUE),
    IQR = IQR(salud_fisica, na.rm = TRUE), # Robusto
    MAD = mad(salud_fisica, na.rm = TRUE), # Ultra-robusto
    Asimetria = skewness(salud_fisica, na.rm = TRUE),
    Curtosis = kurtosis(salud_fisica, na.rm = TRUE)
  ) %>%
  gt() %>%
  tab_header(
    title = "Análisis Estadístico: Variable Salud Física",
    subtitle = "Comparativa entre estadísticos clásicos y robustos"
  ) %>%
  cols_label(n = "Registros") %>% 
  fmt_number(columns = everything(), decimals = 2) %>%
  gt_theme_guardian()

'''
Media y mediana disparejas (mediana = 0).
SD, IQR, MAD: medidas de dispersión pequeñas (teniendo más en cuenta el IQR y MAD al ser más robustos),
MAD = 0, mínima dispersión.
Asimetría > 0: Sesgo a derecha (cola larga a derecha)
Curtosis 6.50: Leptocúrtica (datos concentrados en el centro)

Esta variable presenta una media y mediana disparejas, claramente el tener una mediana = 0 y un MAD = 0.
Esto indica que la mayoría absoluta de la muestra (más del 50%) no reporta días de mala salud física.
La asimetría positiva lo confirma, y la mayoría de datos estan centrados en la zona izquierda, 
teniendo una distribución de cola larga / sesgada.
'''

# salud_mental

datos %>%
  summarise(
    n = n(),
    Media = mean(salud_mental, na.rm = TRUE),
    Mediana = median(salud_mental, na.rm = TRUE),
    Moda = calcular_moda(salud_mental), 
    SD = sd(salud_mental, na.rm = TRUE),
    IQR = IQR(salud_mental, na.rm = TRUE), # Robusto
    MAD = mad(salud_mental, na.rm = TRUE), # Ultra-robusto
    Asimetria = skewness(salud_mental, na.rm = TRUE),
    Curtosis = kurtosis(salud_mental, na.rm = TRUE)
  ) %>%
  gt() %>%
  tab_header(
    title = "Análisis Estadístico: Variable Salud Mental",
    subtitle = "Comparativa entre estadísticos clásicos y robustos"
  ) %>%
  cols_label(n = "Registros") %>% 
  fmt_number(columns = everything(), decimals = 2) %>%
  gt_theme_guardian()

'''
Prácticamente igual que la salud física.
'''

# edad_int

datos %>%
  summarise(
    n = n(),
    Media = mean(edad_int, na.rm = TRUE),
    Mediana = median(edad_int, na.rm = TRUE),
    Moda = calcular_moda(edad_int), 
    SD = sd(edad_int, na.rm = TRUE),
    IQR = IQR(edad_int, na.rm = TRUE), # Robusto
    MAD = mad(edad_int, na.rm = TRUE), # Ultra-robusto
    Asimetria = skewness(edad_int, na.rm = TRUE),
    Curtosis = kurtosis(edad_int, na.rm = TRUE)
  ) %>%
  gt() %>%
  tab_header(
    title = "Análisis Estadístico: Variable Edad",
    subtitle = "Comparativa entre estadísticos clásicos y robustos"
  ) %>%
  cols_label(n = "Registros") %>% 
  fmt_number(columns = everything(), decimals = 2) %>%
  gt_theme_guardian()

'''
edad_int:
Media y mediana prácticamente iguales (no ouliers influyentes)
SD, IQR, MAD: bajos, poca dispersión de datos
Asimetría: sesgo a izquierda (cola larga izquierdas)
Curtosis 2.42: Platicúrtica

Con esta variable obeservamos una dispersión de datos mínima, ya que siguen
una distribución platicúrtica una curva prácticamente plana / constante, sin tener
una concentración elevada en algún punto clave. La gran mayoría de datos están 
concentrados en la zona derecha, con una cola larga a izquierdas. 
'''