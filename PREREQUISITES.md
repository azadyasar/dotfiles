# Neovim Setup Prerequisites

Everything required for this config to run without errors on a fresh machine (macOS).

## 1. Core

```sh
# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Neovim itself
brew install neovim

# Xcode Command Line Tools — required for Treesitter to compile parsers
xcode-select --install
```

## 2. Plugin manager (vim-plug)

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

After installing, open nvim and run:
```
:PlugInstall
:TSUpdate
```

## 3. Command-line tools used by plugins

| Tool | Why | Install |
|------|-----|---------|
| `git` | `:GFiles`, plugin updates | `brew install git` |
| `fzf` | `:Files`, `:GFiles`, `:Buffers`, `:RG` | `brew install fzf` |
| `ripgrep` | `:RG` live grep (`,f`) | `brew install ripgrep` |
| `node` | Many LSP servers (tsserver, etc.) | `brew install node` |

## 4. Fonts

A Nerd Font is required for `vim-devicons` and `vim-airline` symbols to render.

```sh
brew install --cask font-hack-nerd-font
```

Then set your terminal (iTerm2 / Ghostty / Terminal.app) font to **Hack Nerd Font**.

## 5. LSP servers

`lsp_config.lua` wires up these servers — install the ones you use:

| Language | Server | Install |
|----------|--------|---------|
| Go | `gopls` | `brew install gopls` (or `go install golang.org/x/tools/gopls@latest`) |
| Terraform | `terraform-ls` | `brew install hashicorp/tap/terraform-ls` |

If you uncomment additional servers in `lsp_config.lua`, add them here:

| Language | Server | Install |
|----------|--------|---------|
| TypeScript/JS | `typescript-language-server` | `npm i -g typescript typescript-language-server` |
| Python | `pyright` | `npm i -g pyright` |
| Lua | `lua-language-server` | `brew install lua-language-server` |
| Rust | `rust-analyzer` | `brew install rust-analyzer` |

## 6. Verification

After all steps, from inside this config:

```
nvim +checkhealth
```

Everything under `provider.node`, `lsp`, `treesitter`, and `nvim` should report OK (or only "deprecation" warnings you accept).

Quick smoke test:
- `,ff` → fuzzy file finder opens
- `,f` → live grep works (type and see results)
- `,e` → NERDTree toggles
- Open a `.go` file → syntax colors + LSP diagnostics appear

## 7. Optional

- `tree-sitter-cli` — lets you preview/debug parsers (`brew install tree-sitter`)
- `lazygit` — popular git UI, pairs well with nvim (`brew install lazygit`)
