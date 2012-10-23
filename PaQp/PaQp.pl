#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] PaQP";
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
open (OUTPUT, '>>PaQpBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,160CW,160SSB,160RTTY,160PSK,80CW,80SSB,80RTTY,80PSK,40CW,40SSB,40RTTY,40PSK,20CW,20SSB,20RTTY,20PSK,15CW,15SSB,15RTTY,15PSK,10CW,10SSB,10RTTY,10PSK,6CW,6SSB,6RTTY,6PSK,2CW,2SSB,2RTTY,2PSK,TotalCW,TotalPh,TotalRTTY,TotalPSK,Mults,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
		#print "exclude\n";
	}
	else
	{
		if ($line =~ m/PaQP\E/) 
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
				$rttyOffset = index($postingContent, "RTTY Qs");
				#print $rttyOffset;
				#print " ";
				$pskOffset = index($postingContent, "PSK31 Qs");
				#print $pskOffset;
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

				#160M RTTY Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info160Rtty = substr $postingContent, $offset1, 5;
				if ($Info160Rtty == "") 
				{
					$Info160Rtty = "0";
				}
				#print $Info160Rtty;
				#print " ";
				print OUTPUT "$Info160Rtty,";

				#160M PSK Info
				$offset1 = index($postingContent, "   160:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info160Psk = substr $postingContent, $offset1, 5;
				if ($Info160Psk == "") 
				{
					$Info160Psk = 0;
				}
				#print $Info160Psk;
				#print " ";
				print OUTPUT "$Info160Psk,";

				
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

				#80M RTTY Info
				$offset1 = index($postingContent, "    80:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info80Rtty = substr $postingContent, $offset1, 5;
				if ($Info80Rtty == "") 
				{
					$Info80Rtty = "0";
				}
				#print $Info80Rtty;
				#print " ";
				print OUTPUT "$Info80Rtty,";

				#80M PSK Info
				$offset1 = index($postingContent, "    80:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info80Psk = substr $postingContent, $offset1, 5;
				if ($Info80Psk == "") 
				{
					$Info80Psk = 0;
				}
				#print $Info80Psk;
				#print " ";
				print OUTPUT "$Info80Psk,";
				
				
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

				#40M RTTY Info
				$offset1 = index($postingContent, "    40:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info40Rtty = substr $postingContent, $offset1, 5;
				if ($Info40Rtty == "") 
				{
					$Info40Rtty = "0";
				}
				#print $Info40Rtty;
				#print " ";
				print OUTPUT "$Info40Rtty,";

				#40M PSK Info
				$offset1 = index($postingContent, "    40:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info40Psk = substr $postingContent, $offset1, 5;
				if ($Info40Psk == "") 
				{
					$Info40Psk = 0;
				}
				#print $Info40Psk;
				#print " ";
				print OUTPUT "$Info40Psk,";
				
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

				#20M RTTY Info
				$offset1 = index($postingContent, "    20:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info20Rtty = substr $postingContent, $offset1, 5;
				if ($Info20Rtty == "") 
				{
					$Info20Rtty = "0";
				}
				#print $Info20Rtty;
				#print " ";
				print OUTPUT "$Info20Rtty,";

				#20M PSK Info
				$offset1 = index($postingContent, "    20:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info20Psk = substr $postingContent, $offset1, 5;
				if ($Info20Psk == "") 
				{
					$Info20Psk = 0;
				}
				#print $Info20Psk;
				#print " ";
				print OUTPUT "$Info20Psk,";
				
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

				#15M RTTY Info
				$offset1 = index($postingContent, "    15:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info15Rtty = substr $postingContent, $offset1, 5;
				if ($Info15Rtty == "") 
				{
					$Info15Rtty = "0";
				}
				#print $Info15Rtty;
				#print " ";
				print OUTPUT "$Info15Rtty,";

				#15M PSK Info
				$offset1 = index($postingContent, "    15:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info15Psk = substr $postingContent, $offset1, 5;
				if ($Info15Psk == "") 
				{
					$Info15Psk = 0;
				}
				#print $Info15Psk;
				#print " ";
				print OUTPUT "$Info15Psk,";
				
				
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

				#10M RTTY Info
				$offset1 = index($postingContent, "    10:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info10Rtty = substr $postingContent, $offset1, 5;
				if ($Info10Rtty == "") 
				{
					$Info10Rtty = "0";
				}
				#print $Info10Rtty;
				#print " ";
				print OUTPUT "$Info10Rtty,";

				#10M PSK Info
				$offset1 = index($postingContent, "    10:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info10Psk = substr $postingContent, $offset1, 5;
				if ($Info10Psk == "") 
				{
					$Info10Psk = 0;
				}
				#print $Info10Psk;
				#print " ";
				print OUTPUT "$Info10Psk,";
				
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

				#6M RTTY Info
				$offset1 = index($postingContent, "     6:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info6Rtty = substr $postingContent, $offset1, 5;
				if ($Info6Rtty == "") 
				{
					$Info6Rtty = "0";
				}
				#print $Info6Rtty;
				#print " ";
				print OUTPUT "$Info6Rtty,";

				#6M PSK Info
				$offset1 = index($postingContent, "     6:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info6Psk = substr $postingContent, $offset1, 5;
				if ($Info6Psk == "") 
				{
					$Info6Psk = 0;
				}
				#print $Info6Psk;
				#print " ";
				print OUTPUT "$Info6Psk,";
				
				
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

				#2M RTTY Info
				$offset1 = index($postingContent, "     2:");
				$offset1 += $rttyOffset - $bandOffset;
				$Info2Rtty = substr $postingContent, $offset1, 5;
				if ($Info2Rtty == "") 
				{
					$Info2Rtty = "0";
				}
				#print $Info2Rtty;
				#print " ";
				print OUTPUT "$Info2Rtty,";

				#2M PSK Info
				$offset1 = index($postingContent, "     2:");
				$offset1 += ($pskOffset - $bandOffset);
				$Info2Psk = substr $postingContent, $offset1, 5;
				if ($Info2Psk == "") 
				{
					$Info2Psk = 0;
				}
				#print $Info2Psk;
				#print " ";
				print OUTPUT "$Info2Psk,";
				
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

				#TotalM RTTY Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += $rttyOffset - $bandOffset;
				$InfoTotalRtty = substr $postingContent, $offset1, 5;
				if ($InfoTotalRtty == "") 
				{
					$InfoTotalRtty = "0";
				}
				#print $InfoTotalRtty;
				#print " ";
				print OUTPUT "$InfoTotalRtty,";

				#TotalM PSK Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += ($pskOffset - $bandOffset);
				$InfoTotalPsk = substr $postingContent, $offset1, 5;
				if ($InfoTotalPsk == "") 
				{
					$InfoTotalPsk = 0;
				}
				#print $InfoTotalPsk;
				#print " ";
				print OUTPUT "$InfoTotalPsk,";
				
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

