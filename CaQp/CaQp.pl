#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] CaQP";
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
open (OUTPUT, '>>CaQpBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,160CW,160SSB,80CW,80SSB,40CW,40SSB,20CW,20SSB,15CW,15SSB,10CW,10SSB,6CW,6SSB,2CW,2SSB,TotalCW,TotalPh,Mults,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
		#print "exclude\n";
	}
	else
	{
		if ($line =~ m/CaQP\E/) 
		{
			#print $line;
			$offset = index($line, "HREF=");
			$posting = substr $line, $offset+6, 11;
#			print "$posting\n";
			$postingContent = get($monthPage.$posting);
#			print $postingContent;

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
				$phOffset = index($postingContent, "Ph Qs");
				#print $phOffset;
				#print " ";

				
				#160M CWQ Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += $cwOffset - $bandOffset;
				$Info160CW = substr $postingContent, $offset1, 5;
				if ($Info160CW == "") 
				{
					$Info160CW = "0";
				}
				#print $Info160CW;
				#print " ";
				print OUTPUT "$Info160CW,";

				#160M PhQ Info
				$offset1 = index($postingContent, "   160:");
				$offset1 += ($phOffset - $bandOffset);
				$Info160Ph = substr $postingContent, $offset1, 5;
				if ($Info160Ph == "") 
				{
					$Info160Ph = 0;
				}
				#print $Info160Ph;
				#print " ";
				print OUTPUT "$Info160Ph,";

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
				$offset1 = index($postingContent, "    40:");
				$offset1 += ($phOffset - $bandOffset);
				$Info40Ph = substr $postingContent, $offset1, 5;
				if ($Info40Ph == "") 
				{
					$Info40Ph = 0;
				}
				#print $Info40Ph;
				#print " ";
				print OUTPUT "$Info40Ph,";

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
				$offset1 = index($postingContent, "    20:");
				$offset1 += ($phOffset - $bandOffset);
				$Info20Ph = substr $postingContent, $offset1, 5;
				if ($Info20Ph == "") 
				{
					$Info20Ph = 0;
				}
				#print $Info20Ph;
				#print " ";
				print OUTPUT "$Info20Ph,";

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
				$offset1 = index($postingContent, "    15:");
				$offset1 += ($phOffset - $bandOffset);
				$Info15Ph = substr $postingContent, $offset1, 5;
				if ($Info15Ph == "") 
				{
					$Info15Ph = 0;
				}
				#print $Info15Ph;
				#print " ";
				print OUTPUT "$Info15Ph,";

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
				$offset1 = index($postingContent, "    10:");
				$offset1 += ($phOffset - $bandOffset);
				$Info10Ph = substr $postingContent, $offset1, 5;
				if ($Info10Ph == "") 
				{
					$Info10Ph = 0;
				}
				#print $Info10Ph;
				#print " ";
				print OUTPUT "$Info10Ph,";

				#6M CWQ Info
				$offset1 = index($postingContent, "   6:");
				$offset1 += $cwOffset - $bandOffset;
				$Info6CW = substr $postingContent, $offset1, 5;
				if ($Info6CW == "") 
				{
					$Info6CW = "0";
				}
				#print $Info6CW;
				#print " ";
				print OUTPUT "$Info6CW,";

				#6M PhQ Info
				$offset1 = index($postingContent, "     6:");
				$offset1 += ($phOffset - $bandOffset);
				$Info6Ph = substr $postingContent, $offset1, 5;
				if ($Info6Ph == "") 
				{
					$Info6Ph = 0;
				}
				#print $Info6Ph;
				#print " ";
				print OUTPUT "$Info6Ph,";

				#2M CWQ Info
				$offset1 = index($postingContent, "   2:");
				$offset1 += $cwOffset - $bandOffset;
				$Info2CW = substr $postingContent, $offset1, 5;
				if ($Info2CW == "") 
				{
					$Info2CW = "0";
				}
				#print $Info2CW;
				#print " ";
				print OUTPUT "$Info2CW,";

				#2M PhQ Info
				$offset1 = index($postingContent, "     2:");
				$offset1 += ($phOffset - $bandOffset);
				$Info2Ph = substr $postingContent, $offset1, 5;
				if ($Info2Ph == "") 
				{
					$Info2Ph = 0;
				}
				#print $Info2Ph;
				#print " ";
				print OUTPUT "$Info2Ph,";

				
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
				$offset1 = index($postingContent, "Mults = ");
				$offset1 += 8;
				$TotalMult = substr $postingContent, $offset1, 4;
				if ($TotalMult == "") 
				{	
					$TotalMult = "0";
				}
				#print $TotalMult;
				#print " ";
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
	$result = "outState";
	open (INSTATE, "inState.txt") or die $!;
	while (my $line = <INSTATE>) 
	{
		#print $line;
		chomp $line;
		if ($line =~ m/$fullCall/) 
		{
			$result = "inState";
		}
	}

	close INSTATE;
    return $result;
}

