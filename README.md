# genetic-trees

This genetic algorithm produces "generations" of recursive trees with attributes of its past generation.
The first generation is random, but all phenotypic outcomes are based on the original "parent"'s genotype.

Attributes like branch length/angle and leaf size/color also can have spontaneous mutations, which are reported in the console when they occur.

The user has some choice in the matter, as with each pair of trees in a generation, the user picks their preferred tree based on keys pressed, which weights the probability of the "child" to have more apparent attributes of the chosen parent.
