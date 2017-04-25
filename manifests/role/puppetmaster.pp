class topaas::role::puppetmaster {
	class {'topaas::profile::base':}
	class {'topaas::profile::users_groups':}
	class {'topaas::profile::opendj':}
}
