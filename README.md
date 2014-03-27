# `~/.vim` Files

Because no Vim user should get caught without their tediously configured Vim
files under version control.

# Installing

## Unix

	git clone https://github.com/jasonwhite/.vim ~/.vim
	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gvimrc ~/.gvimrc

## Windows

	cd %USERPROFILE%
	git clone https://github.com/jasonwhite/.vim vimfiles
	mklink /H _vimrc "vimfiles/vimrc"
	mklink /H _gvimrc "vimfiles/gvimrc"
