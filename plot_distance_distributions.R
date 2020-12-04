library(tidyverse)

# read in all tree distances and adjacent tree distances from rfdist files
all_tree_dist <- read.csv("treedist/chr1-all_pairs.rfdist", sep=" ", header = FALSE, skip = 1, skipNul = TRUE) %>% select(-c(1:7))
adj_tree_dist <- read.csv("treedist/chr1-adj_pairs.rfdist", sep = " ", header=FALSE, skip = 1) %>% select(-c(1))


# Task 7 B
# transform matrices into vector
all_vec <- c(data.matrix(all_tree_dist))
all_vec <- all_vec[all_vec != 0]

# create a dataframe with adjacent tree distances as well as distances from randomly sampled trees from the same chromosome
tree_dists <- data.frame(c(replicate(length(adj_tree_dist) -1,sample(all_vec,1))),as.numeric(adj_tree_dist[1,1:length(adj_tree_dist)-1]))
names(tree_dists) <- c("Adjacent", "Random")

# readjust dataframe to make it easier to plot
tree_dists <- tree_dists %>% pivot_longer(c('Adjacent', 'Random'), names_to = "Tree Relationship", values_to = "Distance")
tree_dists <- data.frame(tree_dists)

# plot tree distances
pb <- ggplot(data=tree_dists, aes(color=Tree.Relationship, fill=Tree.Relationship)) + geom_histogram(aes(x=Distance), alpha=0.5,binwidth=4, position="identity") 
pb <- pb + theme(legend.position="right")
plot(pb)
ggsave("AdjVsRandTreeDistances.pdf")
