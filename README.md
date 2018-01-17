# nvim
My neovim settings memo.

## quick start

add snippet bashrc.
~~~
export XDG_CONFIG_HOME=~/.config
~~~

install neovim.
~~~
$ brew install neovim
~~~

if your dev is centos6, do this.
~~~
$ sudo yum -y install libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip
$ git clone https://github.com/neovim/neovim
$ cd neovim
$ make
$ sudo make install
~~~

set
~~~
$ mkdir ~/.config
$ cd ~/.config
$ git clone git@github.com:sueshin/nvim.git
$ source ~/.bashrc
~~~

install ctags
~~~
$ brew install ctags
$ git config --global init.templatedir '~/.git_template'
$ mkdir -p ~/.git_template/hooks
~~~

make hooks/ctags
~~~
#!/usr/bin/env bash
set -e
PATH="$HOME/local/bin:/usr/local/bin:$PATH"
cd "$(dirname "${BASH_SOURCE:-$0}")"; cd ../../
trap "rm -f .git/tags.$$" EXIT
ctags --tag-relative=yes -R -f .git/tags.$$
mv .git/tags.$$ .git/tags
~~~

set alias
~~~
git config --global alias.ctags '!.git/hooks/ctags'
~~~

set git hooks(post-checkout, post-commit, post-merge)
~~~
.git/hooks/ctags >/dev/null 2>&1 &
~~~

and this too.(post-rewrite)
~~~
#!/bin/sh
case "$1" in
  rebase) exec .git/hooks/post-merge ;;
esac
~~~

~~~
chmod 755 .git/hooks/ctags
~~~
