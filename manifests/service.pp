# == Class: pmacct::service
#
# Optionally manage the pmacct service
#
class pmacct::service {

  assert_private()

  if $::pmacct::manage_service {
    service { 'nfacctd':
      ensure    => running,
      hasstatus => true,
      enable    => true,
      require   => Class['::pmacct::configure'],
    }
  }
}
