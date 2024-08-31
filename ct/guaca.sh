#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
   ______                                      __ 
  / ____/_  __ ____  ___  ____ ___ __   ___   /  /__
 / / __/ / / / __  / ___/ __  / __'__ \/ __ \/  / _ \
/ /_/ / /_/ / /_/ / /__  /_/ / / // / / /_/ /  /  __/
\____/\__,_/\__,_/\___/\__,_/_/ //_/ /\___ /__/\__/

EOF
}
header_info
echo -e "Loading..."
APP="Guacamole"
var_disk="2"
var_cpu="1"
var_ram="512"
var_os="ubuntu"
var_version="2204"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /etc/guacamole ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated ${APP} LXC"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}http://${IP}/8080/guacamole${CL} \n"