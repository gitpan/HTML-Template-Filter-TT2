use strict;
use Test::More;
use HTML::Template;

my $tests;
plan tests => $tests;

BEGIN { $tests = 3 }
use_ok("HTML::Template::Filter::TT2");
can_ok("HTML::Template::Filter::TT2", qw(ht_tt2_filter));
can_ok(__PACKAGE__, qw(ht_tt2_filter));


my $source = <<'TMPL';
title=[% title %]
[% if cond1 %]cond1=true[% else %]conf1=false[% end_if %]
[% if cond2 %]conf2=true[% else %]conf2=false[% end_if %]

interfaces: [% loop interface %]
  name=[% name %]  addr=[% address %][% end_loop %]
TMPL

my $expected = <<'RENDERED';
title=Lorem ipsum
cond1=true
conf2=false

interfaces: 
  name=lo  addr=127.0.0.1
  name=eth0  addr=192.168.1.1
RENDERED

my @args = (
    scalarref => \$source,
    filter => \&ht_tt2_filter,
);

my @params = (
    title => "Lorem ipsum",
    cond1 => 1,
    cond2 => 0,
    interface => [
        { name => "lo",    address => "127.0.0.1" },
        { name => "eth0",  address => "192.168.1.1" },
    ],
);

BEGIN { $tests += 4 }
my $tmpl = eval { HTML::Template->new(@args) };
is( $@, "", "creating a template which uses the TT2 syntax" );
isa_ok( $tmpl, "HTML::Template" );

eval { $tmpl->param(@params) };
is( $@, "", "passing params" );

is( $tmpl->output, $expected, "checking rendered output" );
