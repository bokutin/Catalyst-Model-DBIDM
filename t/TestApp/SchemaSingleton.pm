package TestApp::SchemaSingleton;
use strict;

use DBIx::DataModel;

DBIx::DataModel->Schema('TestApp::DMSingleton');
TestApp::DMSingleton->Table(qw/ Employee employee emp_id /);
TestApp::DMSingleton->Table(qw/ Department department dpt_id /);

1;
