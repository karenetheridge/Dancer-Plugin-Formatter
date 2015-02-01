use Test::More tests => 1;
use strict;
use warnings;

use Dancer::Plugin::Formatter;

$Dancer::Plugin::Formatter::default_date_format = '%Y-%m';
my $sub = Dancer::Plugin::Formatter::format_date();

ok( $sub->(1422777777) eq '2015-02', 'unixtime' );
