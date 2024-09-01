# A Haskell implementation of a data compression indicator function

This Haskell program takes a list of integers (with comma delimiter), chunks that list, ommits all zeros, and in place of the first zero, places the decimal translation of the logical value binary representation of the entire list. 

Given a block (a list object) of size $S$, we chunk $S$ into $n$ chunks ($C_1, C_2, ..., C_n$) where $n \in \mathbb{Z}$ and is defined by the user. 

This function is applied to each number in $C_i$. This results in the formation of binary string $S_i = f(C_{i,1}), f(C_{i,2}), ..., f(C_{i,|C_i|})$. Where $f(x) = 1$ is $x \neq 0$ and 0 if $x=0$.   

Each binary string $S_i$ can be translated into a decimal $D_i$ expressed by 

$
D_i = \sum_{|C_i|}_{j=0} s_{i,j} \cdot 2^{|C_i|-1-j}
$

For each $C_i$ a function is defined as $g: \mathbb{Z}^{|C_i} \cdot \mathbb{Z} \rightarrow \mathbb{Z}^{|C_i|'}$. All $C_i$ chunks are then processed by computing $g(C_i, D_i)$ where the first occurence of $0$ is in $C_i$ is replaced with $D_i$ and all other zeros are omitted.  
