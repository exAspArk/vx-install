#!/bin/bash

set -e

export RUNLEVEL=1
export DEBIAN_FRONTEND=noninteractive

#username=$1
#password=$2
#region=$3

apt-get install -qy python-pip
pip install rackspace-novaclient

#export OS_REGION_NAME=$region
#export OS_PASSWORD=$password
export OS_AUTH_URL=https://identity.api.rackspacecloud.com/v2.0/
export OS_AUTH_SYSTEM=rackspace
#export OS_USERNAME=$usernme
export OS_TENANT_NAME=none

nova credentials
