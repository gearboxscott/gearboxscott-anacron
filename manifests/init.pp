# Class: cron

class cron (
  $jobs = {},
  $hourly = {},
  $daily = {},
  $weekly = {},
  $monthly = {},
) {

  validate_hash($jobs)
  validate_hash($hourly)
  validate_hash($daily)
  validate_hash($weekly)
  validate_hash($monthly)

  class { 'cron::install': }

  class { 'cron::jobs': 
    cron_jobs => $jobs,
  }

  class { 'cron::hourly': 
    cron_hourly => $hourly,
  }

  class { 'cron::daily': 
    cron_daily => $daily,
  }

  class { 'cron::weekly': 
    cron_weekly => $weekly,
  }

  class { 'cron::monthly': 
    cron_monthly => $monthly,
  }

}

