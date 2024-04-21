use strict;
use warnings;

use CSS::Struct::Output::Structure;
use English;
use Error::Pure::Utils qw(clean err_msg);
use Tags::HTML::Container;
use Tags::Output::Structure;
use Test::MockObject;
use Test::More 'tests' => 14;
use Test::NoWarnings;

# Test.
my $obj = Tags::HTML::Container->new;
isa_ok($obj, 'Tags::HTML::Container');

# Test.
$obj = Tags::HTML::Container->new(
	'css' => CSS::Struct::Output::Structure->new,
	'tags' => Tags::Output::Structure->new,
);
isa_ok($obj, 'Tags::HTML::Container');

# Test.
eval {
	Tags::HTML::Container->new(
		'css' => 'foo',
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class.\n",
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class (foo).",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'css' => Test::MockObject->new,
	);
};
is(
	$EVAL_ERROR,
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class.\n",
	"Parameter 'css' must be a 'CSS::Struct::Output::*' class (bad instance).",
);
clean();

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
		'tags' => Test::MockObject->new,
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
		'horiz_align' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'horiz_align' is required.\n",
	"Parameter 'horiz_align' is required.");
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'horiz_align' => 'bad',
	);
};
my @error = err_msg();
is_deeply(
	\@error,
	[
		"Parameter 'horiz_align' have a bad value.",
		'Value',
		'bad',
	],
	"Parameter 'horiz_align' have a bad value.",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'vert_align' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'vert_align' is required.\n",
	"Parameter 'vert_align' is required.");
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'vert_align' => 'bad',
	);
};
@error = err_msg();
is_deeply(
	\@error,
	[
		"Parameter 'vert_align' have a bad value.",
		'Value',
		'bad',
	],
	"Parameter 'vert_align' have a bad value.",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'height' => 'bad',
	);
};
@error = err_msg();
is_deeply(
	\@error,
	[
		"Parameter 'height' doesn't contain number.",
		'Value',
		'bad',
	],
	"Parameter 'height' doesn't contain number.",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'height' => '100',
	);
};
@error = err_msg();
is_deeply(
	\@error,
	[
		"Parameter 'height' doesn't contain unit.",
		'Value',
		'100',
	],
	"Parameter 'height' doesn't contain unit.",
);
clean();

# Test.
eval {
	Tags::HTML::Container->new(
		'height' => '100xx',
	);
};
@error = err_msg();
is_deeply(
	\@error,
	[
		"Parameter 'height' contain bad unit.",
		'Unit',
		'xx',
		'Value',
		'100xx',
	],
	"Parameter 'height' contain bad unit.",
);
clean();
