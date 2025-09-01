ARG ALPINE_VERSION=3.22.1
FROM alpine:${ALPINE_VERSION}
ARG TARGETARCH
ARG TARGETPOSTGRES

ADD src/install.sh install.sh
RUN sh install.sh && rm install.sh

ENV POSTGRES_DATABASE=''
ENV POSTGRES_HOST=''
ENV POSTGRES_PORT=5432
ENV POSTGRES_USER=''
# Note: POSTGRES_PASSWORD should be provided at runtime for security
ENV PGDUMP_EXTRA_OPTS=''
ENV PGDUMP_RATE_LIMIT=''
# Note: S3_ACCESS_KEY_ID should be provided at runtime for security
# Note: S3_SECRET_ACCESS_KEY should be provided at runtime for security
ENV S3_BUCKET=''
ENV S3_REGION='us-west-1'
ENV S3_PATH='backup'
ENV S3_ENDPOINT=''
ENV S3_S3V4='no'
ENV PASSPHRASE=''
ENV BACKUP_KEEP_DAYS=''

ADD src/run.sh run.sh
ADD src/env.sh env.sh
ADD src/backup.sh backup.sh
ADD src/restore.sh restore.sh

CMD ["sh", "run.sh"]
