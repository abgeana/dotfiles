# neomutt

## Opening .eml files

`.eml` files must be converted to `.mbox` format first. Use `formail` for this:

```sh
formail -b < file.eml > file.mbox
```

which mostly adds a few extra headers. Then use `neomutt -f file.mbox`.
