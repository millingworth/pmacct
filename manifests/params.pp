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
  
}
