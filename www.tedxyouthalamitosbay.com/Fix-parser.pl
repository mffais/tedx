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
        print "$rec\n";
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


    my $from = q{<div id="headerwrap"   >};
    my $to   = q{<div id="headerwrap">
                    <div style="top:0px; left:0px; background-color:yellow; color:black; width:100%;">
                        This site will be located at: www.5thstreetchronicles.com/tedxyouthalamitosbay-2017 from 15 October 2020/. There will be no further updates henceforth.
                    </div>
};
    $html =~ s/$from/$to/;

    my $from = q{srcset=".*"};
    my $to   = q{};
    $html =~ s/$from/$to/;

    my $from = q{<script type='text/javascript' src='\.\./\.\./s0\.wp\.com/wp-content/js/devicepx-jetpack9491\.js\?ver=201952'></script>};
    my $to   = q{};
    $html =~ s/$from/$to/;

    my $from = q{<script type='text/javascript' src='\.\./\.\./s\.gravatar\.com/js/gprofiles8495\.js\?ver=2019Decaa'></script>};
    my $to   = q{<script type='text/javascript' src='https://s.gravatar.com/js/gprofiles8495.js?ver=2019Decaa'></script>};
    $html =~ s/$from/$to/;

    my $from = q{<script type='text/javascript' src='\.\./\.\./stats\.wp\.com/e-201952\.js' async defer></script>};
    my $to   = q{<script type='text/javascript' src='https://stats.wp.com/e-201952.js' async defer></script>};
    $html =~ s/$from/$to/;

    my $from = q{\.\./\.\./www\.google-analytics\.com/analytics\.js};
    my $to   = q{https://www.google-analytics.com/analytics.js};
    $html =~ s/$from/$to/;


    # $filename = "index-1.html";
    open(FH, '>', $filename) or die $!;

    print FH $html;

    close FH;
}
