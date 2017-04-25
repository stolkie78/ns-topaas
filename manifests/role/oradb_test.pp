class role::rhel6_oradb_test {
	class {'topaas::profile::base':} ->
	class {'topaas::profile::oradb::prerequisites':}
	#class {'profile::infra::oradb_storage_noasm':} ->
	#class {'profile::infra::oradb_install_software':} ->
	#class {'profile::infra::oradb_install_psuoct2016':} ->
	#class {'profile::infra::oradb_listener':}
	#profile::infra::oradb_create_database {'oradb_test': 			oracle_sid => 'test', 		dbca_template => 'dbca_sonar_noasm_20161217'}
}
