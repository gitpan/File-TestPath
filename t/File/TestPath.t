#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '0.08';
$DATE = '2003/07/26';

use Cwd;
use File::Spec;
use Test;

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $__restore_dir__ $__tests__ @__restore_inc__);

   ########
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   $__tests__ = 5;
   plan(tests => $__tests__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs, undef) = File::Spec->splitpath( __FILE__ );
   chdir $vol if $vol;
   chdir $dirs if $dirs;
   ($vol, $dirs) = File::Spec->splitpath(cwd(), 'nofile'); # absolutify

   #######
   # Add the library of the unit under test (UUT) to @INC
   # It will be found first because it is first in the include path
   #
   use Cwd;
   @__restore_inc__ = @INC;

   ######
   # Find root path of the t directory
   #
   my @updirs = File::Spec->splitdir( $dirs );
   while(@updirs && $updirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @updirs;
   };
   chdir File::Spec->updir();
   my $lib_dir = cwd();

   #####
   # Add lib to the include path so that modules under lib at the
   # same level as t, will be found
   #
   my $inc_dir = File::Spec->catdir( $lib_dir, 'lib' );
   $inc_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $inc_dir;

   #####
   # Add tlib to the include path so that modules under tlib at the
   # same level as t, will be found
   #
   $inc_dir = File::Spec->catdir( $lib_dir, 'tlib' );
   $inc_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $inc_dir;
   chdir $dirs if $dirs;
}

END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}


#####
# New $fu object
#
use File::Package;
my $fp = 'File::Package';
my $ftp = 'File::TestPath';

#######
#
# ok: 1 
#
# R:
#
my $loaded;
print "# is_package_loaded\n";
ok ($loaded = $fp->is_package_loaded('File::TestPath'), ''); 

#######
# 
# ok:  2
#
# R:
# 
print "# load_package\n";
my $errors = $fp->load_package( 'File::TestPath' );
skip($loaded, $errors, '');
skip_rest( $errors, 2 );

####
#
# ok: 3
#
# R:
#
print "# find_t_paths\n";
unshift @INC,File::Spec->catdir(cwd(),'lib');
my @t_path = $ftp->find_t_paths( );
ok( $t_path[0], File::Spec->catdir(cwd(),'t'));
shift @INC;

####
#
# ok: 4
#
# R:
#
print "# test_lib2inc\n";
my @restore_inc = $ftp->test_lib2inc( );

my ($vol,$dirs) = File::Spec->splitpath( cwd(), 'nofile');
my @dirs = File::Spec->splitdir( $dirs );
pop @dirs;
shift @dirs unless $dirs[0];
my @expected_lib = ();
my @t_root = @dirs;
pop @t_root;
unshift @expected_lib, File::Spec->catdir($vol, @t_root);
$dirs[-1] = 'lib';
unshift @expected_lib, File::Spec->catdir($vol, @dirs);
$dirs[-1] = 'tlib';
unshift @expected_lib, File::Spec->catdir($vol, @dirs);

ok( join('; ', ($INC[0],$INC[1],$INC[2])), 
    join('; ', @expected_lib));

@INC = @restore_inc;

####
#
# ok: 5
#
# R:
#
print "# find_t_roots\n";
my $dir = File::Spec->catdir(cwd(),'lib');
$dir =~ s=/=\\=g if $^O eq 'MSWin32';
unshift @INC,$dir;
@t_path = $ftp->find_t_roots( );
$dir = cwd();
$dir =~ s=/=\\=g if $^O eq 'MSWin32';
ok( $t_path[0], $dir);
shift @INC;


####
# 
# Support:
#
#

sub skip_rest
{
    my ($results, $test_num) = @_;
    if( $results ) {
        for (my $i=$test_num; $i < $__tests__; $i++) { skip(1,0,0) };
        exit 1;
    }
}


__END__


=head1 NAME

FileUtil.t - test script for $fu

=head1 SYNOPSIS

 FileUtil.t 

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http://www.SoftwareDiamonds.com,
PROVIDES THIS SOFTWARE 
'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
SHALL SOFTWARE DIAMONDS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL,EXEMPLARY, OR 
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE,DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING USE OF THIS SOFTWARE, EVEN IF
ADVISED OF NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

## end of test script file ##

