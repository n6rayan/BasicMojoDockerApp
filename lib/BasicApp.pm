package BasicApp;
use Mojo::Base 'Mojolicious';

sub setup_routes {
    my ($self) = @_;

    my $r = $self->routes;

    $r->get('/')->to('example#welcome');
}

sub setup_plugins {
    my ($self) = @_;
    my $config = $self->plugin('Config');

    my $minion_config = $config->{minion};

    $self->plugin('Mojolicious::Plugin::Minion' => {
        Pg => $minion_config->{database}
    });
    $self->plugin('Mojolicious::Plugin::Minion::Admin');
}

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->setup_routes();
    $self->setup_plugins();

    return $self;
}

1;
