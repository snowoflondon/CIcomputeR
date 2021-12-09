#This function takes dataframe containing drug combination data, consisting of N
#required columns:
#`Conc1`: Dosage of drug A
#`Conc2`: Dosage of drug B
#`Response`: Measured viability (as a percentage or decimal value)
#`Drug1`: Name of drug corresponding to Conc1
#`Drug2`: Name of drug corresponding to Conc2
#Note the single dataframe must contain the monotherapy rows (one of Conc1 or Conc2
#equates to zero) as well as the combination data
#Additional arguments:
#viability_as_pct: a logical value, set TRUE if viability measurements are
#in percentages (e.g., 78.4) or FALSE if decimal value (0.784)
#Output: a ggplot object containing the median-effect plot (Chou plot)
#where the antilog of the x-intercept corresponds to Dm

MEplot <- function(data, viability_as_pct){
  require(ggplot2)
  require(dplyr)
  require(tidyr)

  if (viability_as_pct == TRUE){
    data <- data %>% mutate(Response = Response/100)
  }
  data <- data %>% filter(Response < 1)
  dfc <- data %>% filter(Conc1 !=0 & Conc2 !=0)
  df1 <- data %>% filter(Conc1 !=0 & Conc2 ==0)
  df2 <- data %>% filter(Conc1 ==0 & Conc2 !=0)
  dfc <- dfc %>% mutate(Conc = Conc1 + Conc2) %>%
    unite('Drug', c(Drug1, Drug2), sep = ' + ') %>%
    select(Drug, Conc, Response)
  df1 <- df1 %>% rename(Conc = Conc1, Drug = Drug1) %>%
    select(Drug, Conc, Response)
  df2 <- df2 %>% rename(Conc = Conc2, Drug = Drug2) %>%
    select(Drug, Conc, Response)
  df <- bind_rows(dfc, df1, df2)
  p <- ggplot(df, aes(x = log(Conc), y = log((1/Response)-1),
                      color = Drug, shape = Drug)) +
    geom_point() +
    geom_smooth(method = 'lm', se = FALSE, fill = NA) +
    theme_classic() + xlab('log (Dose)') + ylab('log (Fa/Fu)') +
    theme(legend.position = 'bottom')
  print(p)
}
