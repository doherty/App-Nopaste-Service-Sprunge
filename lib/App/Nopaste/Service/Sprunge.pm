use strict;
use warnings;

package App::Nopaste::Service::Sprunge;
# ABSTRACT: adds sprunge.us support to App::Nopaste

use base 'App::Nopaste::Service';

=head1 METHODS

=head2 available

Returns whether or not L<WWW::Pastebin::Sprunge::Create> is
available so we can actually paste to L<http://sprunge.us>.

=cut

sub available {
    eval {
        require WWW::Pastebin::Sprunge::Create;
        1;
    };
}

=head2 run

Run the application code to paste to L<http://sprunge.us>.

=cut

sub run {
    my $self = shift;
    my %args = @_;

    require WWW::Pastebin::Sprunge::Create;

    my $paster = WWW::Pastebin::Sprunge::Create->new();
    my $ok = $paster->paste(
        $args{'text'},
        lang    => $args{'lang'},
    );

    return (0, $paster->error) unless $ok;
    return (1, $paster->paste_uri);
}

=head1 SEE ALSO

L<WWW::Pastebin::Sprunge::Create>

=cut

1;

__END__
