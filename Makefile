all: sync

sync:
	mkdir -p ~/.config/fish
	mkdir -p ~/.config/kitty
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/nvim/lua
	mkdir -p ~/.tmux/

	[ -f ~/.config/fish/config.fish ] || ln -s $(PWD)/fish/config.fish ~/.config/fish/config.fish
	[ -f ~/.config/fish/fish_plugins ] || ln -s $(PWD)/fish/fish_plugins ~/.config/fish/fish_plugins
	[ -f ~/.config/kitty/ayu-dark.conf ] || ln -s $(PWD)/kitty/ayu-dark.conf ~/.config/kitty/ayu-dark.conf
	[ -f ~/.config/kitty/kitty.conf ] || ln -s $(PWD)/kitty/kitty.conf ~/.config/kitty/kitty.conf
	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/nvim/init.vim ~/.config/nvim/init.vim
	[ -f ~/.config/nvim/lua/buffline.lua ] || ln -s $(PWD)/nvim/buffline.lua ~/.config/nvim/lua/buffline.lua
	[ -f ~/.config/nvim/lua/config.lua ] || ln -s $(PWD)/nvim/config.lua ~/.config/nvim/lua/config.lua
	[ -f ~/.config/nvim/lua/dashboard.lua ] || ln -s $(PWD)/nvim/dashboard.lua ~/.config/nvim/lua/dashboard.lua
	[ -f ~/.config/nvim/lua/plugins.lua ] || ln -s $(PWD)/nvim/plugins.lua ~/.config/nvim/lua/plugins.lua
	[ -f ~/.config/nvim/lua/statusline.lua ] || ln -s $(PWD)/nvim/statusline.lua ~/.config/nvim/lua/statusline.lua
	[ -f ~/.gitconfig ] || ln -s $(PWD)/gitconfig ~/.gitconfig
	[ -f ~/.ideavimrc ] || ln -s $(PWD)/ideavimrc ~/.ideavimrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tmux/tmux-line.conf ] || ln -s $(PWD)/tmux/tmux-line.conf ~/.tmux/tmux-line.conf

clean:
	rm -f ~/.config/fish/config.fish
	rm -f ~/.config/fish/fish_plugins
	rm -f ~/.config/kitty/ayu-dark.conf
	rm -f ~/.config/kitty/kitty.conf
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/nvim/lua/buffline.lua
	rm -f ~/.config/nvim/lua/config.lua
	rm -f ~/.config/nvim/lua/dashboard.lua
	rm -f ~/.config/nvim/lua/plugins.lua
	rm -f ~/.config/nvim/lua/statusline.lua
	rm -f ~/.gitconfig
	rm -f ~/.ideavimrc
	rm -f ~/.tmux.conf
	rm -f ~/.tmux/tmux-line.conf

.PHONY: all clean sync
