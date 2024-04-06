#!/usr/bin/env bash

bundle exec rubocop -A --force-exclusion --color "$@"
