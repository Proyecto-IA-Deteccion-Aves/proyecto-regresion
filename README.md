# Proyecto Modelos de Regresión

[![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)](https://www.r-project.org/)
[![Quarto](https://img.shields.io/badge/Quarto-39729E?style=for-the-badge&logo=quarto&logoColor=white)](https://quarto.org/)
[![Dataset Kaggle](https://img.shields.io/badge/Dataset-Kaggle-20BEFF?style=for-the-badge&logo=kaggle&logoColor=white)]([https://www.kaggle.com/](https://www.kaggle.com/datasets/alexteboul/diabetes-health-indicators-dataset))

Repositorio del trabajo de análisis estadístico e inferencial sobre el dataset **Diabetes Health Indicators** de Kaggle. El proyecto está desarrollado en **R** y **Quarto**, y combina preparación de datos, refactorización de variables, análisis descriptivo y generación de informe en HTML/PDF.

## Objetivo

El objetivo principal es estudiar la relación entre distintos indicadores de salud, hábitos y variables sociodemográficas con el estado de diabetes, partiendo de un conjunto de datos amplio y ya limpio. El flujo del proyecto incluye:

- lectura del dataset original,
- limpieza y estandarización de variables,
- creación de variables derivadas y categorías interpretables,
- análisis univariante y bivariante,
- generación del informe final con Quarto.

## Dataset

El conjunto de datos procede de Kaggle y contiene indicadores de salud del estudio BRFSS 2015. En este proyecto se trabaja con la versión de **250000 registros**, seleccionada por ser la más equilibrada de las disponibles.

Archivos de datos principales:

- `Data_Sets/diabetes_012_health_indicators_BRFSS2015.csv`
- `datos_refact.csv`
- `datos_refact.rds`

## Estructura del proyecto

- `Analisis_Completo.Qmd`: documento principal del informe.
- `Clasificacion_Datos.R`: refactorización y preparación inicial de variables.
- `ADD_variables_num.R`: análisis estadístico de variables numéricas.
- `ADD_variables_cat.R`: tablas de frecuencias y análisis de variables categóricas.
- `references.bib` y `apa.csl`: bibliografía y estilo de citas (necesario para generar el`.html` completo).
- `imagenes/`: carpeta para figuras y recursos gráficos.
- `Data_Sets/`: carpeta de los datasets del proyecto (todos los de [Kaggle](https://www.kaggle.com/)).

## Flujo de trabajo

1. Se carga el dataset original desde `Data_Sets/`.
2. Se renombraron variables para hacerlas más legibles en español.
3. Se transformaron variables numéricas a factores o categorías cuando aportaban más interpretación.
4. Se generaron variables derivadas como `edad_label`, `salud_fisica_cat`, `salud_mental_cat` e `imc_cat`.
5. Se ordenó el dataset final por bloques temáticos para facilitar el análisis.
6. Se elaboró el informe con tablas, métricas descriptivas y conclusiones.

## Requisitos

Necesitas tener instalado:

- R
- RStudio o cualquier entorno compatible con Quarto
- Paquetes usados en el proyecto, entre ellos:
  - `tidyverse`
  - `janitor`
  - `gt`
  - `gtExtras`
  - `naniar`
  - `skimr`
  - `moments`
  - `hexbin`
  - `pacman`

### Instalación de librerías en R

Si no tienes instalados los paquetes, puedes ejecutar esto una sola vez en la consola de R:

```r
install.packages(c("tidyverse", "janitor", "gt", "gtExtras", "naniar", "skimr", "moments", "hexbin", "pacman"))
```

Después, cárgalos en cada sesión con:

```r
library(tidyverse)
library(janitor)
library(gt)
library(gtExtras)
library(naniar)
library(skimr)
library(moments)
library(hexbin)
library(pacman)
```

## Cómo ejecutar el proyecto

Si quieres reproducir el análisis completo:

1. Abre el archivo `Proyecto.Rproj` en RStudio para visualizar la parte inicial del proyecto.
2. Ejecuta `Clasificacion_Datos.R` para generar `datos_refact.rds` y `datos_refact.csv` y obtener de tal forma los datasets con los que se trabaja sobre el proyecto.
3. Ejecuta `ADD_variables_num.R` y `ADD_variables_cat.R` si quieres revisar el análisis exploratorio por separado.
4. Renderiza `Analisis_Completo.Qmd` para obtener el informe final en HTML o PDF.

## Resultados

El proyecto deja como salida principal un informe completo sobre el comportamiento de las variables de salud, con especial atención a:

- distribución del IMC,
- estado de salud física y mental,
- balance de clases en la variable objetivo `diabetes`,
- análisis de variables categóricas y cuantitativas.

## Nota sobre la visualización

El archivo HTML final puede requerir descarga local para verse correctamente.

## Autores

- Lucas Virgillito Tarrazó
- José Igual Ávila
- Marc Mollá Lillo
