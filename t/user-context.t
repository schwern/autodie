#!/usr/bin/perl -w
use strict;
use warnings;
use Test::More 'no_plan';
use File::Copy;
use constant NO_SUCH_FILE => 'this_file_had_better_not_exist';

# http://perlmonks.org/?node_id=744246 describes a situation where
# using autodie on user-defined functions can fail, depending upon
# their context.  These tests attempt to detect this bug.

eval {
    use autodie qw(copy);
    copy(NO_SUCH_FILE, 'xyzzy');
};

isnt("$@","","Copying a non-existent file should throw an error");

eval {
    use autodie qw(copy);
    my $x = copy(NO_SUCH_FILE, 'xyzzy');
};

isnt("$@","","This shouldn't change with scalar context");

eval {
    use autodie qw(copy);
    my @x = copy(NO_SUCH_FILE, 'xyzzy');
};

isnt("$@","","This shouldn't change with array context");
