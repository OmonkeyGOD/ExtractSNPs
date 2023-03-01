use strict;
use warnings;
my %hash_gff={};
my ($gff, $genelist, $vcffile) = @ARGV;
if (not defined $gff) {
  die "Need gff file \n";
}
if (not defined $genelist) {
  die "Need genelist file \n";
}
if (not defined $vcffile) {
  die "Need vcf file \n";
}

my @arr_gff=();
open GFF, $gff or die "Can't open file '$gff' for read. $!";
for my $Rec(<GFF>){
    chomp($Rec);
    if($Rec=~ m/^\w/){
        @arr_gff = split("\t", $Rec);
        if($arr_gff[2] eq "gene"){
            $arr_gff[8]=~ m/ID=gene-(\w*\d*_?\w*\d*);/;
            $hash_gff{$1}=$arr_gff[0]."_".$arr_gff[3]."_".$arr_gff[4];
        }
    }
}

close(GFF);
open F, $genelist or die "Can't open file '$genelist' for read. $!";
open O,">>./outputSNP.txt";
open OO,">>./output.txt";
my $flag = 0;
my @arr_SNP=();
my @locus=();
my $gene="";
my $id="";
my @brr_VCF=();
for my $Genes(<F>){
    chomp($Genes);
        if($Genes=~ m/^(\w.*)\t(.*)$/){
            
            $gene = $1;
            $id = $2;
            print $id, "\n";
            print OO $gene,"\t",$id,"\t",$hash_gff{$id}, "\n";
            @locus=split("_",$hash_gff{$id});
            open OK, $vcffile or die "Can't open file '$vcffile' for read. $!";
            
            for my $VCF(<OK>){
                chomp($VCF);
                if($VCF=~ m/CHROM\tPOS/ && $flag == 0){
                    print O "GENE", "\t", "ID", "\t", $VCF, "\n";
                    
                }
                if($VCF=~ m/^$locus[0]/){
                    @brr_VCF=split("\t", $VCF);
                    $flag=$flag+1;
                    if(int($locus[1]) <= int($brr_VCF[1]) && int($brr_VCF[1]) <= int($locus[2])){
                        print O $gene, "\t", $id, "\t", $VCF, "\n";
                        
                    }

                }
            }
            
            @brr_VCF=();
            close(OK);
        }
}


close(F);
close(O);

