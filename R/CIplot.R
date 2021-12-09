#This function takes the dataframe output from computeCI();
#which is a dataframe with two columns: ED (effect sizes)
#and CI (the combination index at each ED)
#Additional arguments:
#`edvec`: the range of effect sizes to plot; a numeric vector of size 2
#whose first value corresponds to the lower limit and
#second value corresponds to upper limit
#Output: a ggplot object containing the combination index plot

CIplot <- function(CIdata, edvec){
  require(ggplot2)
  require(dplyr)
  CIdata <- CIdata %>% filter(between(ED, edvec[1], edvec[2]))

  p <- ggplot(CIdata, aes(x = ED, y = CI)) + geom_point() +
    geom_hline(yintercept = 1, linetype = 'dashed') +
    geom_smooth(method = 'loess', se = FALSE) +
    xlab('Fa') + theme_classic() +
    annotate('rect', alpha = .2, xmin = -Inf, xmax = Inf,
             ymin = 1, ymax = Inf, fill = 'red') +
    annotate('rect', alpha = .2, xmin = -Inf, xmax = Inf,
             ymin = -Inf, ymax = 1, fill = 'blue')

  print(p)
}


#Example:
#CIplot(CIdata = result, edvec = c(0.5, 0.95))
