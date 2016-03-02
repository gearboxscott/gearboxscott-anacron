# Class: anacron

class anacron (
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

  class { 'anacron::install': }

  class { 'anacron::jobs': 
    anacron_jobs => $jobs,
  }

  class { 'anacron::hourly': 
    anacron_hourly => $hourly,
  }

  class { 'anacron::daily': 
    anacron_daily => $daily,
  }

  class { 'anacron::weekly': 
    anacron_weekly => $weekly,
  }

  class { 'anacron::monthly': 
    anacron_monthly => $monthly,
  }

}

