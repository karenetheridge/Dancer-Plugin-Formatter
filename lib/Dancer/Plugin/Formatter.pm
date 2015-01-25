package Dancer::Plugin::Formatter;
our $VERSION = '0.01';

=head1 NAME

Dancer::Plugin::Formatter - Data formatter for Dancer

=head1 VERSION

version 0.01

=head1 DESCRIPTION

Provides an easy way to reformat dates and other data in templates. 

=head1 CONFIGURATION

In your configuration file, make sure you have enable this plugin. You can list options right here:

  plugins:
    Formatter:
      default_date_format: "dd.mm.yyyy"

or default format can be changed later:

  # in code
  $Dancer::Plugin::Formatter::default_date_format = 'mm/dd/yyyy';

  # in template
  : set_default_date_format('yyyy-mm-dd');

=head1 USAGE  

  # in template
  <: $today | format_date :>

=cut

use strict;
use warnings;

use Dancer ':syntax';
use Dancer::Plugin;

# TODO Format should be chosen from user/locale settings
our $default_date_format = 'dd.mm.yyyy';

sub _format_date {
	# Quick and dirty date formatter:
	# YYYY-MM-DD to MM.DD.YYYY
	my @parts = split /\D/, shift;
    my $format = $default_date_format; # TODO get from args

	# Reorder parts
	return join '.', @parts[2, 1, 0] if $format eq 'dd.mm.yyyy';
	return join '/', @parts[1, 2, 0] if $format eq 'mm/dd/yyyy';
	# else
    # fallback to yyyy-mm-dd
	return join '-', @parts[0, 1, 2];
}

register 'date' => sub {
    _format_date(@_);
};

register 'format_date' => sub {
    _format_date(@_);
};

register 'set_default_date_format' => sub {
    $default_date_format = shift;
    return;
};

register_plugin;

1;

__END__

=head1 METHODS

=head2 format_date

Changes format of provided date.

    format_date('2015-01-25');
	
or

    <% date('2015-01-25') %>
    <% $date_variable | date %>

Input should be a ISO 8601 date - YYYY-MM-DD

=head2 set_default_date_format

Sets default date format.

    set_default_date_format('mm/dd/yyyy')

Available values: C<'dd.mm.yyyy'>, C<'mm/dd/yyyy'>, C<'yyyy-mm-dd'>.
Please feel free to suggest other formats to me - see below.

=head1 CONTRIBUTING

This module is developed on Github at:

L<http://github.com/shoorick/dancer-plugin-formatter>

=head1 BUGS

Please report any bugs or feature requests
to C<bug-dancer-plugin-formatter at rt.cpan.org>, or through the web interface
at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Dancer-Plugin-Formatter>
or to Github at L<https://github.com/shoorick/dancer-plugin-formatter/issues>

I will be notified, and then
you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Dancer::Plugin::Formatter

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dancer-Plugin-Formatter>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dancer-Plugin-Formatter>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Dancer-Plugin-Formatter>

=item * Search CPAN

L<http://search.cpan.org/dist/Dancer-Plugin-Formatter/>

=item * Public repository at github

L<https://github.com/shoorick/dancer-plugin-formatter>

=back

=head1 SEE ALSO

L<Dancer>

=head1 COPYRIGHT AND LICENSE

Copyright 2015 Alexander Sapozhnikov
E<lt>L<shoorick@cpan.org>E<gt> L<http://shoorick.ru>

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl programming language system itself.

See L<http://dev.perl.org/licenses/> for more information.

=cut
