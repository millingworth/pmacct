# == Class: pmacct
#
# A Puppet module for installing pmacct
#
# === Parameters
#
# 
class pmacct (
  $ensure = $pmacct::params::ensure,
  $config_file = $pmacct::params::config_file,
  $manage_service = $pmacct::params::manage_service,
  $nfacctd_port = $pmacct::params::nfacctd_port,
  $tee = $pmacct::params::tee,
  $tee_receivers = { 1 => '127.0.0.1:2056' },
  $config_file_tee_receivers = $pmacct::params::config_file_tee_receivers,
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
