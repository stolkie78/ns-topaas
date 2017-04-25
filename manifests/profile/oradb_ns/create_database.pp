define profile::infra::rhel6::oradb_ns::create_database (
	$oracle_sid,
	$dbca_template){

	$oracle_base=hiera('oracle_base')
	$oracle_home=hiera('oracle_home')
	$root_dir=hiera('root_dir')
	$data_dir=hiera('data_dir')
	$fra_dir=hiera('fra_dir')
	$tmp_dir=hiera('tmp_dir')

	oradb::database{ "${oracle_sid}_database":
		oracle_base			=> $oracle_base,
		oracle_home			=> $oracle_home,
		version				=> '12.1',
		user				=> 'oracle',
		group				=> 'oinstall',
		download_dir			=> $tmp_dir,
		action				=> 'create',
		db_name				=> $oracle_sid,
		db_port				=> '1521',
		sys_password			=> 'Qwerty!0',
		system_password			=> 'Qwerty!0',
		data_file_destination		=> $data_dir,
		recovery_area_destination	=> $fra_dir,
		character_set			=> "AL32UTF8",
		nationalcharacter_set		=> "AL16UTF16",
		template			=> $dbca_template,
		puppet_download_mnt_point	=> "profile",
		require				=> Class['profile::infra::rhel6::oradb_ns::listener','profile::infra::rhel6::oradb_ns::prerequisites','profile::infra::rhel6::oradb_ns::install_software','profile::infra::rhel6::oradb_ns::install_psuoct2016']
	}
	# Add database to tnsnames.ora
	oradb::tnsnames{$oracle_sid:
		oracle_home			=> $oracle_home,
		user				=> 'oracle',
		group				=> 'oinstall',
		server				=> { myserver => { host => $fqdn , port => '1521', protocol => 'TCP' }},
		connect_service_name		=> $oracle_sid,
		require				=> Class['profile::infra::rhel6::oradb_ns::listener','profile::infra::rhel6::oradb_ns::prerequisites','profile::infra::rhel6::oradb_ns::install_software','profile::infra::rhel6::oradb_ns::install_psuoct2016']
	}
	# Instance specific dirs
	file{["${root_dir}/backup/${oracle_sid}", "/home/oracle/puppet/${oracle_sid}"]:
		ensure				=> 'directory',
		owner				=> 'oracle',
		group				=> 'oinstall',
		mode				=> '750'
	}
}
