class profile::infra::rhel6::oradb_ns::prerequisites {
	$oracle_base=hiera('oracle_base')
	$oracle_home=hiera('oracle_home')
	$version=hiera('version')
	$install_mount=hiera('install_mount')
	$tmp_dir=hiera('tmp_dir')

	$install = ['binutils.x86_64','compat-libstdc++-33.x86_64','compat-libstdc++-33.i686','glibc.x86_64','ksh.x86_64','libaio.i686',
		'libaio.x86_64','libgcc.x86_64','libgcc.i686','libstdc++.i686','libstdc++.x86_64','make.x86_64','compat-libcap1.x86_64',
		'gcc.x86_64','ksh','gcc-c++.x86_64','glibc-devel.i686','glibc-devel.x86_64','libaio-devel.x86_64','libaio-devel.i686',
		'libstdc++-devel.x86_64','libstdc++-devel.i686','sysstat.x86_64','unixODBC-devel','glibc.i686','libXext.x86_64','libXext.i686',
		'libXtst.x86_64','libXtst.i686','libX11.i686','libX11.x86_64','libXau.x86_64','libXau.i686','libxcb.i686','libxcb.x86_64',
		'libXi.i686','libXi.x86_64' ]
	package { $install:
			ensure  		=> present, 
	}

	# Oracle limits
	class { 'limits':
		config => {
			'*'      => { 'nofile'  => { soft => '2048'   , hard => '8192',   },},
			'oracle' => { 'nofile'  => { soft => '65536'  , hard => '65536',  },
			'nproc'  => { soft => '2048'   , hard => '16384',  },
			'stack'  => { soft => '10240'  ,},},
		},
	  use_hiera => false,
	}

	# Oracle sysctl config
	$shmmax=floor("$memorysize_mb"*0.8)*1024*1024
	$shmall=floor("$shmmax"/4096)

	sysctl { 'kernel.msgmnb':			ensure => 'present', permanent => 'yes', value => '65536',}
	sysctl { 'kernel.msgmax':			ensure => 'present', permanent => 'yes', value => '65536',}
	sysctl { 'kernel.shmmax':			ensure => 'present', permanent => 'yes', value => $shmmax,}
	sysctl { 'kernel.shmall':			ensure => 'present', permanent => 'yes', value => $shmall,}
	sysctl { 'fs.file-max':				ensure => 'present', permanent => 'yes', value => '13631488',}
	sysctl { 'net.ipv4.tcp_keepalive_time':		ensure => 'present', permanent => 'yes', value => '1800',}
	sysctl { 'net.ipv4.tcp_keepalive_intvl':	ensure => 'present', permanent => 'yes', value => '30',}
	sysctl { 'net.ipv4.tcp_keepalive_probes':	ensure => 'present', permanent => 'yes', value => '5',}
	sysctl { 'net.ipv4.tcp_fin_timeout':		ensure => 'present', permanent => 'yes', value => '30',}
	sysctl { 'kernel.shmmni':			ensure => 'present', permanent => 'yes', value => '4096',}
	sysctl { 'fs.aio-max-nr':			ensure => 'present', permanent => 'yes', value => '10485760',}
	sysctl { 'kernel.sem':				ensure => 'present', permanent => 'yes', value => '250 32000 100 128',}
	sysctl { 'net.ipv4.ip_local_port_range':	ensure => 'present', permanent => 'yes', value => '9000 65500',}
	sysctl { 'net.core.rmem_default':		ensure => 'present', permanent => 'yes', value => '262144',}
	sysctl { 'net.core.rmem_max':			ensure => 'present', permanent => 'yes', value => '4194304', }
	sysctl { 'net.core.wmem_default':		ensure => 'present', permanent => 'yes', value => '262144',}
	sysctl { 'net.core.wmem_max':			ensure => 'present', permanent => 'yes', value => '1048576',}

	# default oracle groups
	group { 'oinstall':				gid => '2000',ensure => 'present'}
	group { 'dba':		 			gid => '2001',ensure => 'present'}
	group { 'oper':		 			gid => '2002',ensure => 'present'}
	group { 'backupdba':				gid => '2003',ensure => 'present'}
	group { 'dgdba':		 		gid => '2004',ensure => 'present'}
	group { 'kmdba':				gid => '2005',ensure => 'present'}
	group { 'asmdba':		 		gid => '2006',ensure => 'present'}
	group { 'asmoper':			 	gid => '2007',ensure => 'present'}
	group { 'asmadmin':			 	gid => '2008',ensure => 'present'}

