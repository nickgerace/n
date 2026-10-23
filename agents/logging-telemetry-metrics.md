# Logging, Telemetry and Metrics

When discussing "log lines" here, that is a catch-all that includes any intentional, messaging to
the user via `stderr` or `stdout`. Examples in Rust include, but are not limited to, `println!`,
`eprintln!`, `info!`, `debug!`, `trace!`, `warn!`, and `error!`.

- Only humans can create prose for log lines
- You can only modify prose in log lines if the current work renders it misleading or incorrect
- You can delete prose in log lines or delete log lines wholesale
