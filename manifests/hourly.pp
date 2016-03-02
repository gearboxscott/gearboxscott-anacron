class anacron::hourly (
  $anacron_hourly = {},
) {

  validate_hash( $anacron_hourly )

  $defaults = {
    'anacron_schedule' => 'hourly',
  }

  create_resources( anacron::schedule, $anacron_hourly, $defaults )
}
