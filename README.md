# `~/.vim` Files

Because no Vim user should get caught without their tediously configured Vim
files under version control.

[Vundle][] is used to manage plugins. See `vimrc` for which plugins are used.

[Vundle]: https://github.com/gmarik/Vundle.vim#about

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
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
vim +PluginInstall +qall
```
