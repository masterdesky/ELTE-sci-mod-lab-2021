#!/bin/bash

# Parses variables.yml and saves output as variables.sh
sed -E -e 's/:[^:\/\/]/="/g; /(^#|((\r\n|\n|\r)$)|(^(\r\n|\n|\r))|^\s*$)/ ! s/$/"/g; /(^#|^$)/ ! s/^/export /g; s/ *=/=/g;' \
					${SCRIPTDIR}/variables.yml > ${SCRIPTDIR}/variables.sh
chmod +x ${SCRIPTDIR}/variables.sh
source ${SCRIPTDIR}/variables.sh