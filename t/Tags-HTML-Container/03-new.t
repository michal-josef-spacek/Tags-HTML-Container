use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean err_msg);
use Tags::HTML::Container;
use Tags::Output::Raw;
use Test::More 'tests' => 7;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::Container->new;
isa_ok($obj, 'Tags::HTML::Container');

# Test.
$obj = Tags::HTML::Container->new(
	'tags' => Tags::Output::Raw->new,
);
isa_ok($obj, 'Tags::HTML::Container');

# Test.
eval {
	Tags::HTML::Container->new(
		'tags' => 'foo',
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Missing required parameter 'tags'.",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'tags' => Tags::HTML::Container->new,
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'tags' must be a 'Tags::Output::*' class.\n",
	"Bad 'Tags::Output' instance.",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'align' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'align' is required.\n",
	"Parameter 'align' is required.");
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'align' => 'bad',
	);
};
my @error = err_msg();
is_deeply(
	\@error,
	[
		"Parameter 'align' have a bad value.",
		'Value',
		'bad',
	],
	"Parameter 'align' have a bad value.",
);
clean();
