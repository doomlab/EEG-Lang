#!/usr/local/bin/perl -w
srand(time() ^ ($$ + ($$ << 15)));  

open(FIN,"finalpairs2.txt");
while(<FIN>) {
next if /#/;
 chomp; tr/ \t/ /s;
($code, $prime, $target, $blah) = split();

open (FOUT, ">>$code"."first".".txt");

print FOUT "$prime";

close (FOUT);

open (FOUT, ">>$code"."second".".txt");

print FOUT "$target";

close (FOUT);
   
  
}
close(FIN);


