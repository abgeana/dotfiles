# Neovim

## Linting

The repository has configuration files for [luacheck](https://github.com/mpeterv/luacheck) and
[StyLua](https://github.com/JohnnyMorganz/StyLua).

```sh
$: luarocks install --local luacheck
$: ~/.luarocks/bin/luacheck .
```

```sh
$: cargo install stylua
$: ~/.cargo/bin/stylua [ --check ] .
```
