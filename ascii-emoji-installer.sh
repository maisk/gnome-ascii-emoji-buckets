set -e

print-help() {
  echo -e "\
Installer for the [gnome-ascii-emoji-buckets](https://github.com/HarshKhandeparkar/gnome-ascii-emoji-buckets)
project.
Options:
  -l/--latest => Downloads and installs the latest version/Upgrades to the latest version.
  -u/--uninstall => Uninstall the extension.\
"
}

check-curl() {
  if [[ $(which curl) == "" ]];
  then
    echo "curl not found."

    if [[ $(which apt) != "" ]];
    then
      echo "Found apt, instaling curl."
      sudo apt install curl
    else
      echo "Install curl manually using the default package manager to use this script."
      exit 1
    fi
  fi
}

install-latest() {
  check-curl

  if [[ -d $HOME/.local/share/gnome-shell/extensions/ascii_emoji_buckets@HarshKhandeparkar ]];
  then
    echo "Uninstalling old version"
    rm -r $HOME/.local/share/gnome-shell/extensions/ascii_emoji_buckets@HarshKhandeparkar
  fi

  temp_dir=$(mktemp -d)
  echo "Downloading latest version"
  pushd $temp_dir > /dev/null

  wget $(curl -s https://api.github.com/repos/HarshKhandeparkar/gnome-ascii-emoji-buckets/releases/latest | grep "browser_download_url.*zip" | cut -d : -f 2,3 | tr -d \") &> /dev/null
  echo "Latest version downloaded. Installing"

  mkdir -p $HOME/.local/share/gnome-shell/extensions/ascii_emoji_buckets@HarshKhandeparkar
  unzip *.zip -d $HOME/.local/share/gnome-shell/extensions/ascii_emoji_buckets@HarshKhandeparkar > /dev/null

  echo "Latest version installed. Reload the gnome shell manually if it didn't update already."
  rm -r $temp_dir
}

uninstall() {
  if [[ -d $HOME/.local/share/gnome-shell/extensions/ascii_emoji_buckets@HarshKhandeparkar ]];
  then
    echo "Uninstalling the extension."
    rm -r $HOME/.local/share/gnome-shell/extensions/ascii_emoji_buckets@HarshKhandeparkar
    echo "Uninstalled"
  else
    echo "Extension is not installed."
  fi
}

if [[ $1 != "" ]];
then
  case $1 in
    "-h"|"--help")
      print-help
      ;;
    "-l"|"--latest")
      install-latest
      ;;
    "-u"|"--uninstall")
      uninstall
      ;;
  esac
else
  print-help
fi