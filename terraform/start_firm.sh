#!/bin/bash
set -e


kubectl exec isv -- bash -c 'cd /root/Humane-RAFW-MAA/subtools/mr-extract && make && ./mr-extract' > mr.info

MAA_URL=$(terraform output -raw attestation_uri)
MRENCLAVE=$(cat mr.info | grep MRENCLAVE | tail -c 65)
MRSIGNER=$(cat mr.info | grep MRSIGNER | tail -c 65)

rm mr.info


kubectl exec isv -- bash -c """
cd /root/Humane-RAFW-MAA
cp settings_client_template.ini settings_client.ini

sed -i 's#MAA_URL = #MAA_URL = ${MAA_URL}#g' settings_client.ini
sed -i 's/REQUIRED_MRENCLAVE =/REQUIRED_MRENCLAVE = ${MRENCLAVE}/g' settings_client.ini
sed -i 's/REQUIRED_MRSIGNER =/REQUIRED_MRSIGNER = ${MRSIGNER}/g' settings_client.ini
"""

kubectl exec isv -- bash -c 'cd /root/Humane-RAFW-MAA && ./client_app'