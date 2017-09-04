# == Class: pmacct::service
#
# Optionally manage the pmacct service
#
class pmacct::service {

  assert_private()

  #Disable the default nfacctd.service
  if $::pmacct::tee_manage_service or $::pmacct::backend_manage_service {
    service { 'nfacctd':
      ensure  => stopped,
      enable  => false,
      require => Class['::pmacct::configure'],
    }
  }

  if $::pmacct::pmacctd_nfprobe_manage_service {
    service { 'pmacctd_nfprobe':
      ensure    => running,
      hasstatus => true,
      enable    => true,
      require   => Class['::pmacct::configure'],
    }
  }
  if $::pmacct::tee_manage_service {
    service { 'nfacctd_tee':
      ensure    => running,
      hasstatus => true,
      enable    => true,
      require   => Class['::pmacct::configure'],
    }
  }
  if $::pmacct::backend_manage_service {
    service { 'nfacctd_backend':
      ensure    => running,
      hasstatus => true,
      enable    => true,
      require   => Class['::pmacct::configure'],
    }
  }
}
