#!perl
#
#
use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE);
$VERSION = '0.09';   # automatically generated file
$DATE = '2003/09/20';
$FILE = __FILE__;

use Getopt::Long;
use Cwd;
use File::Spec;

##### Test Script ####
#
# Name: TestPath.t
#
# UUT: File::TestPath
#
# The module Test::STDmaker generated this test script from the contents of
#
# t::File::TestPath;
#
# Don't edit this test script file, edit instead
#
# t::File::TestPath;
#
#	ANY CHANGES MADE HERE TO THIS SCRIPT FILE WILL BE LOST
#
#       the next time Test::STDmaker generates this script file.
#
#

######
#
# T:
#
# use a BEGIN block so we print our plan before Module Under Test is loaded
#
BEGIN { 
   use vars qw( $__restore_dir__ @__restore_inc__);

   ########
   # Working directory is that of the script file
   #
   $__restore_dir__ = cwd();
   my ($vol, $dirs) = File::Spec->splitpath(__FILE__);
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
   # Add this to the include path. Thus modules that start with t::
   # will be found.
   # 
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;  # include the current test directory

   #####
   # Add lib to the include path so that modules under lib at the
   # same level as t, will be found
   #
   $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;

   #####
   # Add tlib to the include path so that modules under tlib at the
   # same level as t, will be found
   #
   $lib_dir = File::Spec->catdir( cwd(), 'tlib' );
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;
   chdir $dirs if $dirs;
 
   #####
   # Add lib under the directory where the test script resides.
   # This may be used to place version sensitive modules.
   #
   $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;

   ##########
   # Pick up a output redirection file and tests to skip
   # from the command line.
   #
   my $test_log = '';
   GetOptions('log=s' => \$test_log);

   ########
   # Using Test::Tech, a very light layer over the module "Test" to
   # conduct the tests.  The big feature of the "Test::Tech: module
   # is that it takes a expected and actual reference and stringify
   # them by using "Data::Dumper" before passing them to the "ok"
   # in test.
   #
   # Create the test plan by supplying the number of tests
   # and the todo tests
   #
   require Test::Tech;
   Test::Tech->import( qw(plan ok skip skip_tests tech_config) );
   plan(tests => 4);

}



END {

   #########
   # Restore working directory and @INC back to when enter script
   #
   @INC = @__restore_inc__;
   chdir $__restore_dir__;
}

   # Perl code from C:
    use File::Spec;
 
    use File::Package;
    my $fp = 'File::Package';

    use File::TestPath;
    my $uut = 'File::TestPath';
    use File::TestPath;

ok(  $fp->is_package_loaded($uut), # actual results
      '1', # expected results
     "",
     "UUT loaded");

#  ok:  1

   # Perl code from C:
   unshift @INC,File::Spec->catdir(cwd(),'lib');
   my @t_path = $uut->find_t_paths( );

ok(  $t_path[0], # actual results
     File::Spec->catdir(cwd(),'t'), # expected results
     "",
     "find_t_paths");

#  ok:  2

   # Perl code from C:
shift @INC;

   # Perl code from C:
   my @restore_inc = $uut->test_lib2inc( );

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

ok(  join('; ', ($INC[0],$INC[1],$INC[2])), # actual results
     join('; ', @expected_lib), # expected results
     "",
     "test_lib2inc");

#  ok:  3

   # Perl code from C:
@INC = @restore_inc;

   # Perl code from C:
   my $dir = File::Spec->catdir(cwd(),'lib');
   $dir =~ s=/=\\=g if $^O eq 'MSWin32';
   unshift @INC,$dir;
   @t_path = $uut->find_t_roots( );
   $dir = cwd();
   $dir =~ s=/=\\=g if $^O eq 'MSWin32';

ok(  $t_path[0], # actual results
     $dir, # expected results
     "",
     "find_t_roots");

#  ok:  4

   # Perl code from C:
shift @INC;


=head1 NAME

TestPath.t - test script for File::TestPath

=head1 SYNOPSIS

 TestPath.t -log=I<string>

=head1 OPTIONS

All options may be abbreviated with enough leading characters
to distinguish it from the other options.

=over 4

=item C<-log>

TestPath.t uses this option to redirect the test results 
from the standard output to a log file.

=back

=head1 COPYRIGHT

copyright © 2003 Software Diamonds.

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

/=over 4

/=item 1

Redistributions of source code, modified or unmodified
must retain the above copyright notice, this list of
conditions and the following disclaimer. 

/=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

/=back

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

