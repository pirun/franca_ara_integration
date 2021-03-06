#!/bin/sh -x

export VSOMEIP_CONFIGURATION="$(readlink -f /usr/local/share/franca-ara/conf/vsomeip_ecu1.json)"
export VSOMEIP_CLIENTSIDELOGGING=true

[ -z "$VSOMEIP_CONFIGURATION" ] && { echo "ERROR: Did not find VSOMEIP_CONFIGURATION file as expected!" ; exit 1 ; }

# Run vsomeipd if it's not in process list already
ps aux | grep -q [v]someipd 
if [ $? -eq 0 ] ; then
  echo 
  echo VSOMEIPD ALREADY RUNNING -- SKIPPED
  echo
else
  echo -------------------------------
  echo STARTING VSOMEIPD
  echo -------------------------------
  vsomeipd &
fi

  echo -------------------------------
  echo STARTING CAPI_CLIENT_GDP
  echo -------------------------------

cd "$(dirname "$0")"
./capi_client_gdp

