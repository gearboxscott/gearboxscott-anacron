# Class: cron::install
#
# This class ensures that the distro-appropriate cron package is installed
#
# Parameters:
#   package_ensure - Can be set to a package version, 'latest', 'installed' or 'present'.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#   This class should not be used directly under normal circumstances
#   Instead, use the *cron* class.

class anacron::install {

  $package_name = $::operatingsystem ? {
    /(RedHat|CentOS|OracleLinux|Amazon)/ => 'cronie',
    'Gentoo' => 'sys-process/vixie',
    'Ubuntu' => 'cron',
    default => 'cron',
  }

  package {
    'cron':
      ensure => installed,
      name   => $package_name,
  }
}

