#!/usr/bin/perl 

use LWP::Simple; 
use Switch

my $searchString = "[3830] Makrothen RTTY";
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
open (OUTPUT, '>>MakrothenBreakdown.csv') or die $!;
print OUTPUT "Call,Class,80Q,40Q,20Q,15Q,10Q,TotalQ,Score\n";

while (my $line = <FILE>) 
{
	chomp $line;
	if ($line =~ m/$excludeString\E/) 
	{
		#print "exclude\n";
	}
	else
	{
		if ($line =~ m/Makrothen RTTY\E/) 
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

				#80Q Info
				$offset1 = index($postingContent, "   80:");
				$offset1 += $QOffset - $bandOffset;
				$Info80Q = substr $postingContent, $offset1, 4;
				chomp($Info80Q);
				my $l = length($Info80Q);
				$Info80Q = reverse unpack("A$l",reverse unpack("A$l",$Info80Q));
				if ($Info80Q == "") 
				{
					$Info80Q = "0";
				}
				#print $Info80Q;
				#print " ";
				print OUTPUT "$Info80Q,";

				#40Q Info
				$offset1 = index($postingContent, "   40:");
				$offset1 += $QOffset - $bandOffset;
				$Info40Q = substr $postingContent, $offset1, 4;
				chomp($Info40Q);
				my $l = length($Info40Q);
				$Info40Q = reverse unpack("A$l",reverse unpack("A$l",$Info40Q));
				if ($Info40Q == "") 
				{
					$Info40Q = "0";
				}
				#print $Info40Q;
				#print " ";
				print OUTPUT "$Info40Q,";

				#20Q Info
				$offset1 = index($postingContent, "   20:");
				$offset1 += $QOffset - $bandOffset;
				$Info20Q = substr $postingContent, $offset1, 4;
				chomp($Info20M);
				my $l = length($Info20Q);
				$Info20Q = reverse unpack("A$l",reverse unpack("A$l",$Info20Q));
				if ($Info20Q == "") 
				{
					$Info20Q = "0";
				}
				#print $Info20Q;
				#print " ";
				print OUTPUT "$Info20Q,";

				#15Q Info
				$offset1 = index($postingContent, "   15:");
				$offset1 += $QOffset - $bandOffset;
				$Info15Q = substr $postingContent, $offset1, 4;
				chomp($Info15M);
				my $l = length($Info15Q);
				$Info15Q = reverse unpack("A$l",reverse unpack("A$l",$Info15Q));
				if ($Info15Q == "") 
				{
					$Info15Q = "0";
				}
				#print $Info15Q;
				#print " ";
				print OUTPUT "$Info15Q,";

				#10Q Info
				$offset1 = index($postingContent, "   10:");
				$offset1 += $QOffset - $bandOffset;
				$Info10Q = substr $postingContent, $offset1, 4;
				chomp($Info10M);
				my $l = length($Info10Q);
				$Info10Q = reverse unpack("A$l",reverse unpack("A$l",$Info10Q));
				if ($Info10Q == "") 
				{
					$Info10Q = "0";
				}
				#print $Info10Q;
				#print " ";
				print OUTPUT "$Info10Q,";

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



