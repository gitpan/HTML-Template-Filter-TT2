package HTML::Template::Filter::TT2;
use strict;
require Exporter;

{
    no strict "vars";
    $VERSION = '0.01';
    @ISA     = qw(Exporter);
    @EXPORT  = qw(ht_tt2_filter);
}

=head1 NAME

HTML::Template::Filter::TT2 - Template Toolkit 2 syntax for HTML::Template

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use HTML::Template::Filter::TT2;

    my $tmpl = HTML::Template->new(filter => \&ht_tt2_filter, ...);

=head1 DESCRIPTION

This C<HTML::Template> filter allows you to use the Template Toolkit 2 
syntax, which is much less verbose than the default syntax. This is not 
an emulation of TT2, so you're still limited to the usual C<HTML::Template>
semantics. Also, in order to keep the filter fast and simple, the 
C<[% end %]> must be written with the block name. See below for details.

Recognized syntax:

=over

=item *

variables: C<[% variable %]>

=item *

C<if> statements: C<[% if condition %] ... [% else %] ... [end_if %]>

=item *

loops: C<[% loop loop-name %] ... [% end_loop %]>

=back

=head1 EXPORT

Exports the C<ht_tt2_filter> function by default.

=head1 FUNCTIONS

=head2 ht_tt2_filter()

Pass a reference to this function to the C<filter> parameter when calling
C<<HTML::Template->new()>>

=cut

sub ht_tt2_filter {
    my ($text_ref) = @_;
    $$text_ref =~ s{\[% *(loop|if|unless) +(\w+) *%\]}{<TMPL_\U$1\E $2>}gm;
    $$text_ref =~ s{\[% *(else) *%\]}{<TMPL_\U$1\E>}gm;
    $$text_ref =~ s{\[% *end_(\w+) *%\]}{</TMPL_\U$1\E>}gm;
    $$text_ref =~ s{\[% *(\w+) *%\]}{<TMPL_VAR $1>}gm;
}


=head1 AUTHOR

SE<eacute>bastien Aperghis-Tramoni, C<< <sebastien at aperghis.net> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-html-template-filter-tt2 at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=HTML-Template-Filter-TT2>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc HTML::Template::Filter::TT2

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/HTML-Template-Filter-TT2>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/HTML-Template-Filter-TT2>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=HTML-Template-Filter-TT2>

=item * Search CPAN

L<http://search.cpan.org/dist/HTML-Template-Filter-TT2>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2007 SE<eacute>bastien Aperghis-Tramoni, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of HTML::Template::Filter::TT2
