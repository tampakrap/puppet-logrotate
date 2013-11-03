class logrotate (
  $package_name    = $logrotate::params::package_name,
  $package_ensure  = $logrotate::params::package_ensure,
  $gentoo_keywords = $logrotate::params::gentoo_keywords,
  $gentoo_use      = $logrotate::params::gentoo_use,
) inherits logrotate::params {

  include logrotate::package

  File {
    owner   => 'root',
    group   => 'root',
    require => Class['logrotate::package'],
  }

  file { '/etc/logrotate.d':
    ensure  => directory,
    mode    => '0755',
  }

  cron { 'logrotate daily':
    ensure  => $ensure,
    command => 'test -x /usr/sbin/logrotate || exit 0; /usr/sbin/logrotate /etc/logrotate.conf',
    hour    => '0',
    minute  => '8',
    require => [
      File['/etc/logrotate.conf'],
      Class['logrotate::package'],
    ],
  }

}
