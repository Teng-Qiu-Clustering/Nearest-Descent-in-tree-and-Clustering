# Nearest Descent, in-tree, and Clustering

> **Qiu T, Li Y. Nearest Descent, In-Tree, and Clustering. Mathematics. 2022; 10(5):764. https://doi.org/10.3390/math10050764**
> 
> **Note that: the first version of this paper appears in arXiv in 2014 (arXiv:1412.5902v1)

# Quick start
**Demo1.m** was successfully tested on Matlab2018. 

Note: **Besides downloading and running the codes, one can also directly run the code in my code ocean: https://codeocean.com/capsule/1051400/tree**

# Principle
The proposed clustering method starts from an assumption: what
if data points had mass? They would evolve like particles in the physical
world. Take the two-dimensional (2D) data points for instance (Figure
1a) and imagine the 2D space
as a horizontally stretched rubber sheet (It is actually a popular illustration of Einstein's General Relativity,
the core of which is summarized, by John Wheeler, as ``matter tells
space-time how to curve and space-time tells matter how to move''; see also
http://einstein.stanford.edu/SPACETIME/spacetime2, accessed on March 28, 2014). Intuitively, with the data points put on it, the rubber sheet would
be curved downward (Figure 1b)
and the points in the centroids of clusters would have lower potentials.
This would in turn trigger the points to move in the descending
direction of potential and gather at the locations of locally lowest
potentials in the end. The cluster members can then be identified.

In this paper, we aim to propose a clustering method by following
the above natural evolution and aggregation process of the point system.
To this end, we need to answer two basic questions: (i) how to estimate
the potential and (ii) how to find the moving trajectories of the
points. As for the 1st question, we assume that each point is the
center of a local field whose amplitude decreases as the distance
to the center increases and that the final potential at each point
is estimated as a linear superposition of the fields from all the
points. As for the 2nd question, inspired by literature~\cite{Tenenbaum2000},
we approximate each trajectory by a zigzag path consisting of a sequence
of ``short hops" on some transfer points in this point system.
For each hop, the nearest point in the descending direction of potential
is selected as the transfer point.

Actually, on this relay-like trajectory, we only need to make effort
to determine the first transfer point (also called the parent node)
for each point. The reason is that once linking each point to its
first transfer point by a directed line (also called the edge), one
can obtain an attractive network (or graph), called the In-Tree,
in which the discrete data points are efficiently organized (Figure
1c). This In-Tree can then
serve as a map, on which the next hops (or the next transfer
points) can be easily determined by following the directions of the
edges (one can view this graph-based relay based on other points
of the group as a sort of
Swarm Intelligence).

One problem for this In-Tree is that there exist some inter-cluster
edges (i.e., the red edges between clusters in Figure 1d)
that require to be removed before conducting the rest steps. Pleasingly,
those inter-cluster edges are quite distinguishable; for instance,
they are generally much longer than the intra-cluster edges. For this
reason, if we define the weight of each directed edge as the distance
between its start and end nodes, then we can simply regard the m
longest edges as the inter-cluster edges, where m can be determined
either based on the pre-specified cluster number or the plot in which
all the edge lengths are ranked in decreasing order (Figure 1e).
In Section 3.2, we will show other more
effective edge-cutting methods. After removing the determined inter-cluster
edges, the initial graph will be divided into several sub-graphs (Figure
1f), each containing a special
node called the root node (corresponding to the point with the lowest
potential of one cluster). Within each sub-graph, all the sample points
will reach their root node by successively hopping along the edge
directions (Figure 1g and Figure
1h show two intermediate results).
Lastly, the samples that are associated with the same root nodes will
be assigned into the same clusters (Figure 1i).

# Figures

![Fig.1](https://github.com/Teng-Qiu-Clustering/Nearest-Descent-in-tree-and-Clustering/blob/main/illustration-of-the-principle.png)
**Fig.1**: The idea of the proposed clustering method. (a) A synthetic dataset. (b)
An illustration for the potential surface. As the isopotential lines vary from red to blue, the potentials
in the corresponding areas become lower and lower. (c) The constructed In-Tree. The colors on
nodes denote the potentials corresponding to the cases in (b). (d) The constructed in-tree, in which
the inter-cluster edges are colored in red while the intra-cluster edges are in black. Note that the
graph structures in (c) and (d) are the same. (e) The plot in which the lengths of all the edges in the
In-Tree are arranged in decreasing order. (f) The result after removing the undesired edges (i.e., the
inter-cluster edges). The nodes in red are the root nodes of sub-graphs. (g) The result after the first
round of parallel searching of the root node for each non-root node. (h) The results after the last
round of parallel searching of the root nodes. All the non-root nodes are directly linked to their root
nodes. (i) The clustering result. The samples in the same colors are assigned to the same clusters. 
