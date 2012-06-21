package TestApp::Model::DMInstance;
use strict;
use base qw/ Catalyst::Model::DBIDM /;

use TestApp::SchemaInstance;

__PACKAGE__->config(
    schema_class => 'TestApp::DMInstance',
    use_singleton => 0,
);

1;
