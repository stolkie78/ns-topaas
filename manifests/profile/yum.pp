# rhel6/base
# Define all generic Linux settings and packages for RHEL6

class topaas::profile::yum {
	case $operatingsystemmajrelease {
	  '6': {
			yumrepo { "RHEL6_CUSTOM_NS":
				baseurl		=> "http://nsrbamtst12.nsr.dev.infosupport.net/yumrepos/RHEL6",
				descr		=> "Custom RHEL6 Packages for NS",
				enabled		=> 1,
				gpgcheck	=> 0
			}

			# Packages to install
			$install = [ 'screen',
				           'ruby',
				           'cifs-utils',
				           'vim',
				           'xinetd',
				           'telnet',
				           'git',
			             'java-1.8.0-oracle.x86_64' ]
			package {$install:
				ensure  	=> present,
	  }
	  '7': {
			# Adding REPO
			yumrepo { "RHEL7_INSTALL":
				baseurl		=> "http://nsrbamtst12.nsr.dev.infosupport.net/iso/RHEL72/",
				descr		=> "RHEL7 Install Packages",
				enabled		=> 1,
				gpgcheck	=> 0
			}
			yumrepo { "RHEL6_CUSTOM_NS":
				baseurl		=> "http://nsrbamtst12.nsr.dev.infosupport.net/yumrepos/RHEL6",
				descr		=> "Custom RHEL6 Packages for NS",
				enabled		=> 1,
				gpgcheck	=> 0
			}

			# Packages to install
			$install = [ 'screen',
									 'ruby',
									 'cifs-utils',
									 'vim',
									 'xinetd',
									 'telnet',
									 'git',
									 'java-1.8.0-oracle.x86_64' ]
			package {$install:
				ensure  	=> present,
	  }
}
