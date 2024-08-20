package Syntax::Keyword::Junction::Base;
use strict;
use warnings;

our $VERSION = '0.003009';

BEGIN {
  *_WANT_SMARTMATCH = ("$]" >= 5.010001 && "$]" < 5.041000) ? sub(){1} : sub(){0};
  my $category
    = "$]" >= 5.041000 ? undef
    : "$]" >= 5.037011 ? 'deprecated::smartmatch'
    : "$]" >= 5.017011 ? 'experimental::smartmatch'
    : undef;
  *_SMARTMATCH_WARNING_CATEGORY = sub(){$category};
}

use overload(
    '=='   => "num_eq",
    '!='   => "num_ne",
    '>='   => "num_ge",
    '>'    => "num_gt",
    '<='   => "num_le",
    '<'    => "num_lt",
    'eq'   => "str_eq",
    'ne'   => "str_ne",
    'ge'   => "str_ge",
    'gt'   => "str_gt",
    'le'   => "str_le",
    'lt'   => "str_lt",
    'bool' => "bool",
    '""'   => sub {shift},
    ('~~' => 'match') x!! _WANT_SMARTMATCH,
);


sub new { bless \@_, shift }

sub values {
    my $self = shift;
    return wantarray ? @$self : [ @$self ];
}

sub map {
    my ( $self, $code ) = @_;
    my $class = ref $self;
    $class->new( map { $code->( $_ ) } $self->values );
}

1;
