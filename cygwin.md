Cygwin install:
===============

Windows 7 fstab:
---------------

In /etc/fstab, add option "noacl" to disable NTFS file system permissions.

Recommend packages:
---------------

Default:

<pre>
bc, curl, libcurl4, vim, rsync, openssh, openssl, dos2unix, wget, bzip2, p7zip, zip, unzip, util-linux, inetutils, procps, ncurses, keychain, mc, pwgen, libiconv, libiconv2
</pre>

Source control management:

<pre>
subversion, git, git-completion, git-svn
</pre>

Cygwin user and group:
--------------

<pre>
mkpasswd -l -d | grep -i USER >> /etc/passwd
mkgroup -l -d | grep -i GROUP >> /etc/group
</pre>

Cygwin setup alias:
--------------

<pre>
cygstart -- /path/to/setup-x86.exe -B -K http://cygwinports.org/ports.gpg
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
automake, gcc-core, pkg-config, make, autoconf, curl, libcurl-devel, libiconv, libiconv2, gettext, gettext-devel, zlib0, zlib-devel, openssl, openssl-devel, perl, python, tcl
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

