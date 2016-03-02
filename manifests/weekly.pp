class cron::weekly (
  $cron_weekly = {},
) {

  validate_hash( $cron_weekly )

  $defaults = {
    'cron_schedule' => 'weekly',
  }

  create_resources( cron::schedule, $cron_weekly, $defaults )
}
