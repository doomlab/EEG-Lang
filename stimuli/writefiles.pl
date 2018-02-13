###stuff to do:
###look up what the gunk should be

sub scramble {
  local @randtemp;
  local @list = @_;
  push(@randtemp, splice(@list, rand(@list),1)) while @list;
  return @randtemp;
}


open (FOUT, ">text.exp");

print FOUT <<ERIN;
<shape erase>
/ color= (220,220,220) 
/ erase = true(220,220,220)
/ halign = center 
/ position = (50,50)
/ shape= rectangle
/ size= (220,220) 
/ valign = center
</shape>

<text fix>
/ erase = true(220,220,220)
/ txbgcolor =(220,220,220)
/ font = ("Courier New", -27, 700, 0, 49)
/ items = ("+")
/ numitems = 1
/ position = (50,50)
</text>

<text LDT>
/ halign = center
/ valign = center
/ erase = false
/ txcolor = (255,255,255)
/ txbgcolor =(0,0,255)
/ font = ("Verdana", -18, 400, 0, 34)
/ items = ("Is this a word?")
/ numitems = 1
/ position = (25,25)
/ area = (150,50)
</text>

<text LST>
/ valign = center
/ halign = center
/ area = (175,50)
/ erase = false
/ txcolor = (255,255,255)
/ txbgcolor =(255,0,0)
/ font = ("Verdana", -18, 400, 0, 34)
/ items = ("Are there repeating letters?")
/ numitems = 1
/ position = (75,25)
</text>

ERIN


###pull in words here
#~  TYPE PRIME TARGET answer
#~ LDT braces teeth y
#~ LST bulletin board n

open(FIN,"finalpairs2.txt");
while(<FIN>) {
next if /#/;
  chomp; tr/ \t/ /s;
@line = split;

push @trialcode, $line[0];
push @prime, $line[1];
push @judge1, $line[2];
push @answer, $line[3];

}
close(FIN);

#####print the prime words

for ($i=0; $i<@prime; $i++)
{

$_ = $trialcode[$i];

if (/LD/)
{

if (not defined $doneLD{$prime[$i]})
{
print FOUT <<TEXT;
<text $prime[$i]LD>
/ erase = true(220,220,220)
/ font = ("Courier New", -27, 700, 0, 49)
/ items = ("$prime[$i]")
/ numitems = 1
/ position = (50,50)
/ txcolor = (255,255,255)
/ txbgcolor = (220,220,220)
</text>

<text $prime[$i]LDb>
/ erase = true(220,220,220)
/ font = ("Courier New", -27, 700, 0, 49)
/ items = ("$judge1[$i]")
/ numitems = 1
/ position = (50,50)
/ txcolor = (0,0,255)
/ txbgcolor = (220,220,220)
</text>

TEXT
}
$doneLD{$prime[$i]}=1;

}

if (/LS/)
{

if (not defined $doneLS{$prime[$i]})
{
print FOUT <<TEXT;
<text $prime[$i]LS>
/ erase = true(220,220,220)
/ font = ("Courier New", -27, 700, 0, 49)
/ items = ("$prime[$i]")
/ numitems = 1
/ position = (50,50)
/ txcolor = (255,255,255)
/ txbgcolor = (220,220,220)
</text>

<text $prime[$i]LSb>
/ erase = true(220,220,220)
/ font = ("Courier New", -27, 700, 0, 49)
/ items = ("$judge1[$i]")
/ numitems = 1
/ position = (50,50)
/ txcolor = (255,0,0)
/ txbgcolor = (220,220,220)
</text>

TEXT

}
$doneLS{$prime[$i]}=1

}
}

close (FOUT);

#############print trials

open (FOUT, ">trials.exp");

for ($k=0; $k<@trialcode; $k++)

