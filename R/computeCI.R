#This function takes dataframe containing drug combination data, consisting of N
#required columns:
#`Conc1`: Dosage of drug A
#`Conc2`: Dosage of drug B
#`Response`: Measured viability (as a percentage or decimal value)
#Note the single dataframe must contain the monotherapy rows (one of Conc1 or Conc2
#equates to zero) as well as the combination data
#Additional arguments:
#`edvec`: numeric vector containing ED values to calculate CI values at
#frac1 and frac2: numeric values denoting mixture ratios of drug A and drug B
#(e.g., if drug A and drug B are 100:1 mixture ratio, frac1 = 100 and frac2 = 1)
#viability_as_pct: a logical value, set TRUE if viability measurements are
#in percentages (e.g., 78.4) or FALSE if decimal value (0.784)
#Output: a dataframe containing two columns: `ED` and `CI`


computeCI <- function(data, edvec, frac1, frac2, viability_as_pct){
  require(dplyr)
  if (viability_as_pct == TRUE){
    data <- data %>% mutate(Response = Response/100)
  }

  dfc <- data %>% filter(Conc1 !=0 & Conc2 !=0)
  df1 <- data %>% filter(Conc1 !=0 & Conc2 ==0)
  df2 <- data %>% filter(Conc1 ==0 & Conc2 !=0)
  dfc <- dfc %>% mutate(ConcC = Conc1 + Conc2)

  fitc <- lm(log((1/Response)-1) ~ log(ConcC), data = dfc)
  Dmc <- exp(-(fitc$coefficients[1])/(fitc$coefficients[2]))[[1]]
  fit1 <- lm(log((1/Response)-1) ~ log(Conc1), data = df1)
  Dm1 <- exp(-(fit1$coefficients[1])/(fit1$coefficients[2]))[[1]]
  fit2 <- lm(log((1/Response)-1) ~ log(Conc2), data = df2)
  Dm2 <- exp(-(fit2$coefficients[1])/(fit2$coefficients[2]))[[1]]

  CIvec <- numeric()
  for (i in 1:length(edvec)){
    Dmcf <- Dmc*(((1-(1-edvec[i]))/(1-edvec[i]))^(1/fitc$coefficients[2][[1]]))
    Dm1f <- Dm1*(((1-(1-edvec[i]))/(1-edvec[i]))^(1/fit1$coefficients[2][[1]]))
    Dm2f <- Dm2*(((1-(1-edvec[i]))/(1-edvec[i]))^(1/fit2$coefficients[2][[1]]))
    Da <- Dmcf*(frac1/(frac1 + frac2))
    Db <- Dmcf*(frac2/(frac1 + frac2))
    CombIndex <- (Da/Dm1f) + (Db/Dm2f)
    CIvec[i] <- CombIndex
  }

  res <- data.frame('ED' = edvec, 'CI' = CIvec)
  return(res)

}
