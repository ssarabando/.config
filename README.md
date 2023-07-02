# .config
Configuration files for neovim (Windows/pwsh)

## Requirements

### CMake

Installed with `winget`:
>    `winget install Kitware.CMake`

### CTags

Go [here](https://github.com/universal-ctags/ctags) and follow the instructions.

### fd

Installed with `winget`:
>    `winget install sharkdp.fd`

### Git

Installed with `winget`:
>    `winget install Git.Git`

### Go Programming Language

Installed with `winget`:
>    `winget install GoLang.Go`

Also, install `goimports`:
>    `go install golang.org/x/tools/cmd/goimports@latest`

### ripgrep

Go to BurntSushi's GitHub repository [here](https://github.com/BurntSushi/ripgrep#installation) and follow the instructions.

### Rustup

Go [here](https://www.rust-lang.org/tools/install) and follow the instructions.

## Notes and issues

- Run under a developer PowerShell environment so that TreeSitter can do its thing properly.
- Currently have a problem when running this for the 1st time (Neovim 0.9.1): Mason will always fail to install.
The workaround is to call `:PackerSync` after Packer finishes installing all plugins.

