define profile::infra::rhel6::oradb_ns::create_database_cdb (
	$container_sid	){

	$oracle_base=hiera('oracle_base')
	$oracle_home=hiera('oracle_home')
	$root_dir=hiera('root_dir')
	$data_dir=hiera('data_dir')
	$fra_dir=hiera('fra_dir')
	$tmp_dir=hiera('tmp_dir')

	oradb::database{ $container_sid:
		oracle_base			=> $oracle_base,
		oracle_home			=> $oracle_home,
		version				=> '12.1',
		user				=> 'oracle',
		group				=> 'oinstall',
		download_dir			=> $tmp_dir,
		action				=> 'create',
		db_name				=> $container_sid,
		sys_password			=> 'Qwerty!0',
		system_password			=> 'Qwerty!0',
		character_set			=> 'AL32UTF8',
		nationalcharacter_set		=> 'AL16UTF16',
		sample_schema			=> 'FALSE',
		memory_percentage		=> '40',
		memory_total			=> '4096',
		database_type			=> 'MULTIPURPOSE',
		em_configuration		=> 'NONE',
		data_file_destination		=> $data_dir,
		recovery_area_destination	=> $fra_dir,
		init_params			=> {	'open_cursors'  	=> '1000',
							'processes' 		=> '600',
							'job_queue_processes' 	=> '4' },
		container_database=> true,
		require			=> Class['profile::infra::rhel6::oradb_ns::listener','profile::infra::rhel6::oradb_ns::prerequisites','profile::infra::rhel6::oradb_ins::install_software','profile::infra::rhel6::oradb_ns::install_psuoct2016']
}
# Add database to tnsnames.ora
#	oradb::tnsnames{$container_sid:
#		oracle_home          			=> $oracle_home,
#		user                 			=> 'oracle',
#		group                			=> 'oinstall',
#		server               			=> { myserver => { host => $fqdn , port => '1521', protocol => 'TCP' }},
#		connect_service_name 			=> $container_sid,
#		require              			=> Class['profile::listener','profile::prequisites','profile::install_db_software','profile::install_psuoct2016']
#	}
}
