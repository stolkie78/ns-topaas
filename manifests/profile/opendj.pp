# rhel6_opendj
# OpenDJ LDAP Role
class topaas::profile::opendj {
	$install = [ 'opendj-ns-3-0' ]

	package {$install:
		ensure		=> present,
		require		=> Class['topaas::profile::yum']
	}
}
