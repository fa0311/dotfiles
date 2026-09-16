# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理。1 マシン = `machines/<name>/` の 1 ディレクトリ。
OS や種類で分岐せず、ディレクトリ名（既定はホスト名）で source を丸ごと切り替える。

```
.chezmoi.toml.tmpl   chezmoi.toml.tmpl を読むだけ。init 時に sourceDir = machines/<name> を書き出す
chezmoi.toml.tmpl    本体。Machine 名を 1 回だけ聞く（既定 = ホスト名）
.chezmoiignore       "*"。ルートを source として apply しても何も起きないようにする
shared/              設定の中身。関心ごとに 1 ファイル。テンプレート構文は原則なし
machines/<name>/     そのマシンの chezmoi source。shared を include で並べるだけ
```

machines に生の内容を書くのは、そのマシン固有の値を含むものだけ（LinearMouse のデバイスシリアル、colima の Include 行）。
include の並び順と採否がマシンの構成そのもの。shared にはマシンや OS の分岐を書かない。

## shared

```
chezmoi/externals.toml     oh-my-zsh 本体と autosuggestions / syntax-highlighting の tarball 取得
zsh/omz.zsh                oh-my-zsh の読み込み（テーマ、plugins）
zsh/history.zsh            HISTSIZE と setopt
zsh/mise.zsh               mise activate
zsh/aliases.zsh
zsh/functions.zsh          clearsign, gitsubrm
zsh/macos.zsh              restart, fkill
zsh/zprofile-macos.zsh     brew shellenv, Android platform-tools, pub-cache, mise shims
git/identity               user.*, commit.gpgsign
git/credential             huggingface
git/gpg-homebrew           gpg.program = /opt/homebrew/bin/gpg
git/ignore                 グローバル gitignore
ssh/github                 github.com を ssh.github.com:443 に
ssh/lan                    192.168.70.1-5
gnupg/gpg-agent-macos.conf pinentry-mac
gnupg/common.conf          use-keyboxd
brew/cli                   tap と formula
brew/gui                   cask
karabiner/karabiner.json
vscode/settings.json       Code と Cursor で同一
vscode/keybindings.json
vscode/extensions.tsv      Code と Cursor で同一。profile<TAB>拡張ID
scripts/macos/homebrew.sh          Homebrew 公式インストーラ
scripts/macos/brew-bundle.sh.tmpl  brew bundle。Brewfile のレンダリング結果の hash で再実行
scripts/macos/defaults.sh          defaults write
scripts/macos/dock.sh              dockutil で Dock の並びを作り直す
scripts/macos/vscode-extensions.sh.tmpl  tsv を読んで code --profile <name> --install-extension
scripts/macos/tools.sh             git lfs install
```

## 新しいマシン

```sh
# macOS / Linux
sh -c "$(curl -fsLS get.chezmoi.io)" -- init fa0311
chezmoi apply
```

```powershell
# Windows
winget install twpayne.chezmoi
chezmoi init fa0311
chezmoi apply
```

`init` で `Machine` を聞かれる。既定はホスト名。`machines/<name>/` は先にコミットしておく（既存マシンのディレクトリをコピーして include を削るのが早い）。
`init --apply` は sourceDir が切り替わる前に apply が走るので、`apply` は別に実行する。

## 日常

```sh
chezmoi edit ~/.zshrc      # machines/<name>/dot_zshrc.tmpl を開く。中身は shared/zsh/*.zsh
chezmoi diff
chezmoi apply
chezmoi cd && git commit   # リポジトリのルートに移動する
chezmoi update             # git pull + apply
chezmoi update --refresh-externals   # oh-my-zsh も再取得
```

`chezmoi add ~/path` は今のマシンのディレクトリに入る。shared に置くなら手で移して include に置き換える。
Karabiner や LinearMouse のようにアプリ自身が設定を書き直すものは、変更後に `chezmoi re-add`。

## 手動で移す物

- `~/.ssh/id_ed25519`
- GPG 秘密鍵: `gpg --export-secret-keys 83A8A5E74872A8AA > key.asc` → `gpg --import key.asc`
- `~/.npmrc`（GitHub Packages のトークン。`npm login --registry=https://npm.pkg.github.com`）
- `gh auth login`
- Consolas フォント（`~/Library/Fonts/CONSOLA*.TTF`）
- App Store: WireGuard, Transporter
- MouseAssistant
- Xcode: `xcodes install`
- Claude Code: `curl -fsSL https://claude.ai/install.sh | bash`

## AMAGC6WCYW2L9

会社支給 MacBook。`Company Portal` 経由のアプリ（Defender, Office, Teams, OneDrive, AWS VPN Client）は Brewfile に書かない。

- `.oh-my-zsh` は tarball 取得。git clone ではなくなるので `omz update` は使わず `chezmoi update --refresh-externals`
- VS Code は Settings Sync を使わない（`Manage` → `Settings Sync is On` → `Turn Off`、クラウド側も削除）。profile は tsv から `code --profile` で作られる。ワークスペースと profile の紐付けは復元されないので開き直して選ぶ
- 拡張一覧の更新: `code --profile <name> --list-extensions` を profile ごとに実行して `shared/vscode/extensions.tsv` を書き直す
- git は `~/.config/git/config`（chezmoi 管理）と `~/.gitconfig`（`git lfs install` などツールが書く。空で作るだけで以後は触らない）に分けている。`git config --global` は `~/.gitconfig` に書かれるので chezmoi と衝突しない
