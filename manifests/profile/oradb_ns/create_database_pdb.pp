define profile::infra::rhel6:oradb_ns::create_database_pdb (
	$pdb_sid,
	$container_sid	){

	oradb::database_pluggable{ $pdb_sid:
		ensure                   => 'present',
		version                  => '12.1',
		oracle_home_dir          => $oracle_home,
		user                     => 'oracle',
		group                    => 'oinstall',
		source_db                => $container_sid,
		pdb_name                 => $pdb_sid,
		pdb_admin_username       => 'pdb_admin',
		pdb_admin_password       => 'Qwerty!0',
		pdb_datafile_destination => "${data_dir}/${pdb_sid}",
		create_user_tablespace   => true,
		log_output               => true,
		require			 => Class['profile::infra::rhel6:oradb_ns::listener','profile::infra:rhel6::oradb_ns::prerequisites','profile::infra::rhel6::oradb_ns::install_db_software','profile::infra::rhel6::oradb_ns::install_psuoct2016']
}
# Add database to tnsnames.ora
#	oradb::tnsnames{$pdb_sid:
#		oracle_home          			=> $oracle_home,
#		user                 			=> 'oracle',
#		group                			=> 'oinstall',
#		server               			=> { myserver => { host => $fqdn , port => '1521', protocol => 'TCP' }},
#		connect_service_name 			=> $pdb_sid,
#	}
}
