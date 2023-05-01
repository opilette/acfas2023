if (!all(c("tidyverse", "igraph") %in% installed.packages()[, "Package"])) {
  install.packages(c("tidyverse", "igraph"))
}

library(tidyverse)
library(igraph)

if (!file.exists("donnees.csv")) {
  stop("Le fichier donnees.csv n'existe pas dans le dossier actuel")
}
x <- read.csv2("donnees.csv", header = TRUE, stringsAsFactors = FALSE, sep = ",")

incid <- x %>% pivot_wider(names_from = 2, values_from = 3)
incid[is.na(incid)] <- 0
incid <- incid %>%
  mutate_if(is.numeric, ~1 * (. != 0)) %>%
  data.frame(row.names = 1)

attr_list <- as.list(incid)
gr_list <- lapply(lapply(attr_list, function(x) {
  bipartite_projection(graph_from_incidence_matrix(as.matrix(x)))
}), `[[`, 1)

aretes <- as.data.frame(unlist(lapply(gr_list, function(x) gsize(x))))
colnames(aretes) <- c("qt")
aretes <- tibble::rownames_to_column(aretes, "sequence")

seq <- rep(c(aretes$sequence), times=c(c(aretes$qt)))

adj <- lapply(gr_list, function(x){as.matrix(as_adjacency_matrix(x, type = c("upper")))})
adj <- lapply(adj, function(x) {rownames(x) <- rownames(incid); x})
adj <- lapply(adj, function(x) {colnames(x) <- rownames(incid); x})

z <- lapply(lapply(adj, function(x){get.edgelist(graph.adjacency(x))}), function(x){as.data.frame(x)})
z <- lapply(z, function(x){mutate(x, materiau=NA)})
final <- bind_rows(z)
colnames(final) <- c("source", "target", "materiau")
final <- tibble::rownames_to_column(final, "id")
final$materiau <- seq

write.csv(final, "graphe.csv", row.names = F)