{
$_ = $trialcode[$k];

if (/LD/)
{
print FOUT <<REST;
<trial $trialcode[$k]>
/ frames = [1=LST, LDT, fix; 28=erase; 29=$prime[$k]LD; 43=erase; 57=$prime[$k]LDb;]
/ inputdevice = keyboard
/ posttrialpause = 1000
/ responseframe = 57
/ validresponse = (44, 53)
/ trialcode = "$trialcode[$k] $answer[$k]"
</trial>

REST
}


if (/LS/)
{
print FOUT <<REST;
<trial $trialcode[$k]>
/ frames = [1=LST, LDT, fix; 28=erase; 29=$prime[$k]LS; 43=erase; 57=$prime[$k]LSb;]
/ inputdevice = keyboard
/ posttrialpause = 1000
/ responseframe = 57
/ validresponse = (44, 53)
/ trialcode = "$trialcode[$k] $answer[$k]"
</trial>

REST
}

}

close (FOUT);

open (FOUT, ">exp5.exp");

print FOUT <<EXP;
<include>
/ file = "C:\\exp5\\trials.exp"
/ file = "C:\\exp5\\text.exp"
/ file = "C:\\exp5\\instruct.exp"
</include>

<data>
/ columns = [date time subject trialcode trialnum latency response]
/ format = tab
</data>

<defaults>
/ font = ("Verdana", -13, 400, 0, 34)
/ txbgcolor = (220,220,220)
/ screencolor = (220,220,220)
/ txcolor=(0,0,0)
/ endlock = true
</defaults>

<instruct>
/ font = ("Verdana", -13, 400, 0, 34)
/ lastlabel = "Press enter to continue ..."
/ nextkey = (28)
/ nextlabel ="Press enter for next page"
/ prevkey = (14)
/ prevlabel = "Press Backspace for Previous page"
/ wait = 1000
/ windowsize = (640,400)
</instruct>

<block practiceldt>
/ preinstructions = (pracLDT)
/ trials = [1 - 15 = random(PRLDT01,,PRLDT02,PRLDT03,PRLDT04,PRLDT05,PRLDT06,PRLDT07,PRLDT08,PRLDT09,PRLDT10,PRLDT11,PRLDT12,PRLDT13,PRLDT14,PRLDT15)]
</block>

<block 1>
/ preinstructions = (break)
/ responsemode = free
/ trials = [1 - 90 = random(LSTUR01,LSTUR22,LSTUR38,LSTUR51,LSTUR48,LSTUR06,LSTUR10,LSTUR45,LSTUR54,
LSTUR05,LSTUR14,LSTUR41,LSTUR08,LSTUR32,LSTUR37,LSTUR19,LSTUR57,LSTUR02,LSTUR29,LSTUR16,
LSTUR23,LSTUR04,LSTUR31,LSTUR07,LSTUR46,LSTUR27,LSTUR44,LSTUR34,LSTUR28,LSTUR18,LSTNW01,
LSTNW22,LSTNW38,LSTNW51,LSTNW48,LSTNW06,LSTNW10,LSTNW45,LSTNW54,LSTNW05,LSTNW14,LSTNW41,
LSTNW08,LSTNW32,LSTNW37,LSTNW19,LSTNW57,LSTNW02,LSTNW29,LSTNW16,LSTNW23,LSTNW04,LSTNW31,
LSTNW07,LSTNW46,LSTNW27,LSTNW44,LSTNW34,LSTNW28,LDTHL01,LDTHL02,LDTHL04,LDTHL05,LDTHL06,
LDTHL07,LDTHL08,LDTHL10,LDTHL14,LDTHL19,LDTHL22,LDTHL23,LDTHL27,LDTHL28,LDTHL29,LDTLH01,
LDTLH02,LDTLH04,LDTLH05,LDTLH06,LDTLH07,LDTLH08,LDTLH10,LDTLH14,LDTLH16,LDTLH18,LDTLH19,
LDTLH22,LDTLH28,LDTLH29,LSTNW18)]
</block>

