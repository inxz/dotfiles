Cygwin install:
===============

Windows 7 fstab:
---------------

In /etc/fstab, add option "noacl" to disable NTFS file system permissions.

Recommend packages:
---------------

Default:

<pre>
bc, curl, vim, rsync, openssh, dos2unix, wget, zip, unzip, util-linux, procps, ncurses, keychain, mc, pwgen, libiconv
</pre>

Source control management:

<pre>
subversion, git
</pre>

Cygwin user and group:
--------------

<pre>
mkpasswd -l -d | grep -i USER >> /etc/passwd
mkgroup -l -d | grep -i GROUP >> /etc/group
</pre>


Tmux cygwin build:
--------------

Required packages:

<pre>
automake, gcc-core, git, pkg-config, make, autoconf, ncurses, libncurses-devel, libevent, libevent-devel
</pre>

Build:

<pre>
cd ~
git clone http://git.code.sf.net/p/tmux/tmux-code
cd tmux-code
./autogen.sh
CFLAGS="-I/usr/include/ncurses" ./configure --prefix=/usr
make && make install
</pre>

Fix Vim colors in Tmux:
--------------

Alias to ~/.bashrc:

<pre>
alias tmux="TERM=screen-256color-bce tmux"
</pre>

Option in ~/.tmux.conf:

<pre>
set -g default-terminal "screen-256color"
</pre>

Git cygwin build:
--------------

Required packages:

<pre>
automake, gcc-core, pkg-config, make, autoconf, curl, libcurl-devel, libiconv, libiconv2, gettext, gettext-devel, perl, python, tcl
</pre>

Build:

<pre>
cd ~
git clone https://github.com/git/git.git
# git checkout VERSION (optional)
make configure
./configure
make && make install
</pre>

Install subtree feature:

<pre>
cd contrib/subtree
make && make install
</pre>

