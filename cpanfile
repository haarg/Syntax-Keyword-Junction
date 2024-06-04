requires 'Sub::Exporter::Progressive' => 0.001006;
requires 'parent';   # for perl < 5.10.1
requires 'perl' => "5.006";

on test => sub {
   requires 'Test::More' => 0.88;
   requires 'Test::Needs' => '0.002006';
   requires 'syntax';
};

