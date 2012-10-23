#!/usr/bin/perl 
#

use LWP::Simple; 
use Switch

my $searchString = "[3830] WAE CW";
my $excludeString = "Claimed";
my $hornString = "3830 Score Submittal";
my $datePage = "date.html"; 
my $indexPage;
my $index_content; 
my $offset1;
my $offset2;
my $ifdef = 0;

if ($ARGV[0] eq "July")
{
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-August/"; 
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
open (OUTPUT, '>>waeCwBandBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,80QSO,80QTC,80M,40QSO,40QTC,40M,20QSO,20QTC,20M,15QSO,15QTC,15M,10QSO,10QTC,10M,TotalQ,TotalQTC,TotalM,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
	}
	else
	{
		if ($line =~ m/WAE CW\E/) 
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

				$region = find_Region($fullCall);
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

				#80M QSO Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 7;
				$Info80Q = substr $postingContent, $offset1, 5;
				if ($Info80Q == "") 
				{
					$Info80Q = "0";
				}
				#print $Info80Q;
				#print "\t";
				print OUTPUT "$Info80Q,";
				
				#80M QTC Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 12;
				$Info80QTC = substr $postingContent, $offset1, 5;
				if ($Info80QTC == "") 
				{
					$Info80QTC = 0;
				}
				#print $Info80QTC;
				#print "\t";
				print OUTPUT "$Info80QTC,";

				#80M Mult Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += 18;
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

				#40M QSO Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 7;
				$Info40Q = substr $postingContent, $offset1, 5;
				if ($Info40Q == "") 
				{
					$Info40Q = "0";
				}
				#print $Info40Q;
				#print "\t";
				print OUTPUT "$Info40Q,";
				
				#40M QTC Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 12;
				$Info40QTC = substr $postingContent, $offset1, 5;
				if ($Info40QTC == "") 
				{
					$Info40QTC = 0;
				}
				#print $Info40QTC;
				#print "\t";
				print OUTPUT "$Info40QTC,";

				#40M Mult Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += 18;
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
				
				#20M QSO Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 7;
				$Info20Q = substr $postingContent, $offset1, 5;
				if ($Info20Q == "") 
				{
					$Info20Q = "0";
				}
				#print $Info20Q;
				#print "\t";
				print OUTPUT "$Info20Q,";
				
				#20M QTC Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 12;
				$Info20QTC = substr $postingContent, $offset1, 5;
				if ($Info20QTC == "") 
				{
					$Info20QTC = 0;
				}
				#print $Info20QTC;
				#print "\t";
				print OUTPUT "$Info20QTC,";

				#20M Mult Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += 18;
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

				#15M QSO Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 7;
				$Info15Q = substr $postingContent, $offset1, 5;
				if ($Info15Q == "") 
				{
					$Info15Q = "0";
				}
				#print $Info15Q;
				#print "\t";
				print OUTPUT "$Info15Q,";
				
				#15M QTC Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 12;
				$Info15QTC = substr $postingContent, $offset1, 5;
				if ($Info15QTC == "") 
				{
					$Info15QTC = 0;
				}
				#print $Info15QTC;
				#print "\t";
				print OUTPUT "$Info15QTC,";

				#15M Mult Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += 18;
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
			
				#10M QSO Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 7;
				$Info10Q = substr $postingContent, $offset1, 5;
				if ($Info10Q == "") 
				{
					$Info10Q = "0";
				}
				#print $Info10Q;
				#print "\t";
				print OUTPUT "$Info10Q,";
				
				#10M QTC Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 12;
				$Info10QTC = substr $postingContent, $offset1, 5;
				if ($Info10QTC == "") 
				{
					$Info10QTC = 0;
				}
				#print $Info10QTC;
				#print "\t";
				print OUTPUT "$Info10QTC,";

				#10M Mult Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += 18;
				$offset2 = index($postingContent, "Total:");
				$offset2 -= 27;
				$Info10Mult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($Info10Mult == "") 
				{
					$Info10Mult = 0;
				}
				#print $Info10Mult;
				#print "\t";
				print OUTPUT "$Info10Mult,";			
				
				#TotalQ QSO Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += 7;
				$InfoTotalQ = substr $postingContent, $offset1, 5;
				if ($InfoTotalQ == "") 
				{
					$InfoTotalQ = "0";
				}
				#print $InfoTotalQ;
				#print "\t";
				print OUTPUT "$InfoTotalQ,";
				
				#TotalQ QTC Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += 12;
				$InfoTotalQTC = substr $postingContent, $offset1, 5;
				if ($InfoTotalQTC == "") 
				{
					$InfoTotalQTC = 0;
				}
				#print $InfoTotalQTC;
				#print "\t";
				print OUTPUT "$InfoTotalQTC,";

				#Total Mult Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += 18;
				$offset2 = index($postingContent, "Total Score = ");
				$offset2 -= 2;
				$InfoTotalMult = substr $postingContent, $offset1, $offset2-$offset1;
				if ($InfoTotalMult == "") 
				{
					$InfoTotalMult = 0;
				}
				#print $InfoTotalMult;
				#print "\t";
				print OUTPUT "$InfoTotalMult,";			

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


sub find_Region 
{
	$result = "non-Europe";
	$prefix1 = substr $_[0], 1, 1;
	$prefix2 = substr $_[0], 1, 2;
	$prefix3 = substr $_[0], 1, 3;
	$digit2 = substr $_[0], 2, 1;
	$digit3 = substr $_[0], 3, 1;
	switch($prefix1)
	{
		case "4"
		{
			switch($prefix2)
			{
				case "4O"	{$result = "Europe";}
			}
		}
		case "9"
		{
			$result = "Europe";
			switch($prefix2)
			{
				case "9V"	{$result = "non-Europe";}
			}
		}
		case "C"
		{
			switch($prefix2)
			{
				case "CR"	{$result = "Europe";}
			}
		}
		case "D"
		{
			$result = "Europe";
			switch($prefix2)
			{
				case "D4"	{$result = "non-Europe";}
			}
		}
		case "E"
		{
			switch($prefix2)
			{
				case "EA"	{$result = "Europe";}
				case "EF"	{$result = "Europe";}
				case "ES"	{$result = "Europe";}
			}
		}
		case "F"
		{
			$result = "Europe";
			switch($prefix2)
			{
				case "FM"	{$result = "non-Europe";}
			}
		}
		case "G"
		{
			$result = "Europe";
		}
		case "H"
		{
			$result = "Europe";
			switch($prefix2)
			{
				case "HL"	{$result = "non-Europe";}
			}
		}
		case "L"
		{
			$result = "Europe";
		}
		case "M"
		{
			$result = "Europe";
		}
		case "O"
		{
			$result = "Europe";
		}
		case "R"
		{
			switch($digit2)
			{
				case "1"	{$result = "Europe";}
				case "2"	{$result = "Europe";}
				case "3"	{$result = "Europe";}
				case "4"	{$result = "Europe";}
				case "5"	{$result = "Europe";}
				case "7"	{$result = "Europe";}
			}
			switch($digit3)
			{
				case "1"	{$result = "Europe";}
				case "2"	{$result = "Europe";}
				case "3"	{$result = "Europe";}
				case "4"	{$result = "Europe";}
				case "5"	{$result = "Europe";}
				case "7"	{$result = "Europe";}
			}
		}
		case "S"
		{
			switch($prefix2)
			{
				case "SO"	{$result = "Europe";}
				case "S5"	{$result = "Europe";}
				case "SN"	{$result = "Europe";}
				case "SP"	{$result = "Europe";}
			}
		}
		case "T"
		{
			$result = "Europe";
		}
		case "U"
		{
			switch($digit3)
			{
				case "1"	{$result = "Europe";}
				case "2"	{$result = "Europe";}
				case "3"	{$result = "Europe";}
				case "4"	{$result = "Europe";}
				case "5"	{$result = "Europe";}
				case "7"	{$result = "Europe";}
			}
		}
		case "Y"
		{
			$result = "Europe";
		}
		case "Z"
		{
			switch($prefix2)
			{
				case "Z3"	{$result = "Europe";}
			}
		}
	}
	
    return $result;
}
