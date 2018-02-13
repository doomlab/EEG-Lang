#!/usr/local/bin/perl -w
srand(time() ^ ($$ + ($$ << 15)));  

open(FIN,"usfjcn_sensed.csv");
while(<FIN>) {
next if /#/;
 chomp; tr/ \t/ /s;
($word,$pair,$fsg,$bsg,$qfr,$tfr,$jcn,$jcnsense) = split(",");

$fsg{$word}{$pair} = $fsg;
$jcn{$word}{$pair} = $jcnsense;
$bsg{$word}{$pair} = $bsg;

}
close(FIN);

###for experiment 5
#~ LDTHL01	zenith	television	y	1
#~ LDTHL02	newsstand	paper	y	1

open(FIN,"exp5sem.txt");
while(<FIN>) {
next if /#/;
 chomp; tr/ \t/ /s;
($code, $prime, $target, $blah, $blah2) = split();

  
   $scores{$prime}{$target} = 1;
   
  
}
close(FIN);


open (FOUT, ">>exp5semlist.txt");

foreach $word (sort keys %scores)
{
	foreach $pair (sort keys %{$scores{$word}})
	{

	if (defined $fsg{$word}{$pair})
	{	print FOUT "$word $pair $fsg{$word}{$pair} $bsg{$word}{$pair} $jcn{$word}{$pair} \n";	}
	
	else
	{	print FOUT "$word $pair $fsg{$pair}{$word} $bsg{$pair}{$word} $jcn{$pair}{$word} \n";	}
	
	}

}




close (FOUT);