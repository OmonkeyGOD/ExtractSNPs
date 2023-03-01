# ExtractSNPs
Extract SNPs from genes of interest.
# Prerequisite
Perl 5 <br />
# Files
Genome annotation in GFF format <br />
Variants.vcf  <br />
Genelist.txt <br />

Genelist.txt <br />
tab separated gene symbols and gene IDs used in Genome annotation file <br />
FUR1 B9J08_004076 <br />
TAC1B	B9J08_004820 <br />
ERG2 B9J08_004943 <br />
ERG3 B9J08_003737 <br />
ERG5 B9J08_002349 <br />

# How to use
To run the script, you might need to: <br />
  1. In Command Prompt (Windows) or Terminal (MacOS)  <br />
  2. Type and run the command perl /PATH/to/SNP.filter.pl /PATH/to/Genome.gff /PATH/to/Genelist.txt /PATH/to/Variants.vcf <br />

# Output
output.txt containing variants in genes of interest will be generated in the current directory.
