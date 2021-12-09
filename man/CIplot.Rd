\name{CIplot}
\alias{CIplot}
\title{
Combination index plot
}
\description{
Takes a dataframe containing effective doses and combination indices to generate a combination index plot.
}
\usage{
CIplot(CIdata, edvec)
}

\arguments{
  \item{CIdata}{A dataframe result from running computeCI function. It has two columns:

  'ED': effective doses;

  'CI': combination indices at each effective dose.

}

 \item{edvec}{A numeric vector of length two containing the range of ED values to plot. First element is assumed to be the lower limit.
}

}

\value{A ggplot2 object containing the combination index plot.
}

\examples{
\dontrun{
mydata_combo <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.042, 0.122, 0.259, 0.532, 0.818))

mydata_mono1 <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = rep(0, 5), 'Response' = c(0.024, 0.256, 0.633, 0.678, 0.932))

mydata_mono2 <- data.frame('Conc1' = rep(0, 5), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.193, 0.244, 0.563, 0.750, 0.921))

mydata <- rbind(mydata_combo, mydata_mono1, mydata_mono2)

myed <- seq(from = 0.05, to = 0.95, by = 0.05)

res <- computeCI(data = mydata, edvec = myed, frac1 = 500, frac2 = 50, viability_as_pct = FALSE)

CIplot(res, c(0.05, 0.95))

}
}


