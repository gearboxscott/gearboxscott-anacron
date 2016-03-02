define cron::job (
  $filename = $title,
  $ensure = 'present',
  $command = '',
  $user = 'root', 
  $date = '*', 
  $weekday = '*',
  $hour = '*', 
  $month = '*', 
  $minute = '*', 
  $environment = [],
) {
  include stdlib
  if $ensure == 'absent' {
    file { $filename:
      ensure  => 'absent',
      path    => "/etc/cron.d/${filename}",
    }
  }
  else {
    file { $filename:
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      path    => "/etc/cron.d/${filename}",
      content => template( 'cron/job.erb' );
    }
  }
}
