package TestApp::SchemaInstance;
use strict;

use DBIx::DataModel;

DBIx::DataModel->Schema('TestApp::DMInstance');
TestApp::DMInstance->Table(qw/ Employee employee emp_id /);
TestApp::DMInstance->Table(qw/ Department department dpt_id /);

1;
