class profile::infra::rhel6::oradb_ns::listener{
	$oracle_base=hiera('oracle_base')
	$oracle_home=hiera('oracle_home')
	$root_dir=hiera('root_dir')

	db_listener{ 'startlistener':
		ensure			=>'running',
		oracle_base_dir		=>$oracle_base,
		oracle_home_dir		=>$oracle_home,
		os_user			=>'oracle',
		listener_name		=>'listener',
		require			=>Class['profile::infra::rhel6::oradb_ns::install_software','profile::infra::rhel6::oradb_ns::install_psuoct2016']
	}
	file{"${oracle_home}/network/admin/listener.ora":
		ensure			=>file,
		content			=>template('profile/oradb_listener.ora.erb')
	}
}
