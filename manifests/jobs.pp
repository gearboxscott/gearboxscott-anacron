class cron::jobs (
  $cron_jobs = {},
) {
  validate_hash( $cron_jobs )

  create_resources( cron::job, $cron_jobs )
}
