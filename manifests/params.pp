# == Class: pmacct::params
#
# Defines platform specific default configuration parameters
#
class pmacct::params {

  $ensure = 'present'
  $pmacctd_nfprobe_config_file = '/etc/pmacct/pmacctd_nfprobe.conf'
  $pmacctd_nfprobe_manage_service = true
  $backend_config_file = '/etc/pmacct/nfacctd_backend.conf'
  $backend_manage_service = true
  $tee_config_file = '/etc/pmacct/nfacctd_tee.conf'
  $tee_manage_service = true
  $tee = true
  $tee_receivers_list = '/etc/pmacct/tee_receivers.lst'
  $tee_transparent = true
  
  $backend_listener = {
    'nfacctd_ip'             => '127.0.0.1',
    'nfacctd_port'           => '2058',
    'nfacctd_disable_checks' => 'true',
  }

  $backend_globals = {
    'print_output'             => 'formatted',
    'print_history'            => '5m',
    'print_history_roundoff'   => 'm',
    'print_refresh_time'       => '300',
    'print_output_file_append' => 'true',
  }

  $backend_inputs = {
    'print[traffic]'               => {
      'aggregate[traffic]'         => 'src_host, dst_host, src_port, dst_port',
      'print_output_file[traffic]' => '/srv/pmacct/traffic/traffic-%Y%m%d_%H%M.txt',
    },
    'amqp[traffic]'                   => {
      'aggregate[traffic]'            => 'src_host, dst_host',
      'aggregate_filter[traffic]'     => '(dst net 8.8.8.8/32) || (src net 8.8.8.8/32)',
      'amqp_exchange[traffic]'        => 'pmacct',
      'amqp_routing_key[traffic]'     => 'ark',
      'amqp_refresh_time[traffic]'    => '300',
      'sql_history[traffic]'          => '5m',
      'sql_history_roundoff[traffic]' => 'm',
    }
  }

}
