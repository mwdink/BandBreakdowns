#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] CQWW SSB";
my $excludeString = "Claimed";
my $hornString = "3830 Score Submittal";
my $datePage = "date.html"; 
my $indexPage;
my $index_content; 
my $offset1;
my $offset2;
my $ifdef = 0;

if ($ARGV[0] eq "Oct")
{
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-October/"; 
}
else
{
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-November/"; 
}
print "running $monthPage\n";

$indexPage = $monthPage.$datePage;
$index_content = get($indexPage); 

open INDEX_FILEHANDLE, ">indexPage.txt"; 
print INDEX_FILEHANDLE $index_content; 
close INDEX_FILEHANDLE;

open (FILE, "indexPage.txt") or die $!;
open (OUTPUT, '>>cqwwSSBBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,160Q,160Z,160DX,80Q,80Z,80DX,40Q,40Z,40DX,20Q,20Z,20DX,15Q,15Z,15DX,10Q,10Z,10DX,TotalQ,TotalZ,TotalDX,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
	}
	else
	{
		if ($line =~ m/CQWW SSB\E/) 
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
				$offset2 = index($postingContent, "Operator(s):");
				$offset2 -= 1;
				$fullCall = substr $postingContent, $offset1, $offset2-$offset1;
				chomp($fullCall);
				print $fullCall;
				print " ";
				print OUTPUT "$fullCall,";

				$region = find_Region($fullCall);
				print $region;
				print "\t";
				print OUTPUT "$region,";
				
				#Class Info
				$offset1 = index($postingContent, "Class: ");
				$offset1 += 7;
				$offset2 = index($postingContent, "QTH");
				$offset2 -= 1;
				$class = substr $postingContent, $offset1, $offset2-$offset1;
				chomp $class;
				print $class;
				print "\t";
				print OUTPUT "$class,";

				
				#Determine offsets
				$bandOffset = index($postingContent, " Band");
				#print $bandOffset;
				#print " ";
				$qsosOffset = index($postingContent, "QSOs");
				#print $qsosOffset;
				#print " ";
				$zoneOffset = index($postingContent, "Zones");
				#print $zoneOffset;
				#print " ";
				$dxOffset = index($postingContent, "Countries");
				$dxOffset;
				#print $dxOffset;
				#print " ";
				
				
				#160M Q Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += $qsosOffset - $bandOffset;
				$Info160Q = substr $postingContent, $offset1, 4;
				if ($Info160Q == "") 
				{
					$Info160Q = "0";
				}
				#print $Info160Q;
				#print " ";
				print OUTPUT "$Info160Q,";

				#160M Zone Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info160Z = substr $postingContent, $offset1, 5;
				if ($Info160Z == "") 
				{
					$Info160Z = 0;
				}
				#print $Info160Z;
				#print " ";
				print OUTPUT "$Info160Z,";

				#160M DX Info
				$offset1 = index($postingContent, "  160:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info160DX = substr $postingContent, $offset1, 6;
				chomp($Info160DX);
				my $l = length($Info160DX);
				$Info160DX = reverse unpack("A$l",reverse unpack("A$l",$Info160DX));
				if ($Info160DX == "") 
				{
					$Info160DX = 0;
				}
				#print $Info160DX;
				#print " ";
				print OUTPUT "$Info160DX,";

				#80M Q Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $qsosOffset - $bandOffset;
				$Info80Q = substr $postingContent, $offset1, 4;
				if ($Info80Q == "") 
				{
					$Info80Q = "0";
				}
				#print $Info80Q;
				#print " ";
				print OUTPUT "$Info80Q,";

				#80M Zone Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info80Z = substr $postingContent, $offset1, 5;
				if ($Info80Z == "") 
				{
					$Info80Z = 0;
				}
				#print $Info80Z;
				#print " ";
				print OUTPUT "$Info80Z,";

				#80M DX Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info80DX = substr $postingContent, $offset1, 6;
				chomp($Info80DX);
				my $l = length($Info80DX);
				$Info80DX = reverse unpack("A$l",reverse unpack("A$l",$Info80DX));
				if ($Info80DX == "") 
				{
					$Info80DX = 0;
				}
				#print $Info80DX;
				#print " ";
				print OUTPUT "$Info80DX,";


				#40M Q Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $qsosOffset - $bandOffset;
				$Info40Q = substr $postingContent, $offset1, 4;
				if ($Info40Q == "") 
				{
					$Info40Q = "0";
				}
				#print $Info40Q;
				#print " ";
				print OUTPUT "$Info40Q,";

				#40M Zone Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info40Z = substr $postingContent, $offset1, 4;
				if ($Info40Z == "") 
				{
					$Info40Z = 0;
				}
				#print $Info40Z;
				#print " ";
				print OUTPUT "$Info40Z,";

				#40M DX Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info40DX = substr $postingContent, $offset1, 6;
				chomp($Info40DX);
				my $l = length($Info40DX);
				$Info40DX = reverse unpack("A$l",reverse unpack("A$l",$Info40DX));
				if ($Info40DX == "") 
				{
					$Info40DX = 0;
				}
				#print $Info40DX;
				#print " ";
				print OUTPUT "$Info40DX,";

			
				#20M Q Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $qsosOffset - $bandOffset;
				$Info20Q = substr $postingContent, $offset1, 4;
				if ($Info20Q == "") 
				{
					$Info20Q = "0";
				}
				#print $Info20Q;
				#print " ";
				print OUTPUT "$Info20Q,";

				
				#20M Zone Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info20Z = substr $postingContent, $offset1, 4;
				if ($Info20Z == "") 
				{
					$Info20Z = 0;
				}
				#print $Info20Z;
				#print " ";
				print OUTPUT "$Info20Z,";

				#20M DX Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info20DX = substr $postingContent, $offset1, 6;
				chomp($Info20DX);
				my $l = length($Info20DX);
				$Info20DX = reverse unpack("A$l",reverse unpack("A$l",$Info20DX));
				if ($Info20DX == "") 
				{
					$Info20DX = 0;
				}
				#print $Info20DX;
				#print " ";
				print OUTPUT "$Info20DX,";

				#15M Q Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $qsosOffset - $bandOffset;
				$Info15Q = substr $postingContent, $offset1, 4;
				if ($Info15Q == "") 
				{
					$Info15Q = "0";
				}
				#print $Info15Q;
				#print " ";
				print OUTPUT "$Info15Q,";

				#15M Zone Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info15Z = substr $postingContent, $offset1, 4;
				if ($Info15Z == "") 
				{
					$Info15Z = 0;
				}
				#print $Info15Z;
				#print " ";
				print OUTPUT "$Info15Z,";

				#15M DX Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info15DX = substr $postingContent, $offset1, 6;
				chomp($Info15DX);
				my $l = length($Info15DX);
				$Info15DX = reverse unpack("A$l",reverse unpack("A$l",$Info15DX));
				if ($Info15DX == "") 
				{
					$Info15DX = 0;
				}
				#print $Info15DX;
				#print " ";
				print OUTPUT "$Info15DX,";


				#10M Q Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $qsosOffset - $bandOffset;
				$Info10Q = substr $postingContent, $offset1, 4;
				if ($Info10Q == "") 
				{
					$Info10Q = "0";
				}
				#print $Info10Q;
				#print " ";
				print OUTPUT "$Info10Q,";

				#10M Zone Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info10Z = substr $postingContent, $offset1, 4;
				if ($Info10Z == "") 
				{
					$Info10Z = 0;
				}
				#print $Info10Z;
				#print " ";
				print OUTPUT "$Info10Z,";
				
				#10M DX Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info10DX = substr $postingContent, $offset1, 5;
				chomp($Info10DX);
				my $l = length($Info10DX);
				$Info10DX = reverse unpack("A$l",reverse unpack("A$l",$Info10DX));
				if ($Info10DX == "") 
				{
					$Info10DX = 0;
				}
				#print $Info10DX;
				#print " ";
				print OUTPUT "$Info10DX,";
			
				
				#TotalQ Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 6;
				$offset1 += $qsosOffset - $bandOffset;
				$TotalQ = substr $postingContent, $offset1, 4;
				if ($TotalQ == "") 
				{	
					$TotalQ = "0";
				}
				#print $TotalQ;
				#print "\t";
				print OUTPUT "$TotalQ,";


			
				#TotalZ Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 35;
				$offset1 += ($zoneOffset - $bandOffset);
				$TotalZ = substr $postingContent, $offset1, 5;
				if ($TotalZ == "") 
				{	
					$TotalZ = "0";
				}
				#print $TotalZ;
				#print "\t";
				print OUTPUT "$TotalZ,";

				#TotalDX Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 29;
				$offset1 += ($dxOffset - $bandOffset);
				$TotalDX = substr $postingContent, $offset1, 6;
				if ($TotalDX == "") 
				{	
					$TotalDX = "0";
				}
				#print $TotalDX;
				#print "\t";
				print OUTPUT "$TotalDX,";

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
	$result = "non-USA";
	$prefix1 = substr $_[0], 1, 1;
	$prefix2 = substr $_[0], 1, 2;
	switch($prefix1)
	{
		case "K"
		{
			switch($prefix2)
			{
				case "KH"	{$result = "non-USA";}
				case "KL"	{$result = "non-USA";}
				case "KP"	{$result = "non-USA";}
				else		{$result = "USA"};
			}

		}
		case "W"
		{
			switch($prefix2)
			{
				case "WH"	{$result = "non-USA";}
				case "WL"	{$result = "non-USA";}
				case "WP"	{$result = "non-USA";}
				else		{$result = "USA"};
			}
		}
		case "A"
		{
			switch($prefix2)
			{
				case "AH"	{$result = "non-USA";}
				case "AL"	{$result = "non-USA";}
				case "AY"	{$result = "non-USA";}
				case "A5"	{$result = "non-USA";}
				case "A6"	{$result = "non-USA";}
				case "A7"	{$result = "non-USA";}
				else		{$result = "USA"};
			}
		}
		case "N"
		{
			switch($prefix2)
			{
				case "NH"	{$result = "non-USA";}
				case "NL"	{$result = "non-USA";}
				case "NP"	{$result = "non-USA";}
				else		{$result = "USA"};
			}
		}
	}
	
    return $result;
}
