#!/usr/bin/env bash

bundle exec rubocop -a --force-exclusion --color "$@"
