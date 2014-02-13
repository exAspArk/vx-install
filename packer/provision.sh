#!/bin/bash

set -e

export RUNLEVEL=1
export DEBIAN_FRONTEND=noninteractive

cd /tmp/provision

tar -zxf upload.tgz

ansible-playbook -i inventory/production -v -c local --sudo playbooks/rackspace.yml


