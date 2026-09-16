restart(){
  brew update
  brew upgrade
  brew autoremove
  brew cleanup

  chezmoi update --refresh-externals
  mise cache prune

  echo "Yes" | sudo --stdin shutdown -r now
}

fkill(){
  pkill -f flutter
  pkill -f dart
  pkill -f analysis_server
  pkill -f Xcode
  pkill -f Simulator
  pkill -f CoreSimulator
}
