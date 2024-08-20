package Syntax::Keyword::Junction::Any;
use strict;
use warnings;

our $VERSION = '0.003009';

use parent 'Syntax::Keyword::Junction::Base';

BEGIN {
  if (Syntax::Keyword::Junction::Base::_WANT_SMARTMATCH) {
    eval '#line '.(__LINE__+1).' "' . __FILE__.qq["\n] . <<'END_CODE' or die $@;
no if Syntax::Keyword::Junction::Base::_SMARTMATCH_WARNING_CATEGORY,
  warnings => Syntax::Keyword::Junction::Base::_SMARTMATCH_WARNING_CATEGORY;

sub match {
    my ( $self, $other, $is_rhs ) = @_;

    if ($is_rhs) {
        for (@$self) {
            return 1 if $other ~~ $_;
        }

        return;
    }

    for (@$self) {
        return 1 if $_ ~~ $other;
    }

    return;
}

1;
END_CODE
  }
}

sub num_eq {
    return regex_eq(@_) if ref( $_[1] ) eq 'Regexp';

    my ( $self, $test ) = @_;

    for (@$self) {
        return 1 if $_ == $test;
    }

    return;
}

sub num_ne {
    return regex_ne(@_) if ref( $_[1] ) eq 'Regexp';

    my ( $self, $test ) = @_;

    for (@$self) {
        return 1 if $_ != $test;
    }

    return;
}

sub num_ge {
    my ( $self, $test, $switch ) = @_;

    return num_le( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ >= $test;
    }

    return;
}

sub num_gt {
    my ( $self, $test, $switch ) = @_;

    return num_lt( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ > $test;
    }

    return;
}

sub num_le {
    my ( $self, $test, $switch ) = @_;

    return num_ge( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ <= $test;
    }

    return;
}

sub num_lt {
    my ( $self, $test, $switch ) = @_;

    return num_gt( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ < $test;
    }

    return;
}

sub str_eq {
    my ( $self, $test ) = @_;

    for (@$self) {
        return 1 if $_ eq $test;
    }

    return;
}

sub str_ne {
    my ( $self, $test ) = @_;

    for (@$self) {
        return 1 if $_ ne $test;
    }

    return;
}

sub str_ge {
    my ( $self, $test, $switch ) = @_;

    return str_le( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ ge $test;
    }

    return;
}

sub str_gt {
    my ( $self, $test, $switch ) = @_;

    return str_lt( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ gt $test;
    }

    return;
}

sub str_le {
    my ( $self, $test, $switch ) = @_;

    return str_ge( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ le $test;
    }

    return;
}

sub str_lt {
    my ( $self, $test, $switch ) = @_;

    return str_gt( $self, $test ) if $switch;

    for (@$self) {
        return 1 if $_ lt $test;
    }

    return;
}

sub regex_eq {
    my ( $self, $test, $switch ) = @_;

    for (@$self) {
        return 1 if $_ =~ $test;
    }

    return;
}

sub regex_ne {
    my ( $self, $test, $switch ) = @_;

    for (@$self) {
        return 1 if $_ !~ $test;
    }

    return;
}

sub bool {
    my ($self) = @_;

    for (@$self) {
        return 1 if $_;
    }

    return;
}

1;
