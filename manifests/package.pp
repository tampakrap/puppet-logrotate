class logrotate::package {

  include logrotate

  if $::osfamily == 'Gentoo' {
    portage::package { $logrotate::package_name:
      keywords => $logrotate::gentoo_keywords,
      use      => $logrotate::gentoo_use,
      ensure   => $logrotate::package_ensure,
    }
  } else {
    package { $logrotate::package_name:
      ensure => $logrotate::package_ensure,
    }
  }

}
