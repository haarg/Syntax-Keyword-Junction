package Syntax::Keyword::Junction::Base;
use strict;
use warnings;

our $VERSION = '0.003008';

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
    ('~~' => 'match') x!! ($] >= 5.010001 && $] < 5.041000),
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
