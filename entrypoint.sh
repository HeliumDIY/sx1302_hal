#!/bin/bash

# parse environment variables
if [[ -z "${VENDOR}" ]]; then
  echo "No VENDOR environment variable supplied, assuming vendor RAK for the reset_lgw.sh script."
  VENDOR="RAK"
else
  VENDOR="${VENDOR}"
fi

if [[ -z "${REGION}" ]]; then
  echo "No REGION environment variable supplied, assuming region US915."
  REGION="US915"
else
  REGION="${REGION}"
fi

if [[ -z "${CONCENTRATOR_MODEL}" ]]; then
  echo "No CONCENTRATOR_MODEL environment variable supplied, assuming concentrator model sx1250."
  CONCENTRATOR_MODEL="sx1250"
else
  CONCENTRATOR_MODEL="${CONCENTRATOR_MODEL}"
fi

if [[ -v "${CONCENTRATOR_INTERFACE}" ]]; then
  echo "No CONCENTRATOR_INTERFACE environment variable supplied, assuming concentrator is connected via SPI."
  CONCENTRATOR_INTERFACE=""
elif [ "${CONCENTRATOR_INTERFACE}" == "spi" ] || [ "${CONCENTRATOR_INTERFACE}" == "SPI" ]; then
  CONCENTRATOR_INTERFACE=""
elif [ "${CONCENTRATOR_INTERFACE}" == "usb" ] || [ "${CONCENTRATOR_INTERFACE}" == "USB" ]; then
  CONCENTRATOR_INTERFACE="USB"
fi
if [[ -z "${CONFIG_FILE}" ]]; then
  echo "No Config File supplied, assuming default config file for your location"
  CONFIG_FILE="/opt/packet_forwarder/configs/global_conf.json"
else
  CONFIG_FILE="${CONFIG_FILE}"
fi

# copy configuration file based on passed environment variables
if [ ! -f /opt/packet_forwarder/configs/global_conf.json ]; then
  if [ "${CONCENTRATOR_INTERFACE}" == "USB" ]; then
    cp /opt/packet_forwarder/default_configs/global_conf.json.$CONCENTRATOR_MODEL.$REGION.$CONCENTRATOR_INTERFACE /opt/packet_forwarder/configs/global_conf.json
  else
    cp /opt/packet_forwarder/default_configs/global_conf.json.$CONCENTRATOR_MODEL.$REGION /opt/packet_forwarder/configs/global_conf.json
  fi
fi

# copy concentrator reset script based on passed environment variable
if [ ! -f /opt/packet_forwarder/reset_lgw.sh ]; then
  cp /opt/packet_forwarder/tools/reset_lgw.sh.$VENDOR /opt/packet_forwarder/reset_lgw.sh
fi

# run the packet forwarder
if [[ -z "${OVERRIDE_CONFIG_FILE}" ]]; then
  echo "No Override Config File supplied, assuming default config file for your location"
  /opt/packet_forwarder/lora_pkt_fwd -c $CONFIG_FILE
else
  echo "Overriding values from Config File supplied with $OVERRIDE_CONFIG_FILE"
  /opt/packet_forwarder/lora_pkt_fwd -c $CONFIG_FILE -o $OVERRIDE_CONFIG_FILE
fi
