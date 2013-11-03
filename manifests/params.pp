class logrotate::params {

  $package_ensure = 'installed'

  # Gentoo specific
  $gentoo_keywords = ''
  $gentoo_use      = ''

  # /etc/logrotate.conf
  $rotate       = '4'
  $rotate_every = 'weekly'
  $create       = true
  $compress     = false
  $dateext      = false

  case $::osfamily {
    'Debian': {
      include logrotate::defaults::debian
      $package_name = 'logrotate'
    }
    'Redhat': {
      include logrotate::defaults::redhat
      $package_name = 'logrotate'
    }
    'SuSE': {
      include logrotate::defaults::suse
      $package_name = 'logrotate'
    }
    'Gentoo': {
      include logrotate::defaults::gentoo
      $package_name = 'app-admin/logrotate'
    }
    default: { fail("Sorry, $operatingsystem is not supported") }
  }

}
