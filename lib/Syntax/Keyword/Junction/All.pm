package Syntax::Keyword::Junction::All;
use strict;
use warnings;

our $VERSION = '0.003010';

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
            return unless $other ~~ $_;
        }

        return 1;
    }

    for (@$self) {
        return unless $_ ~~ $other;
    }

    return 1;
}

1;
END_CODE
  }
}

sub num_eq {
    return regex_eq(@_) if ref( $_[1] ) eq 'Regexp';

    my ( $self, $test ) = @_;

    for (@$self) {
        return unless $_ == $test;
    }

    return 1;
}

sub num_ne {
    return regex_ne(@_) if ref( $_[1] ) eq 'Regexp';

    my ( $self, $test ) = @_;

    for (@$self) {
        return unless $_ != $test;
    }

    return 1;
}

sub num_ge {
    my ( $self, $test, $switch ) = @_;

    return num_le( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ >= $test;
    }

    return 1;
}

sub num_gt {
    my ( $self, $test, $switch ) = @_;

    return num_lt( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ > $test;
    }

    return 1;
}

sub num_le {
    my ( $self, $test, $switch ) = @_;

    return num_ge( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ <= $test;
    }

    return 1;
}

sub num_lt {
    my ( $self, $test, $switch ) = @_;

    return num_gt( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ < $test;
    }

    return 1;
}

sub str_eq {
    my ( $self, $test ) = @_;

    for (@$self) {
        return unless $_ eq $test;
    }

    return 1;
}

sub str_ne {
    my ( $self, $test ) = @_;

    for (@$self) {
        return unless $_ ne $test;
    }

    return 1;
}

sub str_ge {
    my ( $self, $test, $switch ) = @_;

    return str_le( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ ge $test;
    }

    return 1;
}

sub str_gt {
    my ( $self, $test, $switch ) = @_;

    return str_lt( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ gt $test;
    }

    return 1;
}

sub str_le {
    my ( $self, $test, $switch ) = @_;

    return str_ge( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ le $test;
    }

    return 1;
}

sub str_lt {
    my ( $self, $test, $switch ) = @_;

    return str_gt( $self, $test ) if $switch;

    for (@$self) {
        return unless $_ lt $test;
    }

    return 1;
}

sub regex_eq {
    my ( $self, $test, $switch ) = @_;

    for (@$self) {
        return unless $_ =~ $test;
    }

    return 1;
}

sub regex_ne {
    my ( $self, $test, $switch ) = @_;

    for (@$self) {
        return unless $_ !~ $test;
    }

    return 1;
}

sub bool {
    my ($self) = @_;

    for (@$self) {
        return unless $_;
    }

    return 1;
}

1;
