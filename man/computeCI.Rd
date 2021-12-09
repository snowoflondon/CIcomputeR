\name{computeCI}
\alias{computeCI}

\title{
Combination Index Calculation
}
\description{
Takes a dataframe containing drug combination data and calculates combination indices at specified effective doses.
}
\usage{
computeCI(data, edvec, frac1, frac2, viability_as_pct)
}

\arguments{
  \item{data}{A dataframe containing drug combination assay data. It should contain columns:

  'Conc1': dosage of drug A;

  'Conc2': dosage of drug B;

  'Response': measured viability - as a percentage or a decimal value;

  'Drug1': name of first drug;

  'Drug2': name of second drug.

}

  \item{edvec}{A numeric vector containing the ED values to calculate CI at.
}

  \item{frac1}{A numeric value denoting mixture ratio of drug A relative to drug B.
}

  \item{frac2}{A numeric value denoting mixture ratio of drug B relative to drug A.
}

  \item{viability_as_pct}{A logical value; set TRUE if viability measurements are in percentages; FALSE if in decimals.
}

}

\value{A dataframe containing two columns; ED and CI - combination indices at each specified EDs.
}

\examples{
\dontrun{
drug1_name <- 'Drug A'
drug2_name <- 'Drug B'
mydata_combo <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.042, 0.122, 0.259, 0.532, 0.818))

mydata_mono1 <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = rep(0, 5), 'Response' = c(0.024, 0.256, 0.633, 0.678, 0.932))

mydata_mono2 <- data.frame('Conc1' = rep(0, 5), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.193, 0.244, 0.563, 0.750, 0.921))

mydata <- rbind(mydata_combo, mydata_mono1, mydata_mono2)
mydata$Drug1 <- drug1_name
mydata$Drug2 <- drug2_name

myed <- seq(from = 0.05, to = 0.95, by = 0.05)

res <- computeCI(data = mydata, edvec = myed, frac1 = 500, frac2 = 50, viability_as_pct = FALSE)

}
}

