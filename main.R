packages <- c("ggplot2", "dplyr", "devtools")
install.packages(setdiff(packages, rownames(installed.packages()))) 

devtools::install_github("https://github.com/hadexversum/HaDeX/tree/dev_1.5")

library(HaDeX)
library(ggplot2)
library(dplyr)

?read_hdx
dat <- read_hdx("KD_190307_hs_Nucb2_EDTA_CaCl2_clusterdata.csv")

## Zapoznaj się ze strukturą danych.
head(dat)

## Sprawdź zawartość danych. 
str(dat)

## Ile jest białek w pliku?
unique(dat[["Protein"]])

## Jakie są stany biologiczne?
unique(dat[["State"]])

## Jakie są punkty czasowe? Które są kontrolami?
unique(dat[["Exposure"]])

## Przelicz dane z widm na masy.
?calculate_exp_masses
tmp <- calculate_exp_masses(dat)  
head(tmp)
str(tmp)

tmp %>%
  filter(Start == 15, End == 33)

##!! Dla wywołań funkcji ponizej, sprawdź dostępne parametry 
##!! w dokumenacji, i wskaż je. Sprawdź, jak zmieniają się wyniki
##!! dla różnych parametrów.
##!! Wykorzystaj pakiet ggplot2 do modyfikacji plotów -
##!! zmień opisy osi, zakresy lub nałóż dane na siebie.

## Policz deuterium uptake dla wszystkich stanów.
?create_uptake_dataset
uptake_dat <- create_uptake_dataset(dat)
head(uptake_dat)

## Zwizualizuj deuterium uptake.
plot_state_comparison(uptake_dat)

## Policz deuterium uptake dla jednego stanu.
st_uptake_dat <- create_state_uptake_dataset(dat,
                                             state = "hs_Nucb2_EDTA")
?plot_butterfly
plot_butterfly(st_uptake_dat)
plot_chiclet(st_uptake_dat)

## Policz różnicowe deuterium uptake.
?create_diff_uptake_dataset()
diff_uptake_dat <- create_diff_uptake_dataset(dat)

## Zwizualizuj różnicowe deuterium uptake.
?plot_differential
plot_differential(diff_uptake_dat)
plot_differential(diff_uptake_dat, all_times = T)

?plot_differential_butterfly
plot_differential_butterfly(diff_uptake_dat)

?plot_differential_chiclet
plot_differential_chiclet(diff_uptake_dat)
