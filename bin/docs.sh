#!/bin/sh

bundle exec yard doc lib/ -r README.md -m markdown -o docs --title 'Eskimo'
