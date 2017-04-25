alter system set diag_dest='/u01' scope=spfile;
alter system set sga_max_size=0 scope=spfile;
alter system set sga_target=0 scope=spfile;
alter system set pga_aggregate_target=0 scope=spfile;
alter system set memory_target=4G scope=spfile;
alter system set memory_max_target=4G scope=spfile;
