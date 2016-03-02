define cron::schedule (
  $filename = $title,
  $ensure = 'present',
  $type = '',
  $script = '',
  $cron_schedule = '',
) {

  include stdlib
 
  case $cron_schedule {
    /^(hourly|daily|weekly|monthly)$/: { }
    default: { fail( 'CUSTOM ERROR: Invalid cron_schedule, use hourly, daily, weekly or monthly' ) }
  }

  if $ensure == 'present' {
    case $type {
      'link': {
        file { "/etc/cron.${cron_schedule}/${filename}":
          ensure  => link,
          target  => "${script}",
        }
      }
      'file': { 
        file { "/etc/cron.${cron_schedule}/${filename}":
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '0644', 
          source  => "${script}",
        }
      }
      'template': { 
        $template = $script
        file { "/etc/cron.${cron_schedule}/${title}":
          ensure  => present,
          owner   => 'root',
          group   => 'root',
          mode    => '0755',
          content => template($template),
        }
      }
      default: { fail( 'CUSTOM ERROR: file type unknown, use file,link or template' ) }
    }
  }
  else {
    file { "/etc/cron.${cron_schedule}/${filename}":
      ensure  => absent,
    }
  }
}
