#!perl

use FindBin;
use lib $FindBin::Bin;
use lib "$FindBin::Bin/../inc";

use Test::More;
use Test::Exception;
use Catalyst::Test 'TestApp';

my $content;

$content = get('/model/DM');
is($content, 'TestApp::DM');
$content = get('/model_got_dbh');
is($content, 'DBI::db');

$content = get('/model/DM%3A%3AEmployee');
is($content, 'TestApp::DM::Employee');

$content = get('/model/DM%3A%3ADepartment');
is($content, 'TestApp::DM::Department');

subtest "config->{use_singleton} = 1" => sub {
    my ($res, $c) = ctx_request('/model/DM');

    isa_ok( $c->model("DMSingleton"),             "DBIx::DataModel::Schema" );
    isa_ok( $c->model("DMSingleton::Employee"),   "DBIx::DataModel::Source::Table" );
    isa_ok( $c->model("DMSingleton::Department"), "DBIx::DataModel::Source::Table" );
    isa_ok( $c->model("DMSingleton")->dbh,        "DBI::db");

    done_testing;
};

subtest "config->{use_singleton} = 0" => sub {
    my ($res, $c) = ctx_request('/model/DM');

    throws_ok { $c->model("DMInstance") } qr/Please override method/;

    TestApp::Model::DMInstance->meta->add_override_method_modifier( get_schema_instance => sub {
        my ($self, $c, $schema_class) = @_;

        my $schema = $schema_class->new(
            dbh => $c->model("DM")->dbh,
            sql_abstract => SQL::Abstract::More->new(
                quote_char => q{"}, name_sep => q{.},
            ),
        );
    });

    isa_ok( $c->model("DMInstance"),             "DBIx::DataModel::Schema" );
    isa_ok( $c->model("DMInstance::Employee"),   "DBIx::DataModel::ConnectedSource" );
    isa_ok( $c->model("DMInstance::Department"), "DBIx::DataModel::ConnectedSource" );

    done_testing;
};

done_testing;
