class profile::infra::rhel6::oradb_ns::install_psuoct2016 {
	$oracle_home=hiera('oracle_home')
	$source_dir=hiera('source_dir')
	$tmp_dir=hiera('tmp_dir')

	exec {'unzip_p6880880_121010_Linux-x86-64.zip':
	    cwd				=> $oracle_home,
	    path			=> '/usr/bin',
	    command			=> "unzip -q -o  ${source_dir}/p6880880_121010_Linux-x86-64.zip",
	    require			=> Class['profile::infra::rhel6::oradb_ns::install_software'],
	    unless			=> "/bin/grep 12.2.0.1.8 ${oracle_home}/OPatch/version.txt"
	} ->
	file { "${oracle_home}/OPatch":
	    ensure			=> directory,
	    owner			=> 'oracle',
	    group			=> 'oinstall',
	    require			=> [ User['oracle'], Group['oinstall'], ],
	    recurse			=> true,
	} ->
	oradb::opatch{"install_PSUOCT2016":
	    ensure			=> 'present',
	    oracle_product_home		=> $oracle_home,
	    patch_id			=> '24315824',
	    patch_file			=> 'p24315824_121020_Linux-x86-64.zip',
	    use_opatchauto_utility	=> true,
	    user			=> 'oracle',
	    group			=> 'oinstall',
	    download_dir		=> $tmp_dir,
	    ocmrf			=> false,
	    puppet_download_mnt_point	=> $source_dir,
	    require			=> Class['profile::infra::rhel6::oradb_ns::install_software'],
	}->
	oradb::opatch{"install_PSUOCT2016_jvm":
	    ensure			=> 'present',
	    oracle_product_home		=> $oracle_home,
	    patch_id			=> '24006101',
	    patch_file			=> 'p24006101_121020_Linux-x86-64.zip',
	    use_opatchauto_utility	=> true,
	    user			=> 'oracle',
	    group			=> 'oinstall',
	    download_dir		=> $tmp_dir,
	    ocmrf			=> false,
	    puppet_download_mnt_point	=> $source_dir,
	    require			=> Class['profile::infra::rhel6::oradb_ns::install_software'],
	}
}
