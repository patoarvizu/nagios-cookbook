#!/bin/bash

librarian-chef config tmp /tmp --global
librarian-chef update nagios
vagrant provision chef --provision-with update

for arg in "$@"; do
	vagrant provision $arg
done
