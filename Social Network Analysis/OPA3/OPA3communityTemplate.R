# Coursera SNA optional Programming Assignment 3 template

# see this blog post for a nice overview of community detection algorithms
# http://www.r-bloggers.com/summary-of-community-detection-algorithms-in-igraph-0-6/

# load the igraph library
# you may have to install this module if you haven't already
library(igraph)

# read in the graph in GML format
# it is a sampled collection of pages from a strange set of seed categories:
# Math, Sociology, and Chemistry
# Change this to be your local file location
#  if you are using Windows, replace the \ in the path with a double \, e.g.
# g = read.graph("C:\\Users\\rool\\Documents\\My Dropbox\\Education\\Social Network Analysis\\Week 3\\wikipedia.gml",format="gml")

g = read.graph("wikipedia.gml",format="gml")

# obtain summary information about the graph
summary(g)

# find the maximal k-core any vertex belongs to
graph.coreness(as.undirected(g))

# find the largest clique using cliques(), also making sure the graph is treated as undirected
largest.cliques(as.undirected(g))

# fastgreedy community finding algorithm
fc = fastgreedy.community(as.undirected(g))

# community sizes
sizes(fc)

# membership in 30th community
V(g)$label[membership(fc)==30]

# InfoMap community finding algorithm (can be slow)
imc = infomap.community(g)

# find the nodes in the largest clique
V(g)$label[largest.cliques(as.undirected(g))[[1]]]

# use modularity() to find the modularity of any given partition
modularity(as.undirected(g), membership(fc))
modularity(as.undirected(g), membership(imc))