<block 2>
/ preinstructions = (break)
/ responsemode = free
/ trials = [1 - 90 = random(LDTHL03,LDTHL09,LDTHL11,LDTHL12,LDTHL13,LDTHL15,LDTHL17,LDTHL20,
LDTHL21,LDTHL24,LDTHL25,LDTHL26,LDTHL30,LDTLH03,LDTLH09,LDTLH11,LDTLH12,LDTLH13,
LDTLH15,LDTLH17,LDTLH20,LDTLH21,LDTLH24,LDTLH25,LDTLH26,LDTLH30,LSTUR55,LSTUR21,
LSTUR39,LSTUR35,LSTUR40,LSTUR11,LSTUR12,LSTUR49,LSTUR56,LSTUR47,LSTUR53,LSTUR36,
LSTUR26,LSTUR20,LSTUR58,LSTUR17,LSTUR30,LSTUR52,LSTUR59,LSTUR43,LSTUR60,LSTUR13,
LSTUR15,LSTUR09,LSTUR50,LSTUR24,LSTUR33,LSTUR42,LSTUR25,LSTUR03,LSTNW55,LSTNW21,
LSTNW39,LSTNW35,LSTNW40,LSTNW11,LSTNW12,LSTNW49,LSTNW56,LSTNW47,LSTNW53,LSTNW36,
LSTNW26,LSTNW20,LSTNW58,LSTNW17,LSTNW30,LSTNW52,LSTNW59,LSTNW43,LSTNW60,LSTNW13,
LSTNW15,LSTNW09,LSTNW50,LSTNW24,LSTNW33,LSTNW42,LSTNW25,LSTNW03,LDTLH23,LDTLH27,LDTHL16,LDTHL18)]
</block>

<block 3>
/ responsemode = free
/ trials = [1 - 90 = random(LSTHL01,LSTHL03,LSTHL04,LSTHL06,LSTHL07,LSTHL08,LSTHL13,LSTHL16,LSTHL19,
LSTHL21,LSTHL23,LSTHL24,LSTHL30,LSTLH01,LSTLH03,LSTLH04,LSTLH06,LSTLH07,LSTLH08,LSTLH13,
LSTLH16,LSTLH19,LSTLH21,LSTLH23,LSTLH24,LSTLH30,LDTUR01,LDTUR03,LDTUR04,LDTUR06,LDTUR07,
LDTUR08,LDTUR13,LDTUR16,LDTUR19,LDTUR21,LDTUR23,LDTUR24,LDTUR30,LDTUR31,LDTUR32,LDTUR35,
LDTUR36,LDTUR38,LDTUR39,LDTUR40,LDTUR42,LDTUR47,LDTUR48,LDTUR50,LDTUR52,LDTUR54,LDTUR55,
LDTUR58,LDTUR59,LDTUR60,LDTNW01,LDTNW03,LDTNW04,LDTNW06,LDTNW07,LDTNW08,LDTNW13,LDTNW16,
LDTNW19,LDTNW21,LDTNW23,LDTNW24,LDTNW30,LDTNW31,LDTNW32,LDTNW35,LDTNW36,LDTNW38,LDTNW39,
LDTNW40,LDTNW42,LDTNW47,LDTNW48,LDTNW50,LDTNW52,LDTNW54,LDTNW55,LDTNW58,LDTNW59,LDTNW60,
LSTHL17,LSTHL18,LSTLH20,LSTLH22)]
/ preinstructions = (break)
</block>

