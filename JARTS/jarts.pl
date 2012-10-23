#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] JARTS";
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
open (OUTPUT, '>>JARTSBreakdown.csv') or die $!;
print OUTPUT "Call,Region,Class,80Q,80Pts,80Mults,40Q,40Pts,40Mults,20Q,20Pts,20Mults,15Q,15Pts,15Mults,10Q,10Pts,10Mults,TotalQ,TotalPts,TotalMults,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
		#print "exclude\n";
	}
	else
	{
		if ($line =~ m/JARTS\E/) 
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
				#print $QOffset;
				#print " ";
				$ptsOffset = index($postingContent, "Pts");
				#print $ptsOffset;
				#print " ";
				$multsOffset = index($postingContent, "Mults");
				#print $multOffset;
				#print " ";

				#80Q Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $QOffset - $bandOffset;
				$Info80Q = substr $postingContent, $offset1, 4;
				if ($Info80Q == "") 
				{
					$Info80Q = "0";
				}
				#print $Info80Q;
				#print " ";
				print OUTPUT "$Info80Q,";

				#80Pts Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $ptsOffset - $bandOffset;
				$Info80Pts = substr $postingContent, $offset1, 4;
				if ($Info80Pts == "") 
				{
					$Info80Pts = "0";
				}
				#print $Info80Pts;
				#print " ";
				print OUTPUT "$Info80Pts,";
				
				#80Mults Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $multsOffset - $bandOffset;
				$Info80Mults = substr $postingContent, $offset1, 5;
				chomp($Info80Mults);
				my $l = length($Info80Mults);
				$Info80Mults = reverse unpack("A$l",reverse unpack("A$l",$Info80Mults));
				if ($Info80Mults == "") 
				{
					$Info80Mults = "0";
				}
				#print $Info80Mults;
				#print " ";
				print OUTPUT "$Info80Mults,";
				
				#40Q Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $QOffset - $bandOffset;
				$Info40Q = substr $postingContent, $offset1, 4;
				if ($Info40Q == "") 
				{
					$Info40Q = "0";
				}
				#print $Info40Q;
				#print " ";
				print OUTPUT "$Info40Q,";

				#40Pts Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $ptsOffset - $bandOffset;
				$Info40Pts = substr $postingContent, $offset1, 4;
				if ($Info40Pts == "") 
				{
					$Info40Pts = "0";
				}
				#print $Info40Pts;
				#print " ";
				print OUTPUT "$Info40Pts,";
				
				#40Mults Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $multsOffset - $bandOffset;
				$Info40Mults = substr $postingContent, $offset1, 5;
				chomp($Info40Mults);
				my $l = length($Info40Mults);
				$Info40Mults = reverse unpack("A$l",reverse unpack("A$l",$Info40Mults));
				if ($Info40Mults == "") 
				{
					$Info40Mults = "0";
				}
				#print $Info40Mults;
				#print " ";
				print OUTPUT "$Info40Mults,";
				

				#20Q Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $QOffset - $bandOffset;
				$Info20Q = substr $postingContent, $offset1, 4;
				if ($Info20Q == "") 
				{
					$Info20Q = "0";
				}
				#print $Info20Q;
				#print " ";
				print OUTPUT "$Info20Q,";

				#20Pts Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $ptsOffset - $bandOffset;
				$Info20Pts = substr $postingContent, $offset1, 4;
				if ($Info20Pts == "") 
				{
					$Info20Pts = "0";
				}
				#print $Info20Pts;
				#print " ";
				print OUTPUT "$Info20Pts,";
				
				#20Mults Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $multsOffset - $bandOffset;
				$Info20Mults = substr $postingContent, $offset1, 5;
				chomp($Info20Mults);
				my $l = length($Info20Mults);
				$Info20Mults = reverse unpack("A$l",reverse unpack("A$l",$Info20Mults));
				if ($Info20Mults == "") 
				{
					$Info20Mults = "0";
				}
				#print $Info20Mults;
				#print " ";
				print OUTPUT "$Info20Mults,";
				
				#15Q Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $QOffset - $bandOffset;
				$Info15Q = substr $postingContent, $offset1, 4;
				if ($Info15Q == "") 
				{
					$Info15Q = "0";
				}
				#print $Info15Q;
				#print " ";
				print OUTPUT "$Info15Q,";

				#15Pts Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $ptsOffset - $bandOffset;
				$Info15Pts = substr $postingContent, $offset1, 4;
				if ($Info15Pts == "") 
				{
					$Info15Pts = "0";
				}
				#print $Info15Pts;
				#print " ";
				print OUTPUT "$Info15Pts,";
				
				#15Mults Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $multsOffset - $bandOffset;
				$Info15Mults = substr $postingContent, $offset1, 5;
				chomp($Info15Mults);
				my $l = length($Info15Mults);
				$Info15Mults = reverse unpack("A$l",reverse unpack("A$l",$Info15Mults));
				if ($Info15Mults == "") 
				{
					$Info15Mults = "0";
				}
				#print $Info15Mults;
				#print " ";
				print OUTPUT "$Info15Mults,";
				

				#10Q Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $QOffset - $bandOffset;
				$Info10Q = substr $postingContent, $offset1, 4;
				if ($Info10Q == "") 
				{
					$Info10Q = "0";
				}
				#print $Info10Q;
				#print " ";
				print OUTPUT "$Info10Q,";

				#10Pts Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $ptsOffset - $bandOffset;
				$Info10Pts = substr $postingContent, $offset1, 4;
				if ($Info10Pts == "") 
				{
					$Info10Pts = "0";
				}
				#print $Info10Pts;
				#print " ";
				print OUTPUT "$Info10Pts,";
				
				#10Mults Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $multsOffset - $bandOffset;
				$Info10Mults = substr $postingContent, $offset1, 5;
				chomp($Info10Mults);
				my $l = length($Info10Mults);
				$Info10Mults = reverse unpack("A$l",reverse unpack("A$l",$Info10Mults));
				if ($Info10Mults == "") 
				{
					$Info10Mults = "0";
				}
				#print $Info10Mults;
				#print " ";
				print OUTPUT "$Info10Mults,";
				
				#TotalQ Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += $QOffset - $bandOffset;
				$InfoTotalQ = substr $postingContent, $offset1, 4;
				if ($InfoTotalQ == "") 
				{
					$InfoTotalQ = "0";
				}
				#print $InfoTotalQ;
				#print " ";
				print OUTPUT "$InfoTotalQ,";

				#TotalPts Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += $ptsOffset - $bandOffset;
				$InfoTotalPts = substr $postingContent, $offset1, 4;
				if ($InfoTotalPts == "") 
				{
					$InfoTotalPts = "0";
				}
				#print $InfoTotalPts;
				#print " ";
				print OUTPUT "$InfoTotalPts,";
				
				#TotalMults Info
				$offset1 = index($postingContent, "Total:");
				$offset1 += $multsOffset - $bandOffset;
				$InfoTotalMults = substr $postingContent, $offset1, 5;
				chomp($InfoTotalMults);
				my $l = length($InfoTotalMults);
				$InfoTotalMults = reverse unpack("A$l",reverse unpack("A$l",$InfoTotalMults));
				if ($InfoTotalMults == "") 
				{
					$InfoTotalMults = "0";
				}
				#print $InfoTotalMults;
				#print " ";
				print OUTPUT "$InfoTotalMults,";
				


				#Score Info
				$offset1 = index($postingContent, "Total Score = ");
				$offset1 += 14;
				$offset2 = index($postingContent, "Club:");
				$offset2 -= 2;
				$Score = substr $postingContent, $offset1, $offset2-$offset1;
				$Score =~ s/,//g; 
				#print $Score;
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
	$result = "non-JAPAN";
	$prefix1 = substr $_[0], 0, 1;
	$prefix2 = substr $_[0], 0, 2;

	switch($prefix1)
	{
		case "J"
		{
			switch($prefix2)
			{
				case "J3"	{$result = "non-JAPAN";}
				else		{$result = "JAPAN"};
			}
		}
	}
    return $result;
}
