package Tags::HTML::Container;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use List::Util qw(none);
use Readonly;

Readonly::Array our @ALIGN => qw(center left right);

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my ($object_params_ar, $other_params_ar) = split_params(
		['align', 'css_container'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	# Container align.
	$self->{'align'} = 'center';

	# CSS class.
	$self->{'css_container'} = 'container';

	# Process params.
	set_params($self, @{$object_params_ar});

	if (! defined $self->{'align'}) {
		err "Parameter 'align' is required.";
	}
	if (none { $self->{'align'} eq $_ } @ALIGN) {
		err "Parameter 'align' have a bad value.",
			'Value', $self->{'align'},
		;
	}

	# Object.
	return $self;
}

sub _process {
	my ($self, $tags_cb) = @_;

	# TODO
	$self->{'tags'}->put(
		['b', 'div'],
		['a', 'class', $self->{'css_container'}],
	);
	$tags_cb->($self);
	$self->{'tags'}->put(
		['e', 'div'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	$self->{'css'}->put(
		['s', '.'.$self->{'css_container'}],
		# TODO
		['e'],
	);

	return;
}

1;
