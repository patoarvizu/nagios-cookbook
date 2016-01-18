#!/bin/bash

if ! (vagrant plugin list | grep vagrant-s3auth); then
  vagrant plugin install vagrant-s3auth
fi

if ! (vagrant plugin list | grep vagrant-librarian-chef); then
  vagrant plugin install vagrant-librarian-chef
fi

if ! (vagrant plugin list | grep vagrant-ohai); then
  vagrant plugin install vagrant-ohai
fi

if ! (vagrant plugin list | grep landrush); then
  vagrant plugin install landrush
fi

librarian-chef config tmp /tmp --global