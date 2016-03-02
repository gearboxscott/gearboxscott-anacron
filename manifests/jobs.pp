class anacron::jobs (
  $anacron_jobs = {},
) {
  validate_hash( $anacron_jobs )

  create_resources( anacron::job, $anacron_jobs )
}
