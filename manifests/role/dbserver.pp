class role::rhel6::weblogic_server {
	class {'profile::infra::rhel6::base':} 
	class {'profile::infra::rhel6::users_groups':} 
}
