#!/usr/bin/env bash

ROOTDIR='/opt/puppetlabs/storage'

mkdir -p $ROOTDIR/var/run
mkdir -p $ROOTDIR/var/log

chown -R puppet:puppet $ROOTDIR/var

if [ ! -d $ROOTDIR/code/manifests ]; then
  mkdir -p $ROOTDIR/code
  cp -rp /etc/puppetlabs/code/* $ROOTDIR/code/
fi
