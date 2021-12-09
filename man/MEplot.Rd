\name{MEplot}
\alias{MEplot}
\title{
Median-effect plot
}
\description{
Takes a dataframe containing drug combination data and generates the median-effect plot.
}
\usage{
MEplot(data, viability_as_pct)
}

\arguments{
  \item{data}{A dataframe containing drug combination assay data. It should contain columns:

  'Conc1': dosage of drug A;

  'Conc2': dosage of drug B;

  'Response': measured viability - as a percentage or a decimal value;

  'Drug1': name of first drug;

  'Drug2': name of second drug.
}

  \item{viability_as_pct}{A logical value; set TRUE if viability measurements are in percentages; FALSE if in decimals.
}

}

\value{A ggplot2 object containing the median-effect plot.
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

MEplot(data = mydata, viability_as_pct = FALSE)

}
}