	# default oracle users
	user { 'oracle':
		uid 			=> '2000',
		gid			=> '2000',
		ensure 			=> 'present',
		groups			=> ['dba','oper'],
		home			=> '/home/oracle',
		managehome		=> 'yes',
		comment			=> 'Puppet added oracle user',
		password		=> '$6$EfZ4SwoG$Q3c8Jph201vZDUkAwY49x/UNtFk7SgV0u1PB8x6tuzeTLN95FGzcej4T.EssLS1jqOnzkiIELXDUN8pX/xcID/',
		shell			=> '/bin/bash',
	}
	ssh_authorized_key { 'nsrbamtst06':
		ensure              	=> present,
		user             	=> 'oracle',
		type			=> 'ssh-rsa',
		key 			=> 'AAAAB3NzaC1yc2EAAAABIwAAAQEAx2q4L8s3QLoMyyJ+nXToOgWqLz5Hwuf2hNdj46I7esuEAGIqi+AKhA++vr7Mw8yMxlbyB9Xl/u7ECXskgrZoiaPqvg4phyW+TXOXkQxPgJbsx9zFMa7W4uiNY0pK2fbaS7hOgo8zNREowavBLRDyLaK1IjFBzvGwjO638vQoBOrNWuC6JEStg5/r65/lqsXhw/j989O7vcyFMPkDSQWkkBoaahurNcWRfjL3xLrDtRMintAtVjlWpgkfDF6brBTNyJ9w6iHQT7AtV62uRRc8BcC8GyD4XJSqaoVTMdVZMBjn862mhawCh9A/yiRnCly1kDowNJT2r0Zl1fgNCkS2/Q==',
		require 		=> User['oracle']
		}


	# Using 90% mem for shm
	 mount {'/dev/shm':
                device  		=> 'tmpfs',
                options 		=> 'size=90%',
                ensure  		=> 'present'
        }

	# Creating dirs
	file {[	"${oracle_base}","${oracle_base}/product","${oracle_base}/product/${version}","${oracle_home}",	"/home/oracle/puppet"]:
		ensure			=> 'directory',
		owner			=> 'oracle',
		group			=> 'oinstall',
		mode			=> '0750'
	} ->
	file {[ "${install_mount}","${oracle_base}/local","${oracle_base}/local/dumps",	"${oracle_base}/global" ]:
		ensure 			=> 'directory'
	} ->

	# Mounting software sources
	mount {"/opt/oracle/install":
		device			=> "//nsrbambldsrv01/l/oracle/shares/install",
		name			=> "/opt/oracle/install",
		atboot 			=> "true",
		ensure 			=> "mounted",
		fstype 			=> "cifs",
		options 		=> "_netdev,username=buildserver,password=Bu!ldserver,dir_mode=0777,file_mode=0777,uid=500,gid=500",
		require			=> File['/opt/oracle/install']
	} ->
	mount {"/opt/oracle/local/dumps":
		device			=> "//nsrbambldsrv01/l/oracle/shares/dumps",
		name			=> "/opt/oracle/local/dumps",
		atboot 			=> "true",
		ensure 			=> "mounted",
		fstype 			=> "cifs",
		options 		=> "_netdev,username=buildserver,password=Bu!ldserver,dir_mode=0777,file_mode=0777,uid=500,gid=500",
		require			=> File['/opt/oracle/local/dumps']
	} ->
	mount {"/opt/oracle/global":
		device			=> "//nsrbambldsrv01/l/oracle/shares/global",
		name			=> "/opt/oracle/global",
		atboot			=> "true",
		ensure			=> "mounted",
		fstype			=> "cifs",
		options			=> "_netdev,username=buildserver,password=Bu!ldserver,dir_mode=0777,file_mode=0777,uid=500,gid=500",
		require			=> File['/opt/oracle/global']
		} ->
	# Pushing bashrc
	file { '/home/oracle/.bashrc':
		ensure 			=> present,
		source 			=> "puppet:///modules/profile/bashrc",
		owner  			=> 'oracle',
		group  			=> 'oinstall',
		mode   			=> '0750',
	}
	# Oracle init
	file { '/etc/init.d/oracle':
		ensure 			=> present,
		source 			=> "puppet:///modules/profile/oracle-init",
		owner  			=> 'oracle',
		group  			=> 'oinstall',
		mode   			=> '0750',
	}
	service { 'oracle':
		enable 			=> true,
	}
	# Create the temp location
	file { $tmp_dir:
		ensure 			=> 'directory',
		owner  			=> 'oracle',
		group  			=> 'oinstall',
		mode   			=> '0750',
	}
	sudo::conf {'oracle_sudo':
		ensure			=> 'present',
		source			=> 'puppet:///modules/profile/oracle-sudo',
		sudo_file_name		=> 'oradb'
	}
}
