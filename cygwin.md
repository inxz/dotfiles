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
automake, gcc-core, git, pkg-config, make, ncurses, libncurses-devel, libevent, libevent-devel
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
