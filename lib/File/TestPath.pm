#!perl
#
# Documentation, copyright and license is at the end of this file.
#


#####
#
# File::FileUtil package
#
package  File::TestPath;

use 5.001;
use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE);
$VERSION = '1.1';
$DATE = '2003/06/24';

use SelfLoader;
use File::Spec;

__DATA__

#####
#
#
sub test_lib2inc
{
   #######
   # Add the library of the unit under test (UUT) to @INC
   #
   use Cwd;
   my $work_dir = cwd();
   my ($vol,$dirs) = File::Spec->splitpath( $work_dir, 'nofile');
   my @dirs = File::Spec->splitdir( $dirs );
   while( $dirs[-1] ne 't' ) { 
       chdir File::Spec->updir();
       pop @dirs;
   };
   my @inc = @INC;
   chdir File::Spec->updir();
   my $lib_dir = cwd();
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;  # include the current test directory
   $lib_dir = File::Spec->catdir( cwd(), 'lib' );
   $lib_dir =~ s|/|\\|g if $^O eq 'MSWin32';  # microsoft abberation
   unshift @INC, $lib_dir;
   chdir $work_dir if $work_dir;
   @inc;
 
}


####
# Find test roots
#
sub find_t_roots
{
   #######
   # Add t directories to the search path
   #
   my ($t_dir,@dirs,$vol);
   my %t_root=();
   my @t_root = ();
   foreach my $dir (@INC) {
       ($vol,$t_dir) = File::Spec->splitpath( $dir, 'nofile' );
       @dirs = File::Spec->splitdir($t_dir);
       pop @dirs;
       $t_dir = File::Spec->catdir( @dirs);
       $t_dir = File::Spec->catpath( $vol, $t_dir, '');
       next unless $t_dir;
       next if $t_root{$t_dir}; # eliminate dups
       $t_root{$t_dir} = 1;
       push @t_root, $t_dir;
   }
   @t_root
}


####
# Find test paths
#
sub find_t_paths
{
   #######
   # Add t directories to the search path
   #
   my ($t_dir,@dirs,$vol);
   my @t_path=();
   foreach my $dir (@INC) {
       ($vol,$t_dir) = File::Spec->splitpath( $dir, 'nofile' );
       @dirs = File::Spec->splitdir($t_dir);
       $dirs[-1] = 't';
       $t_dir = File::Spec->catdir( @dirs);
       $t_dir = File::Spec->catpath( $vol, $t_dir, '');
       push @t_path,$t_dir;
   }
   @t_path;
}





1


__END__

=head1 NAME

File::TestPath - Determines directories for the test software

=head1 SYNOPSIS

  use File::TestPath

  @INC           = File::TestPath->test_lib2inc()
  @t_path        = File::TestPath->find_t_paths()
  @t_path        = File::TestPath->find_t_roots()


=head1 DESCRIPTION

The test software is traditionally not part of the Perl lib subtree
since it is usually of little concern to the end-user. 
The normal run environment does not support loading test program
modules outside the lib subtrees. 

This module provides methods to access program modules and other files
in the test subtree.

=head2 find_t_paths method

This method operates on the assumption that the test files are a subtree to
a directory named I<t> and the I<t> directories are on the same level as
the last directory of each directory tree specified in I<@INC>.
If this assumption is not true, this method most likely will not behave
very well.

The I<find_t_paths> method returns the directory trees in I<@INC> with
the last directory changed to I<t>.

For example, 

 ==> @INC

 myperl/lib
 perl/site/lib
 perl/lib 

 => File::FileUtil->find_t_paths()

 myperl/t
 perl/site/t
 perl/t 

=head2 find_t_roots method

This method operates on the assumption that the test files are a subtree to
a directory named I<t> and the I<t> directories are on the same level as
the last directory of each directory tree specified in I<@INC>.
If this assumption is not true, this method most likely will not behave
very well.

The I<find_t_roots> method returns the directory trees in I<@INC> with
last directory drooped.

For example, 

 ==> @INC

 myperl/lib
 perl/site/lib
 perl/lib 

 => File::FileUtil->find_t_roots()

 myperl
 perl/site
 perl

=head2 test_lib2inc method

 @INC           = File::FileUtil->test_lib2inc()

The I<test_lib2inc> method walks up the directory tree from the current
directory until it finds a directory named "t".
It then pushs the parent to that directory, and a directory with "t" 
replaced by "lib" onto @INC.
The I<test_lib2inc> method returns the @INC before it is altered so
that the using method may return @INC to before calling I<test_lib2inc>.

For example,

 ==> @INC

 perl/site/lib
 perl/lib 

 ==> cwd()

 myperl/t/mymodule/mytests

 => @restore_inc = File::FileUtil->find_t_roots()

 => @INC

 myperl/lib
 myperl
 perl/site/lib
 perl/lib

 => @restore_inc

 perl/site/lib
 perl/lib

=head1 NOTES

=head2 AUTHOR

The holder of the copyright and maintainer is

E<lt>support@SoftwareDiamonds.comE<gt>

=head2 COPYRIGHT NOTICE

Copyrighted (c) 2002 Software Diamonds

All Rights Reserved

=head2 BINDING REQUIREMENTS NOTICE

Binding requirements are indexed with the
pharse 'shall[dd]' where dd is an unique number
for each header section.
This conforms to standard federal
government practices, 490A (L<STD490A/3.2.3.6>).
In accordance with the License, Software Diamonds
is not liable for any requirement, binding or otherwise.

=head2 LICENSE

Software Diamonds permits the redistribution
and use in source and binary forms, with or
without modification, provided that the 
following conditions are met: 

=over 4

=item 1

Redistributions of source code must retain
the above copyright notice, this list of
conditions and the following disclaimer. 

=item 2

Redistributions in binary form must 
reproduce the above copyright notice,
this list of conditions and the following 
disclaimer in the documentation and/or
other materials provided with the
distribution.

=back

SOFTWARE DIAMONDS, http::www.softwarediamonds.com,
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

=back
=for html
<p><br>
<!-- BLK ID="NOTICE" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="OPT-IN" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="EMAIL" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="COPYRIGHT" -->
<!-- /BLK -->
<p><br>
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

### end of file ###