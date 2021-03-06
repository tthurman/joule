#    Joule - track changes in an online list over time
#    Copyright (C) 2002-2009 Thomas Thurman
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

package Joule::Database;

use strict;
use warnings;
use DBI;

our $_dbh;

sub _startup {
    my $settings = do '/etc/joule.conf';
    $_dbh = DBI->connect($settings->{'database'},
			 $settings->{'user'},
			 $settings->{'password'},
			 { RaiseError => 1, AutoCommit => 0 });
}

sub handle {
    # maybe should check it's live?
    return $_dbh;
}

sub rollback {
    eval { $_dbh->rollback(); };
}

sub DESTROY {
    $_dbh->disconnect();
}

_startup;

1;
