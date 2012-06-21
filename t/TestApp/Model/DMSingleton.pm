package TestApp::Model::DMSingleton;
use strict;
use base qw/ Catalyst::Model::DBIDM /;

use TestApp::SchemaSingleton;

__PACKAGE__->config(
    schema_class => 'TestApp::DMSingleton',
    use_singleton => 1,
    connect_info => [
        'dbi:Mock:',
        '',
        '',
        { RaiseError => 1 },
    ],
);

1;
