# rhel6/oradb_ns/storage_noasm.pp
class profile::infra::rhel6::oradb_ns::storage_noasm {

	$data_device=hiera('data_device')
	$root_dir=hiera('root_dir')
	$data_dir=hiera('data_dir')
	$fra_dir=hiera('fra_dir')

	lvm::volume { 'lv_data':
		ensure => present,
		vg     => 'vg_oracle',
		pv     => $data_device,
		fstype => 'ext4',
	} ->
	file { [ $root_dir ]:
		ensure => 'directory',
		owner  => 'oracle',
		group  => 'oinstall',
		mode   => '0755',
	} ->
	mount { $root_dir:
		device	=> '/dev/vg_oracle/lv_data',
		fstype	=> 'ext4',
		ensure	=> 'mounted',
		options => 'defaults',
		atboot 	=> 'true'
	} ->
	# Setup data directory
	file {[ $data_dir, $fra_dir, "${root_dir}/backup"]:
		ensure => 'directory',
		owner  => 'oracle',
		group  => 'oinstall',
		mode   => '0750',
	}
}
