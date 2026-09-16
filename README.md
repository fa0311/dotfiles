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
