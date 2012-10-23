#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] NAQP SSB";
my $excludeString = "Claimed";
my $hornString = "3830 Score Submittal";
my $datePage = "date.html"; 
my $indexPage;
my $index_content; 
my $offset1;
my $offset2;
my $ifdef = 0;

$monthPage = "http://lists.contesting.com/pipermail/3830/2012-August/"; 

$indexPage = $monthPage.$datePage;
$index_content = get($indexPage); 

open INDEX_FILEHANDLE, ">indexPage.txt"; 
print INDEX_FILEHANDLE $index_content; 
close INDEX_FILEHANDLE;

open (FILE, "indexPage.txt") or die $!;
open (OUTPUT, '>>naqpSsbBandBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,160Q,160Mult,80Q,80Mult,40Q,40Mult,20Q,20Mult,15Q,15Mult,10Q,10Mult,TotalQ,TotalM,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
	}
	else
	{
		if ($line =~ m/NAQP SSB\E/) 
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
				$offset1 += 5;
				$offset2 = index($postingContent, "Operator");
				$offset2 -= 1;
				$fullCall = substr $postingContent, $offset1, $offset2-$offset1;
				print $fullCall;
				print "\t";
				print OUTPUT "$fullCall,";

				$region = find_USA_VE_Region($fullCall);
				print $region;
				print "\t";
				print OUTPUT "$region,";

				#Class Info
				$offset1 = index($postingContent, "Class: ");
				$offset1 += 7;
				$offset2 = index($postingContent, "QTH");
				$offset2 -= 1;
				$class = substr $postingContent, $offset1, $offset2-$offset1;
				print $class;
				print "\t";
				print OUTPUT "$class,";

				#160M Q Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += 6;
				$Info160Q = substr $postingContent, $offset1, 7;
				if ($Info160Q == "") 
				{
					$Info160Q = "0";
				}
				#print $Info160Q;
				#print "\t";
				print OUTPUT "$Info160Q,";
				
				#160M Mult Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += 13;
				$offset2 = index($postingContent, "   80:");
				$offset2 -= 1;
				$Info160Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info160Mult == "") 
				{
					$Info160Mult = 0;
				}
				#print $Info160Mult;
				#print "\t";
				print OUTPUT "$Info160Mult,";

				#80M Q Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 6;
				$Info80Q = substr $postingContent, $offset1, 7;
				if ($Info80Q == "") 
				{
					$Info80Q = "0";
				}
				#print $Info80Q;
				#print "\t";
				print OUTPUT "$Info80Q,";
				
				#80M Mult Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 13;
				$offset2 = index($postingContent, "   40:");
				$offset2 -= 1;
				$Info80Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info80Mult == "") 
				{
					$Info80Mult = 0;
				}
				#print $Info80Mult;
				#print "\t";
				print OUTPUT "$Info80Mult,";

				#40M Q Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 6;
				$Info40Q = substr $postingContent, $offset1, 7;
				if ($Info40Q == "") 
				{
					$Info40Q = "0";
				}
				#print $Info40Q;
				#print "\t";
				print OUTPUT "$Info40Q,";
				
				#40M Mult Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 13;
				$offset2 = index($postingContent, "   20:");
				$offset2 -= 1;
				$Info40Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info40Mult == "") 
				{
					$Info40Mult = 0;
				}
				#print $Info40Mult;
				#print "\t";
				print OUTPUT "$Info40Mult,";
				
				#20M Q Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 6;
				$Info20Q = substr $postingContent, $offset1, 7;
				if ($Info20Q == "") 
				{
					$Info20Q = "0";
				}
				#print $Info20Q;
				#print "\t";
				print OUTPUT "$Info20Q,";
				
				#20M Mult Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 13;
				$offset2 = index($postingContent, "   15:");
				$offset2 -= 1;
				$Info20Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info20Mult == "") 
				{
					$Info20Mult = 0;
				}
				#print $Info20Mult;
				#print "\t";
				print OUTPUT "$Info20Mult,";

				#15M Q Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 6;
				$Info15Q = substr $postingContent, $offset1, 7;
				if ($Info15Q == "") 
				{
					$Info15Q = "0";
				}
				#print $Info15Q;
				#print "\t";
				print OUTPUT "$Info15Q,";
				
				#15M Mult Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 13;
				$offset2 = index($postingContent, "   10:");
				$offset2 -= 1;
				$Info15Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info15Mult == "") 
				{
					$Info15Mult = 0;
				}
				#print $Info15Mult;
				#print "\t";
				print OUTPUT "$Info15Mult,";

				#10M Q Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 6;
				$Info10Q = substr $postingContent, $offset1, 7;
				if ($Info10Q == "") 
				{
					$Info10Q = "0";
				}
				#print $Info10Q;
				#print "\t";
				print OUTPUT "$Info10Q,";
				
				#10M Mult Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 13;
				$offset2 = index($postingContent, "Total:");
				$offset2 -= 21;
				$Info10Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info10Mult == "") 
				{
					$Info10Mult = 0;
				}
				#print $Info10Mult;
				#print "\t";
				print OUTPUT "$Info10Mult,";

				#TotalQ
				$offset1 = index($postingContent, "Total:");
				$offset1 += 6;
				$TotalQ = substr $postingContent, $offset1, 6;
				if ($TotalQ == "") 
				{
					$TotalQ = "0";
				}
				#print $TotalQ;
				#print "\t";
				print OUTPUT "$TotalQ,";

				#TotalM Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += 12;
				$TotalM = substr $postingContent, $offset1, 6;
				if ($TotalM == "") 
				{
					$TotalM = "0";
				}
				#print $TotalM;
				#print "\t";
				print OUTPUT "$TotalM,";

				#Score Info
				$offset1 = index($postingContent, "Total Score = ");
				$offset1 += 14;
				$offset2 = index($postingContent, "Club:");
				$offset2 -= 2;
				$Score = substr $postingContent, $offset1, $offset2-$offset1;
				#$Score = substr $postingContent, $offset1, 5;
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


sub find_USA_VE_Region 
{
	$result = "nonNA";
	$prefix1 = substr $_[0], 1, 1;
	$prefix2 = substr $_[0], 1, 2;
	switch($prefix1)
	{
		case "K"
		{
			$result = "USA";
		}
		case "W"
		{
			$result = "USA";
		}
		case "A"
		{
			$result = "USA";
		}
		case "N"
		{
			$result = "USA";
		}
		case "V"
		{
			switch($prefix2)
			
			{
				case "VE"	{$result = "VE";}
				case "VA"	{$result = "VE";}
				case "VY"	{$result = "VE";}
			}
		}
		case "X"
		{
			switch($prefix2)
			
			{
				case "XE"	{$result = "XE";}
			}
		}
	}
	
    return $result;
}