<block 4>
/ preinstructions = (break)
/ responsemode = free
/ trials = [1 - 90 = random(LDTNW02,LDTNW05,LDTNW09,LDTNW10,LDTNW11,LDTNW12,LDTNW14,LDTNW15,
LDTNW17,LDTNW18,LDTNW20,LDTNW22,LDTNW25,LDTNW26,LDTNW27,LDTNW28,LDTNW29,LDTNW33,
LDTNW34,LDTNW37,LDTNW41,LDTNW43,LDTNW44,LDTNW45,LDTNW46,LDTNW49,LDTNW51,LDTNW53,
LDTNW56,LDTNW57,LDTUR02,LDTUR05,LDTUR09,LDTUR10,LDTUR11,LDTUR12,LDTUR14,LDTUR15,
LDTUR17,LDTUR18,LDTUR20,LDTUR22,LDTUR25,LDTUR26,LDTUR27,LDTUR28,LDTUR29,LDTUR33,
LDTUR34,LDTUR37,LDTUR41,LDTUR43,LDTUR44,LDTUR45,LDTUR46,LDTUR49,LDTUR51,LDTUR53,
LDTUR56,LDTUR57,LSTHL02,LSTHL05,LSTHL09,LSTHL10,LSTHL11,LSTHL12,LSTHL14,LSTHL15,
LSTHL20,LSTHL22,LSTHL25,LSTHL26,LSTHL27,LSTHL28,LSTHL29,LSTLH02,LSTLH05,LSTLH09,
LSTLH10,LSTLH11,LSTLH12,LSTLH14,LSTLH15,LSTLH17,LSTLH18,LSTLH25,LSTLH26,LSTLH27,
LSTLH28,LSTLH29)]
</block>


<block practicelst>
/ preinstructions = (pracLST)
/ trials = [1 - 15 = random(PRLST01,PRLST02,PRLST03,PRLST04,PRLST05,PRLST06,PRLST07,PRLST08,PRLST09,PRLST10,PRLST11,PRLST12,PRLST13,PRLST14,PRLST15)]
</block>

<block practiceboth>
/ preinstructions = (pracBOTH)
/ trials = [1 - 30 = random(PRLDT16,PRLDT17,PRLDT18,PRLDT19,PRLDT20,PRLDT21,
PRLDT22,PRLDT23,PRLDT24,PRLDT25,PRLDT26,PRLDT27,PRLDT28,PRLDT29,PRLDT30,
PRLST16,PRLST17,PRLST18,PRLST19,PRLST20,PRLST21,PRLST22,PRLST23,PRLST24,
PRLST25,PRLST26,PRLST27,PRLST28,PRLST29,PRLST30)]
</block>

<expt>
/ preinstructions = (first)
/ blocks = [1= practiceldt; 2= practicelst; 3=practiceboth; 4=1; 5=2; 6=3; 7=4;]
/ postinstructions = (expend)
</expt>

EXP

close (FOUT);

open (FOUT, ">instruct.exp");

print FOUT <<INSTRUCT;

<page first>
This experiment is concerned with how people process words.  You will be asked to view words and judge them.^^
These words are color coded for the type of judgment you will have to make.
</page>

<page pracLDT>
FOR ALL THE BLUE WORDS:^^
Whenever you see a blue word, you should ask yourself if the word on the screen is a real word or a fake word.^^
For example, you would say yes to a word like COLD, but no to a fake word like WERM.^^
You will press the keys marked "Y" and "N" for yes and no.^^
Any questions?  If no, press the enter key to try some for practice.
</page>

<page pracLST>
FOR ALL THE RED WORDS:^^
Whenever you see a red word, you should ask yourself if the word on the screen has any repeating letters.^^
For example, you would say yes to a word like DOCTOR, but no to a  word like HAVE.^^
You will press the keys marked "Y" and "N" for yes and no.^^
Any questions?  If no, press the enter key to try some for practice.
</page>

<page pracBOTH>
Now you are going to perform both BLUE and RED word judgments at the same time.  Remember:^^
BLUE WORDS: Is this a real word?^^
RED WORDS: Are there repeating letters?^^
This reminder will always be printed on the top of the screen, in case you forget.^^
Any questions?  If no, press the enter key to try some for practice.
</page>

<page break>
You may now take a short break to rest.  Please do not leave your seat.^^
Press enter when you are ready for the next block.
</page>

<page expend>
This experiment was testing how people process words.  When people are thinking about the letters in a word, they usually do no think about how the words are  linked to other words.  When people think about if a word is real, usually it brings to mind other related words.  ^^
We were testing if different types of word relationships would change how people think about letters in a word and if words are real by measuring how fast you responded to each word type.
</page>

INSTRUCT

close (FOUT);

