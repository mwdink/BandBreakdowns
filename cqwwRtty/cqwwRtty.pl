#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] CQ WW RTTY";
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
	$monthPage = "http://lists.contesting.com/pipermail/3830/2012-September/"; 
}
print "running $monthPage\n";

$indexPage = $monthPage.$datePage;
$index_content = get($indexPage); 

open INDEX_FILEHANDLE, ">indexPage.txt"; 
print INDEX_FILEHANDLE $index_content; 
close INDEX_FILEHANDLE;

open (FILE, "indexPage.txt") or die $!;
open (OUTPUT, '>>cqwwRttyBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,80Q,80Pts,80Dom,80DX,80Z,40Q,40Pts,40Dom,40DX,40Z,20Q,20Pts,20Dom,20DX,20Z,15Q,15Pts,15Dom,15DX,15Z,10Q,10Pts,10Dom,10DX,10Z,TotalQ,TotalPts,TotalDom,TotalDX,TotalZ,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
	}
	else
	{
		if ($line =~ m/CQ WW RTTY\E/) 
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

				
				#Determine offsets
				$bandOffset = index($postingContent, " Band");
				#print $bandOffset;
				#print " ";
				$qsosOffset = index($postingContent, "QSOs");
				#print $qsosOffset;
				#print " ";
				$ptsOffset = index($postingContent, "Pts");
				#print $ptsOffset;
				#print " ";
				$domOffset = index($postingContent, "State/Prov");
				#print $domOffset;
				#print " ";
				$dxOffset = index($postingContent, "v  DX ");
				++$dxOffset;
				#print $dxOffset;
				#print " ";
				$zoneOffset = index($postingContent, "Zones");
				#print $zoneOffset;
				#print " ";
				$endOffset = $zoneOffset + 5;
				#print $endOffset;
				
				
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

				#80M Pts Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += ($ptsOffset - $bandOffset);
				$Info80Pts = substr $postingContent, $offset1, 4;
				if ($Info80Pts == "") 
				{
					$Info80Pts = 0;
				}
				#print $Info80Pts;
				#print " ";
				print OUTPUT "$Info80Pts,";

				#80M Dom Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += ($domOffset - $bandOffset);
				$Info80Dom = substr $postingContent, $offset1, 11;
				if ($Info80Dom == "") 
				{
					$Info80Dom = 0;
				}
				#print $Info80Dom;
				#print " ";
				print OUTPUT "$Info80Dom,";

				#80M DX Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info80DX = substr $postingContent, $offset1, 5;
				if ($Info80DX == "") 
				{
					$Info80DX = 0;
				}
				#print $Info80DX;
				#print " ";
				print OUTPUT "$Info80DX,";

				#80M Zone Info
				$offset1 = index($postingContent, "  80:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info80Z = substr $postingContent, $offset1, 4;
				chomp($Info80Z);
				if ($Info80Z == "") 
				{
					$Info80Z = 0;
				}
				#print $Info80Z;
				#print " ";
				print OUTPUT "$Info80Z,";


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

				#40M Pts Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += ($ptsOffset - $bandOffset);
				$Info40Pts = substr $postingContent, $offset1, 4;
				if ($Info40Pts == "") 
				{
					$Info40Pts = 0;
				}
				#print $Info40Pts;
				#print " ";
				print OUTPUT "$Info40Pts,";

				#40M Dom Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += ($domOffset - $bandOffset);
				$Info40Dom = substr $postingContent, $offset1, 11;
				if ($Info40Dom == "") 
				{
					$Info40Dom = 0;
				}
				#print $Info40Dom;
				#print " ";
				print OUTPUT "$Info40Dom,";

				#40M DX Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info40DX = substr $postingContent, $offset1, 5;
				if ($Info40DX == "") 
				{
					$Info40DX = 0;
				}
				#print $Info40DX;
				#print " ";
				print OUTPUT "$Info40DX,";

				#40M Zone Info
				$offset1 = index($postingContent, "  40:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info40Z = substr $postingContent, $offset1, 4;
				chomp($Info40Z);
				if ($Info40Z == "") 
				{
					$Info40Z = 0;
				}
				#print $Info40Z;
				#print " ";
				print OUTPUT "$Info40Z,";


				
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

				#20M Pts Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += ($ptsOffset - $bandOffset);
				$Info20Pts = substr $postingContent, $offset1, 4;
				if ($Info20Pts == "") 
				{
					$Info20Pts = 0;
				}
				#print $Info20Pts;
				#print " ";
				print OUTPUT "$Info20Pts,";

				#20M Dom Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += ($domOffset - $bandOffset);
				$Info20Dom = substr $postingContent, $offset1, 11;
				if ($Info20Dom == "") 
				{
					$Info20Dom = 0;
				}
				#print $Info20Dom;
				#print " ";
				print OUTPUT "$Info20Dom,";

				#20M DX Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info20DX = substr $postingContent, $offset1, 5;
				if ($Info20DX == "") 
				{
					$Info20DX = 0;
				}
				#print $Info20DX;
				#print " ";
				print OUTPUT "$Info20DX,";

				#20M Zone Info
				$offset1 = index($postingContent, "  20:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info20Z = substr $postingContent, $offset1, 4;
				chomp($Info20Z);
				if ($Info20Z == "") 
				{
					$Info20Z = 0;
				}
				#print $Info20Z;
				#print " ";
				print OUTPUT "$Info20Z,";
				
				
				
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

				#15M Pts Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += ($ptsOffset - $bandOffset);
				$Info15Pts = substr $postingContent, $offset1, 4;
				if ($Info15Pts == "") 
				{
					$Info15Pts = 0;
				}
				#print $Info15Pts;
				#print " ";
				print OUTPUT "$Info15Pts,";

				#15M Dom Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += ($domOffset - $bandOffset);
				$Info15Dom = substr $postingContent, $offset1, 11;
				if ($Info15Dom == "") 
				{
					$Info15Dom = 0;
				}
				#print $Info15Dom;
				#print " ";
				print OUTPUT "$Info15Dom,";

				#15M DX Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info15DX = substr $postingContent, $offset1, 5;
				if ($Info15DX == "") 
				{
					$Info15DX = 0;
				}
				#print $Info15DX;
				#print " ";
				print OUTPUT "$Info15DX,";

				#15M Zone Info
				$offset1 = index($postingContent, "  15:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info15Z = substr $postingContent, $offset1, 4;
				chomp($Info15Z);
				if ($Info15Z == "") 
				{
					$Info15Z = 0;
				}
				#print $Info15Z;
				#print " ";
				print OUTPUT "$Info15Z,";
				
				

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

				#10M Pts Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += ($ptsOffset - $bandOffset);
				$Info10Pts = substr $postingContent, $offset1, 4;
				if ($Info10Pts == "") 
				{
					$Info10Pts = 0;
				}
				#print $Info10Pts;
				#print " ";
				print OUTPUT "$Info10Pts,";

				#10M Dom Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += ($domOffset - $bandOffset);
				$Info10Dom = substr $postingContent, $offset1, 11;
				if ($Info10Dom == "") 
				{
					$Info10Dom = 0;
				}
				#print $Info10Dom;
				#print " ";
				print OUTPUT "$Info10Dom,";

				#10M DX Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += ($dxOffset - $bandOffset);
				$Info10DX = substr $postingContent, $offset1, 5;
				if ($Info10DX == "") 
				{
					$Info10DX = 0;
				}
				#print $Info10DX;
				#print " ";
				print OUTPUT "$Info10DX,";

				#10M Zone Info
				$offset1 = index($postingContent, "  10:");
				$offset1 += ($zoneOffset - $bandOffset);
				$Info10Z = substr $postingContent, $offset1, 4;
				chomp($Info10Z);
				if ($Info10Z == "") 
				{
					$Info10Z = 0;
				}
				#print $Info10Z;
				#print " ";
				print OUTPUT "$Info10Z,";

				
				
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

				#TotalPts Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 12;
				$offset1 += ($ptsOffset - $bandOffset);
				$TotalPts = substr $postingContent, $offset1, 4;
				if ($TotalPts == "") 
				{	
					$TotalPts = "0";
				}
				#print $TotalPts;
				#print "\t";
				print OUTPUT "$TotalPts,";

				#TotalDom Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 21;
				$offset1 += ($domOffset - $bandOffset);
				$TotalDom = substr $postingContent, $offset1, 11;
				if ($TotalDom == "") 
				{	
					$TotalDom = "0";
				}
				#print $TotalDom;
				#print "\t";
				print OUTPUT "$TotalDom,";

				#TotalDX Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 29;
				$offset1 += ($dxOffset - $bandOffset);
				$TotalDX = substr $postingContent, $offset1, 5;
				if ($TotalDX == "") 
				{	
					$TotalDX = "0";
				}
				#print $TotalDX;
				#print "\t";
				print OUTPUT "$TotalDX,";
				
				#TotalZ Info
				$offset1 = index($postingContent, "Total:");
				#$offset1 += 35;
				$offset1 += ($zoneOffset - $bandOffset);
				$TotalZ = substr $postingContent, $offset1, 4;
				if ($TotalZ == "") 
				{	
					$TotalZ = "0";
				}
				#print $TotalZ;
				#print "\t";
				print OUTPUT "$TotalZ,";


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
				case "A6"	{$result = "non-USA";}
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
