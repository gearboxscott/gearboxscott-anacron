class anacron::weekly (
  $anacron_weekly = {},
) {

  validate_hash( $anacron_weekly )

  $defaults = {
    'anacron_schedule' => 'weekly',
  }

  create_resources( anacron::schedule, $anacron_weekly, $defaults )
}
