# == Class: pmacct::configure
#
# Configure pmacct daemons
#
class pmacct::configure {

  $_pmacctd_nfprobe_config_file = $::pmacct::pmacctd_nfprobe_config_file
  $_pmacctd_nfprobe_service_file = $::pmacct::pmacctd_nfprobe_service_file
  $_backend_config_file = $::pmacct::backend_config_file
  $_backend_service_file = $::pmacct::backend_service_file
  $_backend_globals = $::pmacct::backend_globals
  $_backend_listener = $::pmacct::backend_listener
  $_backend_inputs = $::pmacct::backend_inputs
  $_tee_service_file = $::pmacct::tee_service_file
  $_tee_config_file = $::pmacct::tee_config_file
  $_tee_receivers = $::pmacct::tee_receivers
  $_tee_receivers_list = $::pmacct::tee_receivers_list


  #Disable the default systemd unit file and clobber the config
  file { '/etc/pmacct/nfacctd.conf':
    ensure  => file,
    content  => '### Disabled - Managed by Puppet ###',
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    require => Class['::pmacct::install'],
  }->

  file { $_tee_receivers_list:
    ensure  => file,
    content => template('pmacct/tee_receivers.lst.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->

  file { $_tee_config_file:
    ensure  => file,
    content => template('pmacct/nfacctd_tee.conf.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->

  file { '/etc/default/nfacctd_tee':
    ensure  => file,
    content => template('pmacct/nfacctd_tee_environment.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->  

  file { $_tee_service_file:
    ensure  => file,
    content => template('pmacct/nfacctd_tee.service.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }~>
  exec { 'nfacct-tee-systemd-reload':
    command => 'systemctl daemon-reload',
    path => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }

  if $::pmacct::pmacctd_nfprobe_manage_service { 
    file { '/srv/pmacct':
      ensure  => directory,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      require => Class['::pmacct::install'],
    }->
    file { '/srv/pmacct/traffic':
      ensure  => directory,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      require => Class['::pmacct::install'],
    }
  }->

  file { $_backend_config_file:
    ensure  => file,
    content => template('pmacct/nfacctd_backend.conf.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->

  file { '/etc/default/nfacctd_backend':
    ensure  => file,
    content => template('pmacct/nfacctd_backend_environment.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->  

  file { $_backend_service_file:
    ensure  => file,
    content => template('pmacct/nfacctd_backend.service.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }~>
  exec { 'nfacct-backend-systemd-reload':
    command => 'systemctl daemon-reload',
    path => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }

  file { $_pmacctd_nfprobe_config_file:
    ensure  => file,
    content => template('pmacct/pmacctd_nfprobe.conf.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->

  file { '/etc/default/pmacctd_nfprobe':
    ensure  => file,
    content => template('pmacct/pmacctd_nfprobe_environment.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }->  

  file { $_pmacctd_nfprobe_service_file:
    ensure  => file,
    content => template('pmacct/pmacctd_nfprobe.service.erb'),
    mode    => '0640',
    owner   => 'root',
    group   => 'root',
    notify  => Class['::pmacct::service'],
    require => Class['::pmacct::install'],
  }~>
  exec { 'pmacctd-nfprobe-systemd-reload':
    command => 'systemctl daemon-reload',
    path => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }
  
}
