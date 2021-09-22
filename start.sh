#!/usr/bin/env bash

set -euxo pipefail

cat >/usr/src/app/gitiles.config <<EOF
[gitiles]
basePath = $BASE_GIT_PATH
exportAll = true

canonicalHostName = $CANONICAL_HOST_NAME
baseGitUrl = $BASE_GIT_URL
siteTitle  = $SITE_TITLE
EOF

exec /usr/src/app/bazel-bin/java/com/google/gitiles/dev/dev \
  --jvm_flag=-Dcom.google.gitiles.sourcePath=/usr/src/app \
  --jvm_flag=-Dcom.google.gitiles.configPath=/usr/src/app/gitiles.config
