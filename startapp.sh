#!/bin/sh
ls -la
pwd
export APP_NAME="OpenLens"
ls -lah /opt/lens
chmod +x /opt/lens/open-lens
exec /opt/lens/open-lens --no-sandbox