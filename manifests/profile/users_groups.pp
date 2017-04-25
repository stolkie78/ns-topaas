# Define users, ssh key,group and sudo for RHEL6

class topaas::profile::users_groups {
	# Groups
	group { 'sprinters':
		ensure		=> 'present',
		gid		=> '3000',
	}
	# Users
	user { 'giedo':
		ensure		=> 'present',
		home		=> '/home/giedo',
		gid		=> '3000',
		shell		=> '/bin/bash',
		managehome	=> true,
		uid		=> '3000'
	}
	user { 'jeroen':
		ensure		=> 'present',
		home		=> '/home/jeroen',
		gid		=> '3000',
		shell		=> '/bin/bash',
		managehome	=> true,
		uid		=> '3001'
	}
	user { 'marcel':
		ensure		=> 'present',
		home		=> '/home/marcel',
		gid		=> '3000',
		shell		=> '/bin/bash',
		managehome	=> true,
		uid		=> '3003'
	}
	user { 'manoj':
		ensure		=> 'present',
		home		=> '/home/manoj',
		gid		=> '3000',
		shell		=> '/bin/bash',
		managehome	=>  true,
		uid		=> '3004'
	}
	user { 'harald':
		ensure		=> 'present',
		home		=> '/home/harald',
		gid		=> '3000',
		shell		=> '/bin/bash',
		managehome	=> true,
		uid		=> '3005'
	}
	# Sudo
	sudo::conf {'sprinters_sudo':
                ensure          => 'present',
                source          => 'puppet:///modules/profile/sprinters-sudo',
                sudo_file_name  => 'sprinters'
        }
	# SSH keys
	ssh_authorized_key { 'giedo.stolk':
		 ensure 	=> present,
		 user   	=> 'giedo',
		 type   	=> 'ssh-rsa',
		 key    	=> 'AAAAB3NzaC1yc2EAAAABJQAAAQBKuO9uJEASnb9hwiwT5NHhxh/iOcQrHyGFl0Aur/MG9zRplCujvYp4JCR93ZPlt4SjOlnZVW4NSslDxUgV9VxASnbesNqYleyA+qG4K7SdwzjF+dkMgh2G9pCUcQSCvcoujDfDdYDycD/t0b4MJXu1LRiuszbU/cXLg2CVx1cNU33EwnkIc6BhcCaQwaI3N3Hqg4W1eoRdx6QPoaRapa4IXr2Bs5PpipJ+k1pUAKFVHu0vT+48u0L4NwiJXcvn+Rw02C5EjVzfaZkrPBv42/DXYAy5Rky5DkcTNMwt81Q8iQtpuALZ+Kkb8bVXdTXdAel6J2nw7TBnmSw2HG2tBkDt',
		 require	=> User['giedo']
	}
	ssh_authorized_key { 'harald.van.teeffelen':
		 ensure 	=> present,
		 user   	=> 'harald',
		 type   	=> 'ssh-rsa',
		 key    	=> 'AAAAB3NzaC1yc2EAAAABJQAAAIEAuNraoiddYWINh/A73BuRDlD7wyajp4HX/Fi/jpoPgxUpU+cZoCbkS22mp0m3LWqJH/zCJHJuh9o+RzMkRKsGi5KjNnQyisbIJecbDoNNC4iXqRfSFAZle1uz62KwuqABlh+0ema1N/X9Yrl8tSg5iNonB01+kboMLRPGjX7hho8=',
		 require	=> User['harald']
	}
  ssh_authorized_key { 'jeroen.admiraal':
		 ensure 	=> present,
		 user   	=> 'jeroen',
		 type   	=> 'ssh-rsa',
		 key    	=> 'AAAAB3NzaC1yc2EAAAABJQAAAQEAnyctzLTRs102ON1Z5slhYwapQuERDhFBe1hCFprRolEbl51lMMaFIqQQeHFUpFU+N7OGL67BkSo5dyvFr0mUWsbE+vb2YKfn2SqSzw7PLPBsUXdp9mLd2cRYzG73HK5oDENYDWzPchVuSvN3Dns/wFPvvpaUC0CluSS+Gonk0XuzoAnwVwMLgaaUatp4wteeTU/QwnGbVvGkpOxScnWrSB/d0Sezw3LR7gTH7XwqQECnulNyaysmS5ohY9WFC3rMvwGcEoye+FXBdgzR7p+mwI+3NkOiyyXxnVdXSL7jf5uTX4f5UAoyEV8s/jB6bZ/ZhOaybLYJE8C6iedlaES/yw==',
		 require	=> User['jeroen']
	}
}
