# rhel6_opendj
# OpenDJ LDAP Role
class profile::infra::rhel6::opendj {
	$install = [ 'opendj-ns-3-0' ]

	package {$install:
		ensure		=> present,
		require		=> Class['topaas::profile::yum-rhel6']
	}
}
