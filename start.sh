#!/bin/bash

export MIX_ENV=prod
export PORT=4790
H=/home/phoenix/elixir-practice

echo "Stopping old copy of app, if any..."

"$H/_build/prod/rel/practice/bin/practice" stop || true

echo "Starting app..."

"$H/_build/prod/rel/practice/bin/practice" start

