package Tags::HTML::Container;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use List::Util qw(none);
use Readonly;

Readonly::Array our @HORIZ_ALIGN => qw(center left right);
Readonly::Array our @VERT_ALIGN => qw(base bottom center fit top);
Readonly::Hash our %VERT_CONV => (
	'base' => 'baseline',
	'bottom' => 'flex-end',
	'center' => 'center',
	'fit' => 'stretch',
	'top' => 'flex-start',
);

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my ($object_params_ar, $other_params_ar) = split_params(
		['css_container', 'css_inner', 'horiz_align', 'vert_align'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	# Container align.
	$self->{'horiz_align'} = 'center';
	$self->{'vert_align'} = 'center';

	# CSS classes.
	$self->{'css_container'} = 'container';
	$self->{'css_inner'} = 'inner';

	# Process params.
	set_params($self, @{$object_params_ar});

	if (! defined $self->{'horiz_align'}) {
		err "Parameter 'horiz_align' is required.";
	}
	if (none { $self->{'horiz_align'} eq $_ } @HORIZ_ALIGN) {
		err "Parameter 'horiz_align' have a bad value.",
			'Value', $self->{'horiz_align'},
		;
	}

	if (! defined $self->{'vert_align'}) {
		err "Parameter 'vert_align' is required.";
	}
	if (none { $self->{'vert_align'} eq $_ } @VERT_ALIGN) {
		err "Parameter 'vert_align' have a bad value.",
			'Value', $self->{'vert_align'},
		;
	}

	# Object.
	return $self;
}

sub _process {
	my ($self, $tags_cb) = @_;

	$self->{'tags'}->put(
		['b', 'div'],
		['a', 'class', $self->{'css_container'}],
		['b', 'div'],
		['a', 'class', $self->{'css_inner'}],
	);
	$tags_cb->($self);
	$self->{'tags'}->put(
		['e', 'div'],
		['e', 'div'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	$self->{'css'}->put(
		['s', '.'.$self->{'css_container'}],
		['d', 'display', 'flex'],
		['d', 'align-items', $VERT_CONV{$self->{'vert_align'}}],
		['d', 'justify-content', $self->{'horiz_align'}],
		['d', 'height', '100vh'],
		['e'],
	);

	return;
}

1;
