# == Class: pmacct::params
#
# Defines platform specific default configuration parameters
#
class pmacct::params {

  $ensure = 'present'
  $config_file = '/etc/pmacct/nfacctd.conf'
  $manage_service = true
  $tee = true
  $config_file_tee_receivers = '/etc/pmacct/tee_receivers.lst'
  $tee_transparent = true
  
}
