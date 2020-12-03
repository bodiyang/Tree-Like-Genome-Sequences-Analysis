
library(tidyverse)
all_tree_dist <- read.csv("treedist/chr1-all_pairs.rfdist", sep=" ", header = FALSE, skip = 1, skipNul = TRUE) %>% select(-c(1:7))

adj_tree_dist <- read.csv("treedist/chr1-adj_pairs.rfdist", sep = " ", header=FALSE, skip = 1) %>% select(-c(1))
