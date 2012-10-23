#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] IARU";
my $excludeString = "Claimed";
my $hornString = "3830 Score Submittal";
my $datePage = "date.html"; 
my $indexPage;
my $index_content; 
my $offset1;
my $offset2;

if ($ARGV[0] eq "July")
{
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-July/"; 
}
else
{
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-August/"; 
}
print "running $monthPage\n";

$indexPage = $monthPage.$datePage;
$index_content = get($indexPage); 

open INDEX_FILEHANDLE, ">indexPage.txt"; 
print INDEX_FILEHANDLE $index_content; 
close INDEX_FILEHANDLE;

open (FILE, "indexPage.txt") or die $!;
open (OUTPUT, '>>iaruBandBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,160CW,160SSB,160Z,160HQ,80CW,80SSB,80Z,80HQ,40CW,40SSB,40Z,40HQ,20CW,20SSB,20Z,20HQ,15CW,15SSB,15Z,15HQ,10CW,10SSB,10Z,10HQ,TotalZ,TotalHQ,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
	}
	else
	{
		if ($line =~ m/IARU\E/) 
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
				#print $region;
				#print "\t";
				print OUTPUT "$region,";
				
				#Class Info
				$offset1 = index($postingContent, "Class: ");
				$offset1 += 7;
				$offset2 = index($postingContent, "QTH");
				$offset2 -= 1;
				$class = substr $postingContent, $offset1, $offset2-$offset1;
				#print $class;
				#print "\t";
				print OUTPUT "$class,";

				#160M CW Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += 7;
				$Info160CW = substr $postingContent, $offset1, 5;
				if ($Info160CW == "") 
				{
					$Info160CW = "0";
				}
				#print $Info160CW;
				#print "\t";
				print OUTPUT "$Info160CW,";
				
				#160M SSB Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += 14;
				$Info160SSB = substr $postingContent, $offset1, 5;
				if ($Info160SSB == "") 
				{
					$Info160SSB = 0;
				}
				#print $Info160SSB;
				#print "\t";
				print OUTPUT "$Info160SSB,";

				#160M Zone Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += 20;
				$Info160Zone = substr $postingContent, $offset1, 5;
				if ($Info160Zone == "") 
				{
					$Info160Zone = 0;
				}
				print OUTPUT "$Info160Zone,";
				
				#160M HQ Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += 29;
				$offset2 = index($postingContent, "   80:");
				$offset2 -= 1;
				$Info160HQ = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info160HQ == "") 
				{
					$Info160HQ = 0;
				}
				print OUTPUT "$Info160HQ,";

				#80M CW Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 7;
				$Info80CW = substr $postingContent, $offset1, 5;
				if ($Info80CW == "") 
				{
					$Info80CW = "0";
				}
				#print $Info80CW;
				#print "\t";
				print OUTPUT "$Info80CW,";
				
				#80M SSB Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 14;
				$Info80SSB = substr $postingContent, $offset1, 5;
				if ($Info80SSB == "") 
				{
					$Info80SSB = 0;
				}
				#print $Info80SSB;
				#print "\t";
				print OUTPUT "$Info80SSB,";

				#80M Zone Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += 20;
				$Info80Zone = substr $postingContent, $offset1, 5;
				if ($Info80Zone == "") 
				{
					$Info80Zone = 0;
				}
				print OUTPUT "$Info80Zone,";
				
				#80M HQ Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += 29;
				$offset2 = index($postingContent, "   40:");
				$offset2 -= 1;
				$Info80HQ = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info80HQ == "") 
				{
					$Info80HQ = 0;
				}
				print OUTPUT "$Info80HQ,";

				#40M CW Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 7;
				$Info40CW = substr $postingContent, $offset1, 5;
				if ($Info40CW == "") 
				{
					$Info40CW = "0";
				}
				#print $Info40CW;
				#print "\t";
				print OUTPUT "$Info40CW,";
				
				#40M SSB Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 14;
				$Info40SSB = substr $postingContent, $offset1, 5;
				if ($Info40SSB == "") 
				{
					$Info40SSB = 0;
				}
				#print $Info40SSB;
				#print "\t";
				print OUTPUT "$Info40SSB,";

				#40M Zone Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += 20;
				$Info40Zone = substr $postingContent, $offset1, 5;
				if ($Info40Zone == "") 
				{
					$Info40Zone = 0;
				}
				print OUTPUT "$Info40Zone,";
				
				#40M HQ Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += 29;
				$offset2 = index($postingContent, "   20:");
				$offset2 -= 1;
				$Info40HQ = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info40HQ == "") 
				{
					$Info40HQ = 0;
				}
				print OUTPUT "$Info40HQ,";

				#20M CW Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 7;
				$Info20CW = substr $postingContent, $offset1, 5;
				if ($Info20CW == "") 
				{
					$Info20CW = "0";
				}
				#print $Info20CW;
				#print "\t";
				print OUTPUT "$Info20CW,";
				
				#20M SSB Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 14;
				$Info20SSB = substr $postingContent, $offset1, 5;
				if ($Info20SSB == "") 
				{
					$Info20SSB = 0;
				}
				#print $Info20SSB;
				#print "\t";
				print OUTPUT "$Info40SSB,";
				
				#20M Zone Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += 20;
				$Info20Zone = substr $postingContent, $offset1, 5;
				if ($Info20Zone == "") 
				{
					$Info20Zone = 0;
				}
				print OUTPUT "$Info20Zone,";
				
				#20M HQ Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += 29;
				$offset2 = index($postingContent, "   15:");
				$offset2 -= 1;
				$Info20HQ = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info20HQ == "") 
				{
					$Info20HQ = 0;
				}
				print OUTPUT "$Info20HQ,";

				#15M CW Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 7;
				$Info15CW = substr $postingContent, $offset1, 5;
				if ($Info15CW == "") 
				{
					$Info15CW = "0";
				}
				#print $Info15CW;
				#print "\t";
				print OUTPUT "$Info15CW,";
				
				#15M SSB Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 14;
				$Info15SSB = substr $postingContent, $offset1, 5;
				if ($Info15SSB == "") 
				{
					$Info15SSB = 0;
				}
				#print $Info15SSB;
				#print "\t";
				print OUTPUT "$Info15SSB,";

				#15M Zone Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += 20;
				$Info15Zone = substr $postingContent, $offset1, 5;
				if ($Info15Zone == "") 
				{
					$Info15Zone = 0;
				}
				print OUTPUT "$Info15Zone,";
				
				#15M HQ Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += 29;
				$offset2 = index($postingContent, "   10:");
				$offset2 -= 1;
				$Info15HQ = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info15HQ == "") 
				{
					$Info15HQ = 0;
				}
				print OUTPUT "$Info15HQ,";

				#10M CW Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 7;
				$Info10CW = substr $postingContent, $offset1, 5;
				if ($Info10CW == "") 
				{
					$Info10CW = "0";
				}
				print OUTPUT "$Info10CW,";
				
				#10M SSB Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 14;
				$Info10SSB = substr $postingContent, $offset1, 5;
				if ($Info10SSB == "") 
				{
					$Info10SSB = 0;
				}
				print OUTPUT "$Info10SSB,";

				#10M Zone Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += 20;
				$Info10Zone = substr $postingContent, $offset1, 5;
				if ($Info10Zone == "") 
				{
					$Info10Zone = 0;
				}
				print OUTPUT "$Info10Zone,";
				
				#10M HQ Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += 29;
				$offset2 = index($postingContent, "Total:");
				$offset2 -= 39;
				$Info10HQ = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info10HQ == "") 
				{
					$Info10HQ = 0;
				}
				print OUTPUT "$Info10HQ,";

				#Zone Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += 21;
				$Zone = substr $postingContent, $offset1, 5;
				if ($Zone == "") 
				{					$Zone = "0";
				}
				#print $Zone;
				#print "\t";
				print OUTPUT "$Zone,";

				#HQ Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += 28;
				$HQ = substr $postingContent, $offset1, 6;
				if ($HQ == "") 
				{
					$HQ = "0";
				}
				#print $HQ;
				#print "\t";
				print OUTPUT "$HQ,";

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
	$result = "nonUSA/VE";
	$prefix1 = substr $_[0], 1, 1;
	$prefix2 = substr $_[0], 1, 2;
	switch($prefix1)
	{
		case "K"
		{
			switch($prefix2)
			{
				case "KH"	{$result = "nonUSA/VE";}
				case "KL"	{$result = "nonUSA/VE";}
				case "KP"	{$result = "nonUSA/VE";}
				else		{$result = "USA/VE"};
			}

		}
		case "W"
		{
			switch($prefix2)
			{
				case "WH"	{$result = "nonUSA/VE";}
				case "WL"	{$result = "nonUSA/VE";}
				else		{$result = "USA/VE"};
			}
		}
		case "A"
		{
			switch($prefix2)
			{
				case "AL"	{$result = "nonUSA/VE";}
				case "AH"	{$result = "nonUSA/VE";}
				case "AK"	{$result = "nonUSA/VE";}
				case "A6"	{$result = "nonUSA/VE";}
				case "AT"	{$result = "nonUSA/VE";}
				else		{$result = "USA/VE"};
			}
		}
		case "N"
		{
			switch($prefix2)
			{
				case "NL"	{$result = "nonUSA/VE";}
				case "NH"	{$result = "nonUSA/VE";}
				case "NP"	{$result = "nonUSA/VE";}
				else		{$result = "USA/VE"};
			}
		}
		case "V"
		{
			switch($prefix2)
			
			{
				case "VE"	{$result = "USA/VE";}
				case "VA"	{$result = "USA/VE";}
				case "VY"	{$result = "USA/VE";}
			}
		}
	}
	
    return $result;
}
