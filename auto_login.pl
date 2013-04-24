use HTTP::Request::Common qw(POST);
use LWP::UserAgent;
use LWP::ConnCache;

sub log1{
	($id,$pw) = @_;
	$ua = LWP::UserAgent->new;
	$ua->conn_cache(LWP::ConnCache->new());
	my $req = POST 'http://bbs.fudan.sh.cn/bbs/login',
	              [ "id"=>$id,"pw"=>$pw]; 
	print "Try to login user: $id\n";
	my$response = $ua->request($req);
	$cookie = $response->header('Set-Cookie');
	print "$cookie";
	print $response->as_string;
	print "Now log out\n";
	$ua->conn_cache(LWP::ConnCache->new());
  	$response = $ua->get("http://bbs.fudan.sh.cn/bbs/logout",
  	Cookie=>$cookie);
  	die "Error when logged out" unless $response.is_success;
}

my %users=(
account1=>'password1',
account2=>'password2'
);

while(my ($usr, $pwd)=each(%users)){
    log1($usr, $pwd);
}
