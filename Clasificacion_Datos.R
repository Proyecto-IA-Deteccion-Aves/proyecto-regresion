# read kaggle description df 
# explore df (variables, rows, NA...)
# rename variable
# change variable type
# reorder variable

library(readr)
library(tidyverse)
library(gtExtras)
library(gt)
library(naniar)

datos1 <- read_csv("/home/ebob/Personal_Lucas/IA/Primer_Curso/Segundo_Cuatri/Modelos_Regresion/Prácticas/Proyecto/Data_Sets/diabetes_012_health_indicators_BRFSS2015.csv")
View(datos1)
glimpse(datos1)

# Don't have NA values
datos1 %>% 
  filter(if_any(everything(), is.na)) %>% 
  View

# Table 
miss_var_summary(datos1) %>%
  gt() %>% 
  gt_theme_guardian()

# Graph NA's
gg_miss_var(datos1)

# Change name variables
datos1_refact_names <- datos1 %>% 
  rename(
    "diabetes" = "Diabetes_012",
    "presion_arterial_alta" = "HighBP",
    "colesterol_alto" = "HighChol",
    "chequeo_colesterol" = "CholCheck",
    "imc_valor" = "BMI",
    "fumador" = "Smoker",
    "ataque_cerebral" = "Stroke",
    "ataque_cardiaco" = "HeartDiseaseorAttack",
    "actividad_fisica" = "PhysActivity",
    "consumo_de_fruta" = "Fruits",
    "consumo_de_verduras" = "Veggies",
    "consumo_de_alcohol_alto" = "HvyAlcoholConsump",
    "seguro_medico" = "AnyHealthcare",
    "no_acudir_al_medico_por_coste" = "NoDocbcCost",
    "salud_general" = "GenHlth",
    "salud_mental" = "MentHlth",
    "salud_fisica" = "PhysHlth",
    "dificultad_caminar" = "DiffWalk",
    "sexo" = "Sex",
    "edad" = "Age",
    "nivel_de_educacion" = "Education",
    "nivel_de_ingresos" = "Income") %>% 
  glimpse()

# refact variables
df_refact <- datos1_refact_names %>% 
  select(everything()) %>%
  mutate(
    diabetes = factor(diabetes, levels = c(0, 1, 2), labels = c("No diabético",
                                                                        "Pre-diabetes",
                                                                        "Diabetes")),
    across(c(presion_arterial_alta, colesterol_alto, chequeo_colesterol, ataque_cerebral, ataque_cardiaco, actividad_fisica, 
             consumo_de_fruta, consumo_de_verduras, consumo_de_alcohol_alto, seguro_medico, no_acudir_al_medico_por_coste, dificultad_caminar), 
           ~ factor(.x, levels = c(0, 1), labels = c("No", "Sí"))),
    fumador = factor(fumador, levels = c(0, 1), labels = c("No", "Sí")),
    salud_general = factor(salud_general, levels = c(1, 2, 3, 4, 5), labels = c("Excelente",
                                                                    "Muy Buena",
                                                                    "Buena",
                                                                    "Regular",
                                                                    "Mala"
                                                                    )),
    sexo = factor(sexo, levels = c(0, 1), labels = c("Mujer", "Hombre")),
    edad_int = as.integer(edad),
    salud_mental_cat = cut(salud_mental, breaks = c(-Inf, 0, 14, 30), labels = c("Excelente Salud (0 días)", "Problemas ocasionales (1-14 días)", "Problemas crónicos (15-30 días)"),
      include.lowest = TRUE),
    salud_fisica_cat = cut(salud_fisica, breaks = c(-Inf, 0, 14, 30), labels = c("Excelente Salud (0 días)", "Problemas ocasionales (1-14 días)", "Problemas crónicos (15-30 días)"),
      include.lowest = TRUE),
    imc_cat = cut(imc_valor, breaks = c(-Inf, 18.5, 25, 30, Inf), labels = c("Bajo peso (IMC < 18.5)", "Peso normal (IMC entre 18.5-24.9)", "Sobrepeso (IMC 25-29.9)", "Obesidad (IMC > 30)"),
      right = FALSE),
    edad_label = factor(edad, levels = 1:13, labels = c("18-24","25-29", "30-34", "35-39", "40-44", 
                                                      "45-49", "50-54", "55-59", "60-64", "65-69", 
                                                      "70-74", "75-79", "80+"
                                                      )),
    nivel_de_educacion = factor(nivel_de_educacion, levels = c(1, 2, 3, 4, 5, 6), labels = c("Sin Estudios",
                                                                        "Estudios Primarios",
                                                                        "Secundaria (Incompleta)",
                                                                        "Secundaria (Completa)",
                                                                        "Universitaria (Incompleta)",
                                                                        "Universitaria (Completa)")),
    nivel_de_ingresos = factor(nivel_de_ingresos, levels = c(1, 2, 3, 4, 5, 6, 7, 8), labels = c("< 10k",
                                                                           "10k - 15k",
                                                                           "15k - 20k",
                                                                           "20k - 25k",
                                                                           "25k - 35k",
                                                                           "35k - 50k",
                                                                           "50k - 75k",
                                                                           "> 75k"
                                                                           ))
    )
View(df_refact)

# order the df
df_final <- df_refact %>% 
  select(diabetes, presion_arterial_alta, colesterol_alto, chequeo_colesterol, imc_valor, imc_cat, # clinic health
         ataque_cerebral, ataque_cardiaco, actividad_fisica, salud_fisica, salud_fisica_cat, salud_general, salud_mental, salud_mental_cat, # activity & health
         seguro_medico, no_acudir_al_medico_por_coste, dificultad_caminar, # health & doctor
         fumador, consumo_de_alcohol_alto, consumo_de_fruta, consumo_de_verduras, # consumes
         sexo, edad_label, edad_int, nivel_de_educacion, nivel_de_ingresos) # demographics & economics
View(df_final)

# write the new df
write.csv(df_final, "/home/ebob/Personal_Lucas/IA/Primer_Curso/Segundo_Cuatri/Modelos_Regresion/Prácticas/Proyecto/datos_refact.csv", 
          row.names = FALSE, fileEncoding = "UTF-8")
saveRDS(df_final, "datos_refact.rds")
