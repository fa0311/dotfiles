# dotfiles

[chezmoi](https://www.chezmoi.io/) で管理。1 マシン = `machines/<name>/` の 1 ディレクトリ。
OS や種類で分岐せず、ディレクトリ名（既定はホスト名）で source を丸ごと切り替える。

```
.chezmoi.toml.tmpl   chezmoi.toml.tmpl を読むだけ。init 時に sourceDir = machines/<name> を書き出す
chezmoi.toml.tmpl    本体。Machine 名を 1 回だけ聞く（既定 = ホスト名）
.chezmoiignore       "*"。ルートを source として apply しても何も起きないようにする
machines/<name>/     そのマシンの chezmoi source。他のマシンや OS を参照しない
shared/              素のファイル。各マシンが {{ include "../../shared/..." }} で任意に取り込む
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

`init` で `Machine` を聞かれる。既定はホスト名。`machines/<name>/` は先にコミットしておく（既存マシンのディレクトリをコピーして削るのが早い）。
`init --apply` は sourceDir が切り替わる前に apply が走るので、`apply` は別に実行する。

## 日常

```sh
chezmoi edit ~/.zshrc      # machines/<name>/dot_zshrc.tmpl を開く
chezmoi diff
chezmoi apply
chezmoi cd && git commit   # リポジトリのルートに移動する
chezmoi update             # git pull + apply
chezmoi update --refresh-externals   # oh-my-zsh も再取得
```

`chezmoi add ~/path` は今のマシンのディレクトリに入る。

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

- `.oh-my-zsh` は `.chezmoiexternal.toml` で tarball 取得。git clone ではなくなるので `omz update` は使わず `chezmoi update --refresh-externals`
- `.zshrc` の `restart` もそれに合わせて変更済み
- `Cursor/User/settings.json` は Code の settings に Cursor 固有キーを足したもの
- git は `~/.config/git/config`（自分の設定、chezmoi 管理）と `~/.gitconfig`（`git lfs install` などツールが書く。空で作るだけで以後は触らない）に分けている。`git config --global` は `~/.gitconfig` に書かれるので chezmoi と衝突しない
