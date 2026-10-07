# dotfiles

## 新しいマシン

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init fa0311 --promptDefaults
chezmoi apply
```

```sh
winget install twpayne.chezmoi; chezmoi init fa0311 --promptDefaults
chezmoi apply
```

## 既存のチェックアウトを使う

このリポジトリのルートで実行すると、編集した宣言をそのまま適用できます。

```sh
chezmoi init --source="$PWD" --promptDefaults
chezmoi apply
```

Dockには導入済みのアプリだけを追加します。WireGuard・Transporter・Xcodeを
後から導入した場合は、`bash shared/scripts/macos/dock.sh` で再構成できます。

## 鍵

```sh
shared/scripts/credentials/export.sh
shared/scripts/credentials/import.sh
```

## 日常

```sh
chezmoi edit ~/.zshrc
chezmoi diff
chezmoi apply
chezmoi update --refresh-externals
```
