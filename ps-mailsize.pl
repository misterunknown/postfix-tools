#!/usr/bin/env perl
#
# A simple policy-server for postfix which implements a message_size_limit per
# domain.

use strict;

# configuration of domains and limits, default action is OK
my %hashConfig = (
    "marco-pc-debian.localdomain" => 75,
    "example.org" => 1024,
);

my $action;
my %attr = ();

while( <STDIN> ) {
    if( /([^=]+)=(.*)\n/ ) {
        $attr{$1} = $2;
    } elsif( $_ eq "\n" ) {
        $action = "action=OK";
        foreach my $domain (keys%hashConfig) {
            if( $attr{'recipient'} =~ /${domain}$/ ) {
                if( $attr{'size'} > $hashConfig{$domain} ) {
                    $action = "action=534 message size for this domain is limited to ".$hashConfig{$domain};
                }
                last;
            }
        }
        print $action."\n\n";
        exit( 0 );
    }
}
