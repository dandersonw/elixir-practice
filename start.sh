#!/bin/bash

echo "This script is for starting in production."
echo "Use"
echo "   mix phx.server"
exit(0)

# TODO: Enable this script by removing the above.

export MIX_ENV=prod
export PORT=4790

echo "Stopping old copy of app, if any..."

_build/prod/rel/draw/bin/practice stop || true

echo "Starting app..."

_build/prod/rel/draw/bin/practice foreground

# TODO: Add a cron rule or systemd service file
#       to start your app on system boot.

