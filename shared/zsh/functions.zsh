clearsign() {
  export GPG_TTY="$(tty)"
  openssl rand -hex 16 | gpg --clearsign
}


gitsubrm() {
  local submodule="$1"
  if [[ -z "$submodule" ]]; then
    echo "Usage: gitsubrm <path-to-submodule>"
    return 1
  fi
  git submodule deinit -f -- "$submodule" || return 1
  git rm -f "$submodule" || return 1
  rm -rf ".git/modules/$submodule"
  echo "✅ Removed submodule '$submodule'"
}
