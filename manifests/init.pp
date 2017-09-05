# == Class: pmacct
#
# A Puppet module for installing pmacct
#
# === Parameters
#
# 
class pmacct (
  $ensure = $pmacct::params::ensure,
  $pmacctd_nfprobe_config_file = $pmacct::params::pmacctd_nfprobe_config_file,
  $pmacctd_nfprobe_service_file = '/lib/systemd/system/pmacctd_nfprobe.service',
  $pmacctd_nfprobe_manage_service = $pmacct::params::pmacctd_nfprobe_manage_service,
  $backend_globals = $pmacct::params::backend_globals,
  $backend_listener = $pmacct::params::backend_listener,
  $backend_inputs = $pmacct::params::backend_inputs,
  $backend_config_file = $pmacct::params::backend_config_file,
  $backend_service_file = '/lib/systemd/system/nfacctd_backend.service',
  $backend_manage_service = $pmacct::params::backend_manage_service,
  $tee_config_file = $pmacct::params::tee_config_file,
  $tee_service_file = '/lib/systemd/system/nfacctd_tee.service',
  $tee_manage_service = $pmacct::params::tee_manage_service,
  $nfacctd_port = $pmacct::params::nfacctd_port,
  $tee = $pmacct::params::tee,
  $tee_receivers = { 1 => '127.0.0.1:2056' },
  $tee_receivers_list = $pmacct::params::tee_receivers_list,
  $tee_transparent = $pmacct::params::tee_transparent,
) inherits ::pmacct::params
{

  include ::pmacct::install
  include ::pmacct::configure
  include ::pmacct::service

  Class['::pmacct::install'] ->
  Class['::pmacct::configure'] ->
  Class['::pmacct::service']

}
