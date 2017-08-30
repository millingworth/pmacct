# == Class: pmacct::configure
#
# Configure pmacct daemons
#
class pmacct::configure {

  $_config_file = $::pmacct::config_file
  $_tee_receivers = $::pmacct::tee_receivers
  $_config_file_tee_receivers = $::pmacct::config_file_tee_receivers

  file { $_config_file:
    ensure  => file,
    content => template('pmacct/nfacctd.conf.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }

  file { $_config_file_tee_receivers:
    ensure  => file,
    content => template('pmacct/tee_receivers.lst.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }

}
