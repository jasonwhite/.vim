# `~/.vim` Files

Because no Vim user should get caught without their tediously configured Vim
files under version control.

See the `bundle/` directory for which plugins are included.

# Installing

Clone the repository:

	$ git clone --recursive https://github.com/jasonwhite/.vim.git ~/.vim
	$ ln -s ~/.vim/vimrc ~/.vimrc
	$ ln -s ~/.vim/gvimrc ~/.gvimrc

Install fonts for [powerline][]/[airline][]:

    $ git clone https://github.com/Lokaltog/powerline-fonts.git ~/.fonts/powerline-fonts
    $ fc-cache -fv

[powerline]: https://github.com/Lokaltog/powerline
[airline]: https://github.com/bling/vim-airline
