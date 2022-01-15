# CIcomputeR

## Introduction

`CIcomputeR` is a simple package containing functions to calculate the Chou-Talalay combination indices for drug combination data. 

## Web Version

`CIcomputeR` is now available as an R Shiny web application:  https://brianjmpark.shinyapps.io/cicomputer/

## Installation

To install `CIcomputeR`, simply run in your R console:

``` r
install.packages('devtools')
library(devtools)
install_github("snowoflondon/CIcomputeR")
```

Clone this repository by running the following on terminal:

``` bash
git clone https://github.com/snowoflondon/CIcomputeR.git
```

## Quick Run-Through

```r
drug1_name <- 'Magic drug A'
drug2_name <- 'Magic drug B'

mydata_combo <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.042, 0.122, 0.259, 0.532, 0.818))

mydata_mono1 <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = rep(0, 5), 'Response' = c(0.024, 0.256, 0.633, 0.678, 0.932))

mydata_mono2 <- data.frame('Conc1' = rep(0, 5), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.193, 0.244, 0.563, 0.750, 0.921))

mydata <- rbind(mydata_combo, mydata_mono1, mydata_mono2)
mydata$Drug1 <- drug1_name
mydata$Drug2 <- drug2_name

myed <- seq(from = 0.05, to = 0.95, by = 0.05)

res <- computeCI(data = mydata, edvec = myed, frac1 = 500, frac2 = 50, viability_as_pct = FALSE)

p1 <- CIplot(CIdata = res, edvec = c(0.05, 0.95))

p2 <- MEplot(data = mydata, viability_as_pct = FALSE)

```

## References

* https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4759401/
* https://www.combosyn.com/CompuSyn%20Report%20Examples.pdf


## R sessioninfo()

``` r
R version 4.0.5 (2021-03-31)

Platform: x86_64-apple-darwin17.0 (64-bit)

Running under: macOS Big Sur 10.16

Matrix products: default

LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib

locale:
[1] en_CA.UTF-8/en_CA.UTF-8/en_CA.UTF-8/C/en_CA.UTF-8/en_CA.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] tidyr_1.1.3      CIcomputeR_0.1.0 ggplot2_3.3.3    dplyr_1.0.5     

loaded via a namespace (and not attached):
 [1] magrittr_2.0.1   tidyselect_1.1.0 munsell_0.5.0    colorspace_2.0-0
 [5] R6_2.5.0         rlang_0.4.10     fansi_0.4.2      tools_4.0.5     
 [9] grid_4.0.5       gtable_0.3.0     utf8_1.2.1       cli_3.1.0       
[13] DBI_1.1.1        withr_2.4.2      ellipsis_0.3.1   assertthat_0.2.1
[17] tibble_3.1.1     lifecycle_1.0.0  crayon_1.4.1     purrr_0.3.4     
[21] vctrs_0.3.7      glue_1.4.2       compiler_4.0.5   pillar_1.6.0    
[25] generics_0.1.0   scales_1.1.1     pkgconfig_2.0.3 
```
