#!/usr/bin/perl -w
#
# sectionize.pl
# --------------------------------------------------------------
# this script splits one SGML file into several files one per
# section.
# --------------------------------------------------------------
# PROBLEMS:
#	- naming scheme is harcoded
#	- last file has no sections itself (harmless)
# --------------------------------------------------------------
# Any comment to: Ricardo Mones Lastra <mones@aic.uniovi.es>
# 

(@ARGV > 0) or die ("Missing argument. Usage: $0 <filename>\n");

open (FH,"<$ARGV[0]");
my $fn = $ARGV[0];
$fn =~ s/\.sgml//;
my $sc = 1;
my $ofn = join ('.', $fn, sprintf("%.03d",$sc), 'sgml');
open (OF,">$ofn");
while (<FH>) {
  if (m#^</sect>*$#) {
    print OF $_;
    close (OF);
    $sc = $sc + 1;
    $ofn = join ('.', $fn, sprintf("%.03d",$sc), 'sgml');
    open (OF,">$ofn");    
  } 
  else {
    print OF $_;
  }
}
close (OF);
close (FH);
print "Done. $sc sections processed\n";
