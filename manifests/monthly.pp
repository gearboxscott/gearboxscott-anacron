class cron::monthly (
  $cron_monthly = {},
) {

  validate_hash( $cron_monthly )
  
  $defaults = {
    'cron_schedule' => 'monthly',
  }

  create_resources( cron::schedule, $cron_monthly, $defaults )
}
