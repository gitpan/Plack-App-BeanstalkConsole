exit 0 if $ENV{AUTOMATED_TESTING};
use File::Which;
die "php-cgi not found; aborting" if not which("php-cgi");
# begin inc::DownloadShareDirContent (1)
use File::Spec;
use File::Temp 'tempdir';
use HTTP::Tiny;
use Archive::Extract;

my $archive_file = File::Spec->catfile(tempdir(CLEANUP => 1), "beanstalk_console.zip");
print "downloading https://github.com/downloads/ptrofimov/beanstalk_console/beanstalk_console.zip to $archive_file...
";
my $response = HTTP::Tiny->new->mirror('https://github.com/downloads/ptrofimov/beanstalk_console/beanstalk_console.zip', $archive_file);
$response->{success} or die "failed to download https://github.com/downloads/ptrofimov/beanstalk_console/beanstalk_console.zip into $archive_file";

my $extract_dir = 'share';
my $ae = Archive::Extract->new(archive => $archive_file);
$ae->extract(to => $extract_dir) or die "failed to extract $archive_file to $extract_dir ";
# end inc::DownloadShareDirContent (1)
use 5.006;
use Module::Build::Tiny 0.030;
Build_PL();
