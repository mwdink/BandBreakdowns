#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] WAG";
my $excludeString = "Claimed";
my $hornString = "3830 Score Submittal";
my $datePage = "date.html"; 
my $indexPage;
my $index_content; 
my $offset1;
my $offset2;
my $ifdef = 0;
$ZERO = 0;

#if ($ARGV[0] eq "Oct")
#{
#	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-October/"; 
#}
#else
#{
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-October/"; 
#}


print "running $monthPage\n";

$indexPage = $monthPage.$datePage;
$index_content = get($indexPage); 

open INDEX_FILEHANDLE, ">indexPage.txt"; 
print INDEX_FILEHANDLE $index_content; 
close INDEX_FILEHANDLE;

open (FILE, "indexPage.txt") or die $!;
open (OUTPUT, '>>WagBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,80CW,80SSB,80Mults,40CW,40SSB,40Mults,20CW,20SSB,20Mults,15CW,15SSB,15Mults,10CW,10SSB,10Mults,TotalCW,TotalPh,Mults,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
		#print $line;
		#print "exclude\n";
	}
	else
	{
		if ($line =~ m/WAG\E/) 
		{
			#print $line;
			$offset = index($line, "HREF=");
			$posting = substr $line, $offset+6, 11;
			#print "$posting\n";
			$postingContent = get($monthPage.$posting);
			#print $postingContent;

			if ($postingContent =~ m/$hornString\E/)
			{
				#Callsign Info
				$offset1 = index($postingContent, "Call: ");
				$offset1 += 6;
				$offset2 = index($postingContent, "Operator");
				$offset2 -= 1;
				$fullCall = substr $postingContent, $offset1, $offset2-$offset1;
				print $fullCall;
				print "  ";
				print OUTPUT "$fullCall,";
				
				$region = find_Region($fullCall);
				print $region;
				print "  ";
				print OUTPUT "$region,";
				
				#Class Info
				$offset1 = index($postingContent, "Class: ");
				$offset1 += 7;
				$offset2 = index($postingContent, "QTH");
				$offset2 -= 1;
				$class = substr $postingContent, $offset1, $offset2-$offset1;
				print $class;
				print "  ";
				print OUTPUT "$class,";

			
				#Determine offsets
				$bandOffset = index($postingContent, " Band");
				#print $bandOffset;
				#print " ";
				$cwOffset = index($postingContent, "CW Qs");
				#print $cwOffset;
				#print " ";
				$phOffset = index($postingContent, "SSB Qs");
				#print $phOffset;
				#print " ";
				$multOffset = index($postingContent, "Mults");
				#print $multOffset;
				#print " ";

				#80M CWQ Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $cwOffset - $bandOffset;
				$Info80CW = substr $postingContent, $offset1, 5;
				if ($Info80CW == "") 
				{
					$Info80CW = "0";
				}
				#print $Info80CW;
				#print " ";
				print OUTPUT "$Info80CW,";

				#80M PhQ Info
				$offset1 = index($postingContent, "    80:");
				$offset1 += ($phOffset - $bandOffset);
				$Info80Ph = substr $postingContent, $offset1, 5;
				if ($Info80Ph == "") 
				{
					$Info80Ph = 0;
				}
				#print $Info80Ph;
				#print " ";
				print OUTPUT "$Info80Ph,";

				#80M Mult Info
				$offset1 = index($postingContent, "    80:");
				$offset1 += ($multOffset - $bandOffset);
				$Info80Mult = substr $postingContent, $offset1, 5;
				chomp($Info80Mults);
				my $l = length($Info80Mults);
				$Info80Mults = reverse unpack("A$l",reverse unpack("A$l",$Info80Mults));
				if ($Info80Mult == "") 
				{
					$Info80Mult = 0;
				}
				#print $Info80Mult;
				#print " ";
				print OUTPUT "$Info80Mult,";
				
				#40M CWQ Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $cwOffset - $bandOffset;
				$Info40CW = substr $postingContent, $offset1, 5;
				if ($Info40CW == "") 
				{
					$Info40CW = "0";
				}
				#print $Info40CW;
				#print " ";
				print OUTPUT "$Info40CW,";

				#40M PhQ Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += ($phOffset - $bandOffset);
				$Info40Ph = substr $postingContent, $offset1, 5;
				if ($Info40Ph == "") 
				{
					$Info40Ph = 0;
				}
				#print $Info40Ph;
				#print " ";
				print OUTPUT "$Info40Ph,";

				#40M Mult Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += ($multOffset - $bandOffset);
				$Info40Mult = substr $postingContent, $offset1, 4;
				chomp($Info40Mult);
				my $l = length($Info40Mult);
				$Info40Mult = reverse unpack("A$l",reverse unpack("A$l",$Info40Mult));
				if ($Info40Mult == "") 
				{
					$Info40Mult = 0;
				}
				#print $Info40Mult;
				#print " ";
				print OUTPUT "$Info40Mult,";

				#20M CWQ Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $cwOffset - $bandOffset;
				$Info20CW = substr $postingContent, $offset1, 5;
				if ($Info20CW == "") 
				{
					$Info20CW = "0";
				}
				#print $Info20CW;
				#print " ";
				print OUTPUT "$Info20CW,";

				#20M PhQ Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += ($phOffset - $bandOffset);
				$Info20Ph = substr $postingContent, $offset1, 5;
				if ($Info20Ph == "") 
				{
					$Info20Ph = 0;
				}
				#print $Info20Ph;
				#print " ";
				print OUTPUT "$Info20Ph,";

				#20M Mult Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += ($multOffset - $bandOffset);
				$Info20Mult = substr $postingContent, $offset1, 4;
				chomp($Info20Mult);
				my $l = length($Info20Mult);
				$Info20Mult = reverse unpack("A$l",reverse unpack("A$l",$Info20Mult));	
				if ($Info20Mult == "") 
				{
					$Info20Mult = 0;
				}
				#print $Info20Mult;
				#print " ";
				print OUTPUT "$Info20Mult,";

				#15M CWQ Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $cwOffset - $bandOffset;
				$Info15CW = substr $postingContent, $offset1, 5;
				if ($Info15CW == "") 
				{
					$Info15CW = "0";
				}
				#print $Info15CW;
				#print " ";
				print OUTPUT "$Info15CW,";

				#15M PhQ Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += ($phOffset - $bandOffset);
				$Info15Ph = substr $postingContent, $offset1, 5;
				if ($Info15Ph == "") 
				{
					$Info15Ph = 0;
				}
				#print $Info15Ph;
				#print " ";
				print OUTPUT "$Info15Ph,";

				#15M Mult Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += ($multOffset - $bandOffset);
				$Info15Mult = substr $postingContent, $offset1, 4;
				chomp($Info15Mult);
				my $l = length($Info15Mult);
				$Info15Mult = reverse unpack("A$l",reverse unpack("A$l",$Info15Mult));	
				if ($Info15Mult == "") 
				{
					$Info15Mult = 0;
				}
				#print $Info15Mult;
				#print " ";
				print OUTPUT "$Info15Mult,";

				#10M CWQ Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $cwOffset - $bandOffset;
				$Info10CW = substr $postingContent, $offset1, 5;
				if ($Info10CW == "") 
				{
					$Info10CW = "0";
				}
				#print $Info10CW;
				#print " ";
				print OUTPUT "$Info10CW,";

				#10M PhQ Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += ($phOffset - $bandOffset);
				$Info10Ph = substr $postingContent, $offset1, 5;
				if ($Info10Ph == "") 
				{
					$Info10Ph = 0;
				}
				#print $Info10Ph;
				#print " ";
				print OUTPUT "$Info10Ph,";

				#10M Mult Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += ($multOffset - $bandOffset);
				$Info10Mult = substr $postingContent, $offset1, 4;
				chomp($Info10Mult);
				my $l = length($Info10Mult);
				$Info10Mult = reverse unpack("A$l",reverse unpack("A$l",$Info10Mult));	
				if ($Info10Mult == "") 
				{
					$Info10Mult = 0;
				}
				#print $Info10Mult;
				#print " ";
				print OUTPUT "$Info10Mult,";

				#TotalCW Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += $cwOffset - $bandOffset;
				$TotalCW = substr $postingContent, $offset1, 5;
				if ($TotalCW == "") 
				{	
					$TotalCW = "0";
				}
				#print $TotalCW;
				#print "\t";
				print OUTPUT "$TotalCW,";

				#TotalPh Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += ($phOffset - $bandOffset);
				$TotalPh = substr $postingContent, $offset1, 5;
				if ($TotalPh == "") 
				{	
					$TotalPh = "0";
				}
				#print $TotalPh;
				#print "\t";
				print OUTPUT "$TotalPh,";

				#TotalMult Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += ($multOffset - $bandOffset);
				$TotalMult = substr $postingContent, $offset1, 5;
				chomp($TotalMult);
				my $l = length($TotalMult);
				$TotalMult = reverse unpack("A$l",reverse unpack("A$l",$TotalMult));	
				if ($TotalMult == "") 
				{	
					$TotalMult = "0";
				}
				print $TotalMult;
				print " ";
				print OUTPUT "$TotalMult,";


				#Score Info
				$offset1 = index($postingContent, "Total Score = ");
				$offset1 += 14;
				$offset2 = index($postingContent, "Club:");
				$offset2 -= 2;
				$Score = substr $postingContent, $offset1, $offset2-$offset1;
				$Score =~ s/,//g; 
				#print $Score;
				#print "\t";
				print OUTPUT "$Score";
				
				
				print ("\n");
				print OUTPUT "\n";
			}
		}
	}
}
print OUTPUT "\n";
close FILE;
close OUTPUT;


sub find_Region 
{
	$result = "non-GERMANY";
	$prefix1 = substr $_[0], 0, 1;
	$prefix2 = substr $_[0], 0, 2;

	switch($prefix1)
	{
		case "D"
		{
			switch($prefix2)
			{
				case "D4"	{$result = "non-GERMANY";}
				else		{$result = "GERMANY"};
			}
		}
	}
    return $result;
}