[![Travis](https://img.shields.io/travis/shafferm/SCNIC.svg)](https://travis-ci.org/shafferm/SCNIC)

# SCNIC
Sparse Cooccurnce Network Investigation for Compositional data
Pronounced 'scenic'.

SCNIC is a package for the generation and analysis of cooccurence networks with compositional data. Data generated by
many next gen sequencing experiments is compositional (is a subsampling of the total community) which violates
assumptions of typical cooccurence network analysis techniques. 16S sequencing data is often very compositional in
nature so methods such as SparCC (https://bitbucket.org/yonatanf/sparcc) have been developed for studying correlations
microbiome data. SCNIC is designed with compositional data in mind and so provides multiple correlation measures
including SparCC.

This tool has two parts called 'within' and 'between'. The 'within' method takes as input BIOM formatted files
(http://biom-format.org/) and forms cooccurence networks using a user specified correlation metric and edge cutoff. From
this network SCNIC also finds modules of cooccuring observations in the cooccurence network by finding k-clique
communities as implemented in networkx (https://networkx.github.io/). Modules are summarized and a new biom table with
observations contained in modules collapsed into single observations are returned. This biom table along with a list of
modules and their contents are output.  A gml file of the network that can be opened using network visualization tools
such as cytoscape (http://www.cytoscape.org/) is created which contains all observation metadata provided in the input
biom file as well as module information. Please be aware that the networks output by this analysis will only include
positive correlations as only positive correlations are used in module finding and summarization. If you wish to build a
correlation network with both positive and negative correlations using SparCC you can use fast_sparCC 
(https://github.com/shafferm/fast_sparCC) to generate a correlation table and build a network using a different tool or
library such as networkx. If there is demand a network building option can be added to fast_sparCC.

The 'between' method takes two biom tables as input and calculates all pairwise correlations between the tables using a
selection of correlation metrics. A gml correlation network is output as well as a file containing statistics and
p-values of all correlations.

## Installation
To download the latest release from PyPI install using this command:
```
pip install SCNIC
```

To download the lastest changes to the repository use the following commands:
```
git clone https://github.com/shafferm/SCNIC.git
cd SCNIC/
python setup.py install
```
NOTE: This latest code may not be functional and should only be used if you want to play around with the code this is
based on.

## Example usage:

'within' mode:
```
SCNIC_analysis.py within -i example_table.biom -o output_folder/ -m sparcc --min_r .3
```
NOTE: We use a minimum R value of .3 when running SparCC with 16S data as a computationally demanding bootstrapping
procedure must be run to determine p-values. We have run SparCC with 1 million bootstraps on a variety of datasets and
found that a R value of between .3 and .35 will always return FDR adjusted p-values less than .05 and .1 respectively.

'between' mode:
```
SCNIC_analysis.py between -1 example_table1.biom -2 example_table2.biom -o output_folder/ -m spearman --min_p .05
```

