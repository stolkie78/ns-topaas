# rhel6/base
# Define all generic Linux settings and packages for RHEL6

class topaas::profile::base {
	# Profile changes
	file_line { 'Alias to profile':
		path		=> '/etc/profile',
		line		=> 'alias vi=vim',
	}

	# Standard config files
	file { '/etc/screenrc':
		ensure		=> present,
		source		=> "puppet:///modules/profile/screenrc",
		owner		=> 'root',
		group		=> 'root',
		mode		=> '0644',
	}
}
