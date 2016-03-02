class cron::daily (
  $cron_daily = {},
) {

  validate_hash( $cron_daily )

  $defaults = {
    'cron_schedule' => 'daily',
  }

  create_resources( cron::schedule, $cron_daily, $defaults )
}

