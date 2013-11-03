# Internal: Configure a host for hourly logrotate jobs.
#
# ensure - The desired state of hourly logrotate support.  Valid values are
#          'absent' and 'present' (default: 'present').
#
# Examples
#
#   # Set up hourly logrotate jobs
#   include logrotate::hourly
#
#   # Remove hourly logrotate job support
#   class { 'logrotate::hourly':
#     ensure => absent,
#   }
class logrotate::hourly($ensure='present') {
  case $ensure {
    'absent': {
      $dir_ensure = $ensure
    }
    'present': {
      $dir_ensure = 'directory'
    }
    default: {
      fail("Class[Logrotate::Hourly]: Invalid ensure value '${ensure}'")
    }
  }

  file { '/etc/logrotate.d/hourly':
    ensure => $dir_ensure,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  cron { 'logrotate hourly':
    ensure  => $ensure,
    command => 'test -x /usr/sbin/logrotate || exit 0; /usr/sbin/logrotate /etc/logrotate.d/hourly',
    minute  => '17',
    require => [
      File['/etc/logrotate.d/hourly'],
      Class['logrotate::package'],
    ],
  }

}
