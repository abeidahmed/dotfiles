# Personal Dotfiles

Feel free to borrow whatever you like.

## Installation

First, you need to install the `stow` package.

```bash
sudo apt install stow
```

After installing, clone this repo and `cd` into it. Execute `./install.sh` after that.

```bash
./install.sh              # stow every package
./install.sh vim tmux     # stow only the named packages
./clean.sh                # unstow everything again
```

A package whose target already exists in `$HOME` as a real file is reported and
skipped; move that file aside and re-run.

## License

[MIT License](https://opensource.org/licenses/MIT)
