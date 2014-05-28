#!/bin/bash

set -e
set -x

export RUNLEVEL=1
export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -qy python-pip
pip install rackspace-novaclient

cat >/usr/sbin/os_shutdown <<EOF
#!/bin/bash

set -e
set -x

export OS_REGION_NAME=$OS_REGION_NANE
export OS_USERNAME=$OS_USERNAME
export OS_TENANT_NAME=none
export OS_AUTH_SYSTEM=rackspace
export OS_PASSWORD=$OS_PASSWORD

export OS_AUTH_URL=https://identity.api.rackspacecloud.com/v2.0/

nova credentials

iid=\$(xenstore-read name | sed -e 's/instance\-//')

nova delete \$iid
EOF

chmod +x /usr/sbin/os_shutdown
