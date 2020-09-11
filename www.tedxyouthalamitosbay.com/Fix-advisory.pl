#!/usr/bin/perl 
use strict;

print "Hello, World!\n";

# my @files = glob( '*.html' );

#for my $file (@files) {
#    fix($file);
#}


# fix("index.html");

dir_listing('.');

my @paths;
sub dir_listing {
    my ($root) = @_;
    $root .= '/' unless $root =~ /\/$/;
    for my $f (glob "$root*"){
        push @paths, $f;
        dir_listing($f) if -d $f;
    }
    return @paths;
}

for my $rec (@paths) {
    if ($rec =~ /\.html$/) {
        # print "$rec\n";
        fix($rec);
    }
}


sub fix {
    my $filename = shift;

    print "Parse $filename\n";
    
    open (FH, '<', $filename) or die "Unable to open file, $!";

    my $html = '';
    while (my $line = <FH>) {
      # chomp $row;
      $html .= $line;
    }

    close FH;


    my $from = q{This site will be located at: www\.5thstreetchronicles\.com/tedxyouthalamitosbay-2017 from 15 October 2020\/\. There will be no further updates henceforth\.};
    my $to   = q{This site is in the process of moving and access by phone will not provide the optimum viewing experience.
                        It will be located at: www.5thstreetchronicles.com/tedxyouthalamitosbay-2017 from 15 October 2020. There will be no further updates henceforth.};
    $html =~ s/$from/$to/g;


    # $filename = "index-1.html";
    open(FH, '>', $filename) or die $!;

    print FH $html;

    close FH;
}
