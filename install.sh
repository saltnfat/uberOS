#!/usr/bin/env nix-shell
#! nix-shell -i bash -p stow git pciutils

source install-lib.sh

PROJECT_NAME="UberOS"
REPO_NAME=$PROJECT_NAME
current_user_name=$USER
user_name=$current_user_name

if [ -n "$(cat /etc/os-release | grep -i nixos)" ]; then
  echo "Verified this is NixOS."
  echo "-----"
else
  echo "This is not NixOS or the distribution information is not available."
  exit
fi

echo "Default options are in brackets []"
echo "Just press enter to select the default"

echo "-----"

###############################################################################

# Prompt user for type of host environment
printHeader "Host Selection for $PROJECT_NAME (NixOS) Installation"

echo "Default options are in brackets []"
echo "Just press enter to select the default"

echo "-----"

option_one="nix-deskstar (desktop)"
option_two="nix-lappy (laptop)"
option_three="nix-vm (virtual machine)"
option_four="Specify host name"
option_five="New host"
use_new_host=false

PS3='Choose install option: '
options=("$option_one" "$option_two" "$option_three" "$option_four" "$option_five" "Quit")
select opt in "${options[@]}"; do
  case $opt in
  "$option_one")
    host_name="nix-deskstar"
    break
    ;;
  "$option_two")
    host_name="nix-lappy"
    break
    ;;
  "$option_three")
    host_name="nix-vm"
    break
    ;;
  "$option_four")
    read -rp "Enter Host Name: " new_host
    host_name=$new_host
    break
    ;;
  "$option_five")
    read -rp "Enter New Host Name: " new_host
    host_name=$new_host
    use_new_host=true
    break
    ;;

  "Quit")
    exit
    ;;
  *) echo invalid option ;;
  esac
done

echo -e "${GREEN}Host is set to: $host_name${NC}"

echo "-----"

###############################################################################
# If creating a new host

printHeader "Creating a New Host"

if [ "$use_new_host" == true ]; then

  read -rp "Enter Your Username: [ $current_user_name ] " user_name_response
  if [ ! -z "$user_name_response" ]; then
    user_name=$user_name_response
  fi

  createNewHost "$host_name" "$user_name"

fi

###############################################################################
# Express install

express_install=false
if [ "$use_new_host" == false ]; then
  read -p "Do you want to do an express install [use defaults]?" -n 1 -r
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]] || [ -z "$REPLY" ]; then
    echo "express install chosen"
    express_install=true
  fi

  # if [ -z "$REPLY" ]; then
  #   express_install=true
  # fi
fi

if [ "$express_install" == false ] && [ "$use_new_host" == false ]; then

  read -p "Do you want to generate a new hardware config for the host $host_name?" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo ""
    generateHardwareConfig "$host_name"
  fi
  echo ""

  read -p "Do you want to change the user for the host $host_name?" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -rp "Enter Your Username: [ $current_user_name ] " user_name_response
    if [ ! -z "$user_name_response" ]; then
      user_name=$user_name_response
    fi

    if [ "$current_user_name" != "$user_name" ]; then
      updateUsernameForHost "$user_name" "$host_name"
    fi
  fi
fi

###############################################################################
printHeader "Building $PROJECT_NAME..., 🤞"

if [ "$user_name" != "$current_user_name" ]; then
  echo "Ensuring $PROJECT_NAME repository is in your users HOME directory."
  cd ... || exit
  cp -r $REPO_NAME /home/"$user_name"/
  sudo chown -R "$user_name":users /home/"$user_name"/$REPO_NAME
fi

echo "Using the following host name: $host_name"
if sudo nixos-rebuild switch --flake .#"$host_name" --show-trace; then
  echo "-----"
  echo "$PROJECT_NAME Has Been Installed!"
fi

###############################################################################
echo "-----"
echo "Done!"
if [ "$use_new_host" == true ]; then
  echo ""
  echo "Please configure the rest of your new host in the ./hosts/$host_name/variables.nix file!"
  echo ""
fi
