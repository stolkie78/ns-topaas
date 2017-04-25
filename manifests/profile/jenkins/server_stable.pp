# jenkins/server_stable.pp
class profile::infra::rhel6::jenkins::server_stable {
	yumrepo { "JENKINS_STABLE":
		baseurl => "http://pkg.jenkins.io/redhat-stable",
		descr => "Stable Jenkins Repo",
		enabled => 1,
		gpgcheck => 0
	}

	$install = [ 'jenkins' ]

        package {$install:
                ensure  => present,
                require => Class['profile::infra::rhel6::base']
        }

	service { 'jenkins':
		ensure  => running
	}
}
