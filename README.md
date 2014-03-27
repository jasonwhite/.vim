# `~/.vim` Files

Because no Vim user should get caught without their tediously configured Vim
files under version control.

# Installing

Clone the repository:

	$ git clone https://github.com/jasonwhite/.vim ~/.vim
	$ ln -s ~/.vim/vimrc ~/.vimrc
	$ ln -s ~/.vim/gvimrc ~/.gvimrc

Download the plugins:

    $ git submodule init --recursive
    $ git submodule update --recursive

Install fonts for [powerline][]/[airline][]:

    $ git clone https://github.com/Lokaltog/powerline-fonts.git ~/.fonts/powerline-fonts
    $ fc-cache -fv

[powerline]: https://github.com/Lokaltog/powerline
[airline]: https://github.com/bling/vim-airline
