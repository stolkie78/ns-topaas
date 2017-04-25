class topaas:role:jenkins_server {
	class {'topaas::profile::base':}
	class {'topaas::profile::users_groups':}
	class {'topaas::profile::jenkins::server_stable':}
}
