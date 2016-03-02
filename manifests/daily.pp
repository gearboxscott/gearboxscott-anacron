class anacron::daily (
  $anacron_daily = {},
) {

  validate_hash( $anacron_daily )

  $defaults = {
    'anacron_schedule' => 'daily',
  }

  create_resources( anacron::schedule, $anacron_daily, $defaults )
}

