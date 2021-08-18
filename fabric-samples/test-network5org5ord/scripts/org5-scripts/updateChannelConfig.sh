#!/bin/bash
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

# This script is designed to be run in the cli container as the
# first step of the EYFN tutorial.  It creates and submits a
# configuration transaction to add org5 to the test network
#

CHANNEL_NAME="$1"
DELAY="$2"
TIMEOUT="$3"
VERBOSE="$4"
: ${CHANNEL_NAME:="mychannel"}
: ${DELAY:="3"}
: ${TIMEOUT:="10"}
: ${VERBOSE:="false"}
COUNTER=1
MAX_RETRY=5


# imports
. scripts/envVar.sh
. scripts/configUpdate.sh
. scripts/utils.sh

infoln "Creating config transaction to add org5 to network"

# Fetch the config for the channel, writing it to config.json
fetchChannelConfig 1 ${CHANNEL_NAME} config.json

# Modify the configuration to append the new org
set -x
jq -s '.[0] * {"channel_group":{"groups":{"Application":{"groups": {"Org5MSP":.[1]}}}}}' config.json ./organizations/peerOrganizations/org5.example.com/org5.json > modified_config.json
{ set +x; } 2>/dev/null

# Compute a config update, based on the differences between config.json and modified_config.json, write it as a transaction to org5_update_in_envelope.pb
createConfigUpdate ${CHANNEL_NAME} config.json modified_config.json org5_update_in_envelope.pb

infoln "Signing config transaction"
signConfigtxAsPeerOrg 1 org5_update_in_envelope.pb
signConfigtxAsPeerOrg 2 org5_update_in_envelope.pb
signConfigtxAsPeerOrg 3 org5_update_in_envelope.pb

infoln "Submitting transaction from a different peer (peer0.org4) which also signs it"
setGlobals 4
set -x
peer channel update -f org5_update_in_envelope.pb -c ${CHANNEL_NAME} -o orderer1.example.com:7050 --ordererTLSHostnameOverride orderer1.example.com --tls --cafile "$ORDERER1_CA"
{ set +x; } 2>/dev/null

successln "Config transaction to add org5 to network submitted"
