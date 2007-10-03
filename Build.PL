use strict;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'HTML::Template::Filter::TT2',
    license             => 'perl',
    dist_author         => 'S�bastien Aperghis-Tramoni <sebastien@aperghis.net>',
    dist_version_from   => 'lib/HTML/Template/Filter/TT2.pm',
    build_requires => {
        'HTML::Template' => 0,
        'Test::More'     => 0,
    },
    add_to_cleanup      => [ 'HTML-Template-Filter-TT2-*' ],
);

$builder->create_build_script();