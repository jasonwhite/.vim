# `~/.vim` Files

Because no Vim user should get caught without their tediously configured Vim
files under version control.

![Screenshot](/screenshot.png)

# Installing

Install fonts for [powerline][]/[airline][]:
```bash
git clone https://github.com/Lokaltog/powerline-fonts.git ~/.fonts/powerline-fonts
fc-cache -fv
```

[powerline]: https://github.com/Lokaltog/powerline
[airline]: https://github.com/bling/vim-airline

Clone the repository and install plugins:
```bash
git clone --recursive https://github.com/jasonwhite/.vim.git ~/.vim
vim +PluginInstall +qall
```
