#!perl
#
# The copyright notice and plain old documentation (POD)
# are at the end of this file.
#
package  t::File::TestPath;

use strict;
use warnings;
use warnings::register;

use vars qw($VERSION $DATE $FILE );
$VERSION = '0.01';
$DATE = '2003/09/20';
$FILE = __FILE__;

########
# The Test::STDmaker module uses the data after the __DATA__ 
# token to automatically generate the this file.
#
# Don't edit anything before __DATA_. Edit instead
# the data after the __DATA__ token.
#
# ANY CHANGES MADE BEFORE the  __DATA__ token WILL BE LOST
#
# the next time Test::STDmaker generates this file.
#
#


=head1 TITLE PAGE

 Detailed Software Test Description (STD)

 for

 Perl File::TestPath Program Module

 Revision: -

 Version: 

 Date: 2003/09/20

 Prepared for: General Public 

 Prepared by:  http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com

 Classification: None

=head1 SCOPE

This detail STD and the 
L<General Perl Program Module (PM) STD|Test::STD::PerlSTD>
establishes the tests to verify the
requirements of Perl Program Module (PM) L<File::TestPath|File::TestPath>

The format of this STD is a tailored L<2167A STD DID|Docs::US_DOD::STD>.
in accordance with 
L<Detail STD Format|Test::STDmaker/Detail STD Format>.

#######
#  
#  4. TEST DESCRIPTIONS
#
#  4.1 Test 001
#
#  ..
#
#  4.x Test x
#
#

=head1 TEST DESCRIPTIONS

The test descriptions uses a legend to
identify different aspects of a test description
in accordance with
L<STD FormDB Test Description Fields|Test::STDmaker/STD FormDB Test Description Fields>.

=head2 Test Plan

 T: 4^

=head2 ok: 1


  C:
     use File::Spec;
  
     use File::Package;
     my $fp = 'File::Package';
     use File::TestPath;
     my $uut = 'File::TestPath';
     use File::TestPath;
 ^
 VO: ^
  N: UUT loaded^
  A: $fp->is_package_loaded($uut)^
  E:  '1'^
 ok: 1^

=head2 ok: 2

  N: find_t_paths^

  C:
    unshift @INC,File::Spec->catdir(cwd(),'lib');
    my @t_path = $uut->find_t_paths( );
 ^
  A: $t_path[0]^
  E: File::Spec->catdir(cwd(),'t')^
 ok: 2^

=head2 ok: 3

  C: shift @INC;^
  N: test_lib2inc^

  C:
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
 ^
  A: join('; ', ($INC[0],$INC[1],$INC[2]))^
  E: join('; ', @expected_lib)^
 ok: 3^

=head2 ok: 4

  C: @INC = @restore_inc;^
  N: find_t_roots^

  C:
    my $dir = File::Spec->catdir(cwd(),'lib');
    $dir =~ s=/=\\=g if $^^O eq 'MSWin32';
    unshift @INC,$dir;
    @t_path = $uut->find_t_roots( );
    $dir = cwd();
    $dir =~ s=/=\\=g if $^^O eq 'MSWin32';
 ^
  A: $t_path[0]^
  E: $dir^
 ok: 4^



#######
#  
#  5. REQUIREMENTS TRACEABILITY
#
#

=head1 REQUIREMENTS TRACEABILITY

  Requirement                                                      Test
 ---------------------------------------------------------------- ----------------------------------------------------------------


  Test                                                             Requirement
 ---------------------------------------------------------------- ----------------------------------------------------------------


=cut

#######
#  
#  6. NOTES
#
#

=head1 NOTES

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

#######
#
#  2. REFERENCED DOCUMENTS
#
#
#

=head1 SEE ALSO

L<File::TestPath>

=back

=for html
<hr>
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
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>

=cut

__DATA__

File_Spec: Unix^
UUT: File::TestPath^
Revision: -^
End_User: General Public^
Author: http://www.SoftwareDiamonds.com support@SoftwareDiamonds.com^
Detail_Template: ^
STD2167_Template: ^
Version: ^
Classification: None^
Temp: temp.pl^
Demo: TestPath.d^
Verify: TestPath.t^


 T: 4^


 C:
    use File::Spec;
 
    use File::Package;
    my $fp = 'File::Package';

    use File::TestPath;
    my $uut = 'File::TestPath';
    use File::TestPath;
^

VO: ^
 N: UUT loaded^
 A: $fp->is_package_loaded($uut)^
 E:  '1'^
ok: 1^

 N: find_t_paths^

 C:
   unshift @INC,File::Spec->catdir(cwd(),'lib');
   my @t_path = $uut->find_t_paths( );
^

 A: $t_path[0]^
 E: File::Spec->catdir(cwd(),'t')^
ok: 2^

 C: shift @INC;^
 N: test_lib2inc^

 C:
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
^

 A: join('; ', ($INC[0],$INC[1],$INC[2]))^
 E: join('; ', @expected_lib)^
ok: 3^

 C: @INC = @restore_inc;^
 N: find_t_roots^

 C:
   my $dir = File::Spec->catdir(cwd(),'lib');
   $dir =~ s=/=\\=g if $^^O eq 'MSWin32';
   unshift @INC,$dir;
   @t_path = $uut->find_t_roots( );
   $dir = cwd();
   $dir =~ s=/=\\=g if $^^O eq 'MSWin32';
^

 A: $t_path[0]^
 E: $dir^
ok: 4^

 C: shift @INC^

See_Also: L<File::TestPath>^

Copyright:
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
^


HTML:
<hr>
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
<!-- BLK ID="LOG_CGI" -->
<!-- /BLK -->
<p><br>
^



~-~
