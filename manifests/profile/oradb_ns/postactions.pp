define profile::infra::rhel6::oradb_ns::postactions (
	$oracle_sid){
	oradb::init_param{"SPFILE/diagnostic_dest@${oracle_sid}"
		ensure => 'present',
		value  => $root_dir
	}
}
