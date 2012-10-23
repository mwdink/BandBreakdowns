#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] SAC SSB";
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
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-October/"; 
#}
#else
#{
	#$monthPage = "http://lists.contesting.com/pipermail/3830/2011-September/"; 
#}


print "running $monthPage\n";

$indexPage = $monthPage.$datePage;
$index_content = get($indexPage); 

open INDEX_FILEHANDLE, ">indexPage.txt"; 
print INDEX_FILEHANDLE $index_content; 
close INDEX_FILEHANDLE;

open (FILE, "indexPage.txt") or die $!;
open (OUTPUT, '>>SacSSBBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,80Q,80M,40Q,40M,20Q,20M,15Q,15M,10Q,10M,TotalQ,Mults,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
		#print "exclude\n";
	}
	else
	{
		if ($line =~ m/SAC SSB\E/) 
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
				$QOffset = index($postingContent, "QSOs");
				#print "Q-";
				#print $QOffset;
				#print " ";
				$mOffset = index($postingContent, "Mults");
				#print "M-";
				#print $mOffset;
				#print " ";

				#80Q Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $QOffset - $bandOffset;
				$Info80Q = substr $postingContent, $offset1, 4;
				my $l = length($Info80Q);
				$Info80Q = reverse unpack("A$l",reverse unpack("A$l",$Info80Q));
				if ($Info80Q == "") 
				{
					$Info80Q = "0";
				}
				#print $Info80Q;
				#print " ";
				print OUTPUT "$Info80Q,";

				#80M Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += ($mOffset - $bandOffset);
				$Info80M = substr $postingContent, $offset1, 4;
				chomp($Info80M);
				my $l = length($Info80M);
				$Info80M = reverse unpack("A$l",reverse unpack("A$l",$Info80M));
				if ($Info80M == "") 
				{
					$Info80M = 0;
				}
				#print $Info80M;
				#print " ";
				print OUTPUT "$Info80M,";

				#40Q Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $QOffset - $bandOffset;
				$Info40Q = substr $postingContent, $offset1, 4;
				my $l = length($Info40Q);
				$Info40Q = reverse unpack("A$l",reverse unpack("A$l",$Info40Q));
				if ($Info40Q == "") 
				{
					$Info40Q = "0";
				}
				#print $Info40Q;
				#print " ";
				print OUTPUT "$Info40Q,";

				#40M Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += ($mOffset - $bandOffset);
				$Info40M = substr $postingContent, $offset1, 4;
				chomp($Info40M);
				my $l = length($Info40M);
				$Info40M = reverse unpack("A$l",reverse unpack("A$l",$Info40M));
				if ($Info40M == "") 
				{
					$Info40M = 0;
				}
				#print $Info40M;
				#print " ";
				print OUTPUT "$Info40M,";

				#20Q Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $QOffset - $bandOffset;
				$Info20Q = substr $postingContent, $offset1, 4;
				my $l = length($Info20Q);
				$Info20Q = reverse unpack("A$l",reverse unpack("A$l",$Info20Q));
				if ($Info20Q == "") 
				{
					$Info20Q = "0";
				}
				#print $Info20Q;
				#print " ";
				print OUTPUT "$Info20Q,";

				#20M Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += ($mOffset - $bandOffset);
				$Info20M = substr $postingContent, $offset1, 4;
				chomp($Info20M);
				my $l = length($Info20M);
				$Info20M = reverse unpack("A$l",reverse unpack("A$l",$Info20M));
				if ($Info20M == "") 
				{
					$Info20M = 0;
				}
				#print $Info20M;
				#print " ";
				print OUTPUT "$Info20M,";

				#15Q Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $QOffset - $bandOffset;
				$Info15Q = substr $postingContent, $offset1, 4;
				my $l = length($Info15Q);
				$Info15Q = reverse unpack("A$l",reverse unpack("A$l",$Info15Q));
				if ($Info15Q == "") 
				{
					$Info15Q = "0";
				}
				#print $Info15Q;
				#print " ";
				print OUTPUT "$Info15Q,";

				#15M Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += ($mOffset - $bandOffset);
				$Info15M = substr $postingContent, $offset1, 4;
				chomp($Info15M);
				my $l = length($Info15M);
				$Info15M = reverse unpack("A$l",reverse unpack("A$l",$Info15M));
				if ($Info15M == "") 
				{
					$Info15M = 0;
				}
				#print $Info15M;
				#print " ";
				print OUTPUT "$Info15M,";

				#10Q Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $QOffset - $bandOffset;
				$Info10Q = substr $postingContent, $offset1, 4;
				my $l = length($Info10Q);
				$Info10Q = reverse unpack("A$l",reverse unpack("A$l",$Info10Q));
				if ($Info10Q == "") 
				{
					$Info10Q = "0";
				}
				#print $Info10Q;
				#print " ";
				print OUTPUT "$Info10Q,";

				#10M Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += ($mOffset - $bandOffset);
				$Info10M = substr $postingContent, $offset1, 4;
				chomp($Info10M);
				my $l = length($Info10M);
				$Info10M = reverse unpack("A$l",reverse unpack("A$l",$Info10M));
				if ($Info10M == "") 
				{
					$Info10M = 0;
				}
				print $Info10M;
				print " ";
				print OUTPUT "$Info10M,";
				
				#TotalQ Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += $QOffset - $bandOffset;
				$TotalQ = substr $postingContent, $offset1, 4;
				my $l = length($TotalQ);
				$TotalQ = reverse unpack("A$l",reverse unpack("A$l",$TotalQ));
				if ($TotalQ == "") 
				{	
					$TotalQ = "0";
				}
				print $TotalQ;
				print " ";
				print OUTPUT "$TotalQ,";

				#TotalM Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += ($mOffset - $bandOffset);
				$TotalM = substr $postingContent, $offset1, 5;
				my $l = length($TotalM);
				$TotalM = reverse unpack("A$l",reverse unpack("A$l",$TotalM));
				if ($TotalM == "") 
				{	
					$TotalM = "0";
				}
				print $TotalM;
				print " ";
				print OUTPUT "$TotalM,";


				#Score Info
				$offset1 = index($postingContent, "Total Score = ");
				$offset1 += 14;
				$offset2 = index($postingContent, "Club:");
				$offset2 -= 2;
				$Score = substr $postingContent, $offset1, $offset2-$offset1;
				$Score =~ s/,//g; 
				print $Score;
				my $l = length($Score);
				$Score = reverse unpack("A$l",reverse unpack("A$l",$Score));
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
	$result = "non-SCANDINAVIA";
	$prefix1 = substr $_[0], 0, 1;
	$prefix2 = substr $_[0], 0, 2;

	switch($prefix1)
	{
		case "S"
		{
			switch($prefix2)
			{
				case "SA"	{$result = "SCANDINAVIA";}
				case "SB"	{$result = "SCANDINAVIA";}
				case "SE"	{$result = "SCANDINAVIA";}
				case "SF"	{$result = "SCANDINAVIA";}
				case "SK"	{$result = "SCANDINAVIA";}
				case "SI"	{$result = "SCANDINAVIA";}
				case "SJ"	{$result = "SCANDINAVIA";}
				case "SM"	{$result = "SCANDINAVIA";}
				case "SO"	{$result = "SCANDINAVIA";}
				else		{$result = "non-SCANDINAVIA"};
			}
		}
		case "O"
		{
			switch($prefix2)
			{
				case "OH"	{$result = "SCANDINAVIA";}
				case "OG"	{$result = "SCANDINAVIA";}
				case "OI"	{$result = "SCANDINAVIA";}
				case "OY"	{$result = "SCANDINAVIA";}
				case "OV"	{$result = "SCANDINAVIA";}
				case "OZ"	{$result = "SCANDINAVIA";}
				else		{$result = "non-SCANDINAVIA"};
			}
		}
		case "L"
		{
			switch($prefix2)
			{
				case "LN"	{$result = "SCANDINAVIA";}
				case "LA"	{$result = "SCANDINAVIA";}
				else		{$result = "non-SCANDINAVIA"};
			}
		}
		case "7"
		{
			switch($prefix2)
			{
				case "7S"	{$result = "SCANDINAVIA";}
				else		{$result = "non-SCANDINAVIA"};
			}
		}
		case "8"
		{
			switch($prefix2)
			{
				case "8S"	{$result = "SCANDINAVIA";}
				else		{$result = "non-SCANDINAVIA"};
			}
		}
		case "5"
		{
			switch($prefix2)
			{
				case "5P"	{$result = "SCANDINAVIA";}
				else		{$result = "non-SCANDINAVIA"};
			}
		}
	}
    return $result;
}

