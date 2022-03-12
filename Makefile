all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/kitty
	mkdir -p ~/.config/nvim
	mkdir -p ~/.tmux/

	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/config.fish ~/.config/fish/config.fish
	[ -f ~/.config/kitty/ayu-dark.conf ] || ln -s $(PWD)/kitty/ayu-dark.conf ~/.config/kitty/ayu-dark.conf
	[ -f ~/.config/kitty/kitty.conf ] || ln -s $(PWD)/kitty/kitty.conf ~/.config/kitty/kitty.conf
	[ -f ~/.config/nvim/coc-settings.json ] || ln -s $(PWD)/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/nvim/init.vim ~/.config/nvim/init.vim
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tmux/tmux-line.conf ] || ln -s $(PWD)/tmux/tmux-line.conf ~/.tmux/tmux-line.conf
	[ -d ~/.config/fish/functions/ ] || ln -s $(PWD)/fish/functions ~/.config/fish/functions

clean:
	rm -f ~/.config/kitty/ayu-dark.conf
	rm -f ~/.config/kitty/kitty.conf
	rm -f ~/.config/nvim/coc-settings.json
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.gitconfig
	rm -f ~/.tmux.conf
	rm -f ~/.tmux/tmux-line.conf
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/functions/

.PHONY: all clean sync
