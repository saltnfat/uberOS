#!/bin/bash

XDG_CONFIG_HOME=~/.config
PROJECT_DIR=~/uberOS
LOCAL_DIR=~/.local
THEME_FILES=(
  # dots/config/alacritty/rice-colors.toml
  # dots/config/bspwm/.rice
  # dots/config/bspwm/dunstrc
  # dots/config/bspwm/jgmenurc
  # dots/config/bspwm/picom.conf
  # dots/config/bspwm/scripts/Launcher.rasi
  # dots/config/bspwm/scripts/NetManagerDM.rasi
  # dots/config/bspwm/scripts/system.ini
  # dots/config/bspwm/scripts/WallSelect.rasi
  # dots/config/eww/colors.scss
  # dots/config/mpd/state
)

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

printHeader() {
  echo ""
  echo -e "${YELLOW}╔═══════════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${YELLOW}║ ${1} ${NC}"
  echo -e "${YELLOW}╚═══════════════════════════════════════════════════════════════════════╝${NC}"
}

gpuProfileDetection() {
  local host_name=$1

  printHeader "GPU Profile Detection"

  # Attempt automatic detection
  DETECTED_PROFILE=""

  has_nvidia=false
  has_intel=false
  has_amd=false
  has_vm=false

  if lspci | grep -qi 'vga\|3d\|display'; then
    while read -r line; do
      if echo "$line" | grep -qi 'nvidia'; then
        has_nvidia=true
      elif echo "$line" | grep -qi 'amd\|ati\|advanced micro devices'; then
        has_amd=true
      elif echo "$line" | grep -qi 'intel'; then
        has_intel=true
      elif echo "$line" | grep -qi 'virtio\|vmware'; then
        has_vm=true
      fi
    done < <(lspci | grep -i 'vga\|3d\|display')

    if $has_vm; then
      DETECTED_PROFILE="vm"
    elif $has_nvidia && $has_amd; then
      DETECTED_PROFILE="amd-nvidia-hybrid"
    elif $has_nvidia && $has_intel; then
      DETECTED_PROFILE="nvidia-laptop"
    elif $has_nvidia; then
      DETECTED_PROFILE="nvidia"
    elif $has_amd; then
      DETECTED_PROFILE="amd"
    elif $has_intel; then
      DETECTED_PROFILE="intel"
    fi
  fi

  # Handle detected profile or fall back to manual input
  if [ -n "$DETECTED_PROFILE" ]; then
    profile="$DETECTED_PROFILE"
    echo -e "${GREEN}Detected GPU profile: $profile${NC}"
    read -p "Correct? (Y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo -e "${RED}GPU profile not confirmed. Falling back to manual selection.${NC}"
      profile="" # Clear profile to force manual input
    fi
  fi

  # If profile is still empty (either not detected or not confirmed), prompt manually
  if [ -z "$profile" ]; then
    echo -e "${RED}Automatic GPU detection failed or no specific profile found.${NC}"
    read -rp "Enter Your Hardware Profile (GPU)
  Options:
  [ amd ]
  amd-nvidia-hybrid
  intel
  nvidia
  nvidia-laptop
  vm
  Please type out your choice: " profile
    if [ -z "$profile" ]; then
      profile="amd"
    fi
    echo -e "${GREEN}Selected GPU profile: $profile${NC}"
  fi

  sed -i "/^\s*gpuProfile[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$profile\"/" ./hosts/"$host_name"/variables.nix
}

updateHostsInFlake() {
  local host_name=$1
  awk -v h="$host_name" '
  BEGIN { in_hosts=0; seen=0 }
  /^\s*hosts\s*=\s*\[/ { in_hosts=1 }
  in_hosts && /"[^"]+"/ {
    if (index($0, "\"" h "\"") > 0) seen=1
  }
  in_hosts && /\];/ {
    if (!seen) print "      \"" h "\""
    in_hosts=0
  }
  { print }
' ./flake.nix >./flake.nix.tmp && mv ./flake.nix.tmp ./flake.nix
}

updateUsernameForHost() {
  local user_name=$1
  local host_name=$2

  sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$user_name\"/" ./hosts/"$host_name"/variables.nix
  sed -i -E "s|^[[:space:]]*username[[:space:]]*=[[:space:]]*\"[^\"]*\";|    username = \"${user_name}\";|" ./flake.nix
}

createNewHost() {
  local host_name=$1
  local user_name=$2

  mkdir -p ./hosts/"$host_name"
  cp -R ./hosts/nix-vm/* ./hosts/"$host_name"/

  sed -i "/^\s*hostname[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$host_name\"/" ./hosts/"$host_name"/variables.nix
  updateUsernameForHost "$user_name" "$host_name"

  generateHardwareConfig "$host_name"

  updateHostsInFlake "$host_name"
  gpuProfileDetection "$host_name"

  git add ./hosts/"$host_name"/
}

generateHardwareConfig() {
  local host_name=$1
  printHeader "Generating hardware config for host: $host_name"
  echo ""
  sudo nixos-generate-config --show-hardware-config >./hosts/"$host_name"/hardware.nix
}

setUserPassword() {
  echo "This will create a hashedPassword for the new user in the options file."
  while true; do
    echo
    read -rp "Enter New User Password: " new_pass
    echo
    read -rp "Enter New User Password Again: " new_pass2
    if [ "$new_pass" == "$new_pass2" ]; then
      echo "Passwords Match. Setting password."
      user_password=$(mkpasswd -m sha-512 "$new_pass")
      escaped_user_password=$(echo "$user_password" | sed 's/\//\\\//g')
      sed -i "/^\s*hashedPassword[[:space:]]*=[[:space:]]*\"/s#\"\(.*\)\"#\"$escaped_user_password\"#" ./modules/core/user.nix
      break
    fi
  done
}

# symlinkDots() {
#   [ ! -d ~/.config ] && mkdir -p $XDG_CONFIG_HOME
#   [ ! -d ~/.local/bin ] && mkdir -p ~/.local/bin
#   [ ! -d ~/.local/share ] && mkdir -p ~/.local/share
#
#   cd $PROJECT_DIR/dots && stow -R config -t ~/.config/ -v
#   cd $PROJECT_DIR/dots && stow -R local -t ~/.local/ -v
#   cd $PROJECT_DIR || exit
# }

# Non intrusive way of adding custom styling to kitty conf without overwriting
# existing conf
# addGlobalIncludesToKittyConf() {
#
#   if [ ! -d $XDG_CONFIG_HOME/kitty ]; then
#     mkdir -p $XDG_CONFIG_HOME/kitty
#   fi
#   if [ ! -f $XDG_CONFIG_HOME/kitty/kitty.conf ]; then
#     touch $XDG_CONFIG_HOME/kitty/kitty.conf
#   fi
#   if ! grep -Fxq "globinclude kitty.d/**/*.conf" $XDG_CONFIG_HOME/kitty/kitty.conf; then
#     bash -c "echo globinclude kitty.d/**/*.conf >> $XDG_CONFIG_HOME/kitty/kitty.conf"
#   fi
# }
