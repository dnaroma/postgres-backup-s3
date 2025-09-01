# Changes Summary

## Implemented Changes

### 1. Remove cron support
- **install.sh**: Removed go-cron installation logic
- **run.sh**: Removed SCHEDULE-related conditional logic, now runs backup directly
- **Dockerfile**: Removed SCHEDULE environment variable
- **docker-compose.yaml**: Removed SCHEDULE configuration example
- **README.md**: Updated documentation, removed cron scheduling related instructions

### 2. Add pg_dump rate limiting functionality
- **install.sh**: Added installation of pv (pipe viewer) tool
- **backup.sh**: 
  - Added rate limiting logic using pv tool to limit pg_dump output speed
  - Rate limiting is applied when PGDUMP_RATE_LIMIT environment variable is set
  - Rate limiting unit is KB/s
- **Dockerfile**: Added PGDUMP_RATE_LIMIT environment variable
- **docker-compose.yaml**: Added rate limiting configuration example (1024 KB/s)
- **README.md**: Added rate limiting functionality documentation
- **env.sh**: Added default value handling for PGDUMP_RATE_LIMIT

## Usage

### Basic usage (no rate limiting)
The container will execute a backup immediately upon startup and then exit.

### Using rate limiting functionality
Set the `PGDUMP_RATE_LIMIT` environment variable to limit backup speed:

```yaml
environment:
  PGDUMP_RATE_LIMIT: 1024  # Limit to 1024 KB/s
```

### Complete removal of cron support
- No longer supports SCHEDULE environment variable
- Container is now designed to run one backup and then exit
- For periodic backups, use external schedulers (such as Kubernetes CronJob, system cron, etc.)

## Technical Implementation Details

### Rate limiting implementation
Rate limiting is implemented using the `pv` tool:
```bash
pg_dump ... | pv -L "${PGDUMP_RATE_LIMIT}k" > db.dump
```

### Architecture changes
- Changed from scheduled execution mode to one-time execution mode
- Simplified container startup logic
- Reduced dependencies (removed go-cron)
- Added data transfer control functionality
