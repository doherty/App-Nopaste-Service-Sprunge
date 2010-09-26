use strict;
use warnings;

package App::Nopaste::Service::Sprunge;
# ABSTRACT: Adds sprunge.us support to L<App::Nopaste>

use base 'App::Nopaste::Service';

sub available {
    eval 'require WWW::Pastebin::Sprunge::Create; 1'
}

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
