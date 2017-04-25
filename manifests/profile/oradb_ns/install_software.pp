class profile::infra::rhel6::oradb_ns::install_software {

	$oracle_base=hiera('oracle_base')
	$oracle_home=hiera('oracle_home')
	$install_mount=hiera('install_mount')
	$inventory=hiera('inventory')
	$tmp_dir=hiera('tmp_dir')
	$source_dir=hiera('source_dir')

	oradb::installdb{ '12.1.0.2_Linux-x86-64':
		version				=> '12.1.0.2',
		file				=> 'linuxamd64_12102_database',
		database_type			=> 'EE',
		oracle_base			=> $oracle_base,
		oracle_home			=> $oracle_home,
		bash_profile			=> false,
		user				=> 'oracle',
		group				=> 'dba',
		group_install			=> 'oinstall',
		group_oper			=> 'oper',
		ora_inventory_dir		=> $inventory,
		download_dir			=> $tmp_dir,
		remote_file			=> false,
		puppet_download_mnt_point	=> $source_dir,
		zip_extract			=> true,
		require				=> Class['profile::infra::rhel6::oradb_ns::prerequisites'],
	}
}
