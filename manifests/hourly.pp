class cron::hourly (
  $cron_hourly = {},
) {

  validate_hash( $cron_hourly )

  $defaults = {
    'cron_schedule' => 'hourly',
  }

  create_resources( cron::schedule, $cron_hourly, $defaults )
}
