# buildserver/jenkins_slave.pp
# setup everything for the jenkins slave

class profile::infra::rhel6::jenkins::slave {
        # Group
        group { 'jenkins':
                ensure          => 'present',
                gid             => '4000',
        }
        # User
        user { 'jenkins':
                ensure          => 'present',
                home            => '/home/jenkins',
                gid             => '4000',
                shell           => '/bin/bash',
                managehome      => true,
                uid             => '4000'
        }
        # SSH keys
        ssh_authorized_key { 'jenkins':
           ensure 	=> present,
           user   	=> 'jenkins',
           type   	=> 'ssh-rsa',
           key    	=> 'AAAAB3NzaC1yc2EAAAABJQAAAQEA8TiAvAGrZwZjPkyOd8djhWdRe2sOIekXLU+fF73B7lxSIg/6dd+yinjS4lkSm+VNQi57goSBStSNtoqWpvaZiv1UgKxfpSX1OfraMOd8VKXx8meuZnwQ15LCoaWUZjRSEbv4lZIqTsntvXEADjrxS2FhEHFvk75kY+JWgCKGPOvFRE1OhLbTUSC9yMCnxO83QeiZRskD/z3idW4vhK3K0YI12NQdhlgNR4A8fqLyL0gynZolvkJVvnEN0iSKCT3naZsGchf8JYqMk3cF1Q8ly8NVdrqgykabdt/B/7brJkbx7/Oyr+/BgE3win+JxiFsEUfPvkSUPThjrI5BztYPFQ==',
           require	=> User['jenkins']
        }
        # create jenkins worspace directory
        file { '/data/jenkins':
           ensure => 'directory',
           owner  => 'jenkins',
           group  => 'jenkins',
           mode   => '0750',
        }

        #create .netrc file for the jenkins user
        file { '/home/jenkins/.netrc':
    		ensure 			=> present,
    		source 			=> "puppet:///modules/profile/.netrc",
    		owner  			=> 'jenkins',
    		group  			=> 'jenkins',
    		mode   			=> '0600',
    	}
        #create .netrc file for the root user
        file { '/root/.netrc':
    		ensure 			=> present,
    		source 			=> "puppet:///modules/profile/.netrc",
    		owner  			=> 'root',
    		group  			=> 'root',
    		mode   			=> '0600',
    	}
}
