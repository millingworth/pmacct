# == Class: pmacct::install
#
# Installs the pmacct daemons
#
class pmacct::install {

  assert_private()

  ensure_packages(['pmacct'], { ensure => $::pmacct::ensure })

}
