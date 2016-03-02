class anacron::monthly (
  $anacron_monthly = {},
) {

  validate_hash( $anacron_monthly )
  
  $defaults = {
    'anacron_schedule' => 'monthly',
  }

  create_resources( anacron::schedule, $anacron_monthly, $defaults )
}
