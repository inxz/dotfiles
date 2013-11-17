# Git cache path without leading /.
export GITCACHEPATH="$HOME/.gitcache"
# Optional, configure paths of git repositories (parent w leading / or direct w/o leading /).
# Example: ^/home/user/git/|^/var/git/|^/home/user2/foo/gitproject
export GITPATHFILTER=""
# Refresh time to scan for changes if .git/index is not changed (-1 to disable caching).
export GITREFRESH=60

function __git_status {
	gitpath=$(__git_path)

        if [[ -n $gitpath ]]; then
		gitname=$(basename "$gitpath")
                gitstat=$(stat --format %Y "$GITCACHEPATH/$gitname" 2>/dev/null)
		gitupdate=0;
		gitexpired=$(($(date +%s) - ($gitstat + $GITREFRESH)))
		# First line is timestamp of index file.
		gitoldindex=$(head -n 1 "$GITCACHEPATH/$gitname" 2>/dev/null)
		gitnewindex=$(stat --format %Y "$gitpath/.git/index" 2>/dev/null)
		# Second line is timestamp of fetch_head file.
		# Use sed to avoid 2 processes for head and tail (q to quit after line 2).
		# On initial commit or if no remote is available, fetch head does not exist.
		gitoldfetchhead=$(sed -n '2{p;q}' "$GITCACHEPATH/$gitname" 2>/dev/null)
		gitnewfetchhead=$(stat --format %Y "$gitpath/.git/FETCH_HEAD" 2>/dev/null || echo "NotAvailable")
		# Third line is hash of head, forces update after a commit or fast forward merge/rebase.
		# On initial commit, HEAD-rev does not exist or returns HEAD.
		gitoldhead=$(sed -n '3{p;q}' "$GITCACHEPATH/$gitname" 2>/dev/null || echo "NotAvailable")
		gitnewhead=$(git rev-parse HEAD 2>/dev/null)

                if [[ "$gitoldindex" != "$gitnewindex" || "$gitoldhead" != "$gitnewhead" || "$gitoldfetchhead" != "$gitnewfetchhead" || $gitexpired -gt 0 ]]; then
			gitupdate=1
                        gitresult=$(git status -sb)
                        gitall=$(echo "$gitresult" | tail -n +2 | wc -l)

                        echoresult=$(echo "$gitresult" | head -n 1)
	                echoresult+=" *:$gitall"

                        if [[ "gitall" != 0  ]]; then
                                gitnew=$(echo "$gitresult" | grep -e '^??' | wc -l)
                                gitadd=`echo "$gitresult" | grep -e '^[ ]*A' | wc -l`
                                gitmod=`echo "$gitresult" | grep -e '^[ ]*M' | wc -l`
                                gitdel=`echo "$gitresult" | grep -e '^[ ]*D' | wc -l`
                                gitmov=`echo "$gitresult" | grep -e '^[ ]*R' | wc -l`

                                if [[ "$gitnew" != 0 ]]; then echoresult+=" ?:$gitnew"; fi
                                if [[ "$gitadd" != 0 ]]; then echoresult+=" A:$gitadd"; fi
                                if [[ "$gitmod" != 0 ]]; then echoresult+=" M:$gitmod"; fi
                                if [[ "$gitdel" != 0 ]]; then echoresult+=" D:$gitdel"; fi
                                if [[ "$gitmov" != 0 ]]; then echoresult+=" R:$gitmov"; fi
                        fi

			echo "$gitnewindex" > "$GITCACHEPATH/$gitname"
			echo "$gitnewfetchhead" >> "$GITCACHEPATH/$gitname"
			echo "$gitnewhead" >> "$GITCACHEPATH/$gitname"
                        echo "$echoresult" >> "$GITCACHEPATH/$gitname"
                fi

                echo -n " ["

		if [[ "$gitupdate" == 1 ]]; then
			echo -n "'"
		fi

		echo -n $(tail -n -1 "$GITCACHEPATH/$gitname")
		echo -n "]"
        fi
}

function __git_path {
	if [[ ! -d "$GITCACHEPATH" ]]; then
		mkdir -p "$GITCACHEPATH"
	fi

	rootdir="$1"

	if [[ -z "$rootdir" ]]; then
		rootdir=$(pwd)
	fi

	dir=$rootdir

	if [[ "$dir" != "/" && (-z "$GITPATHFILTER" || $(echo "$dir" | grep -e "$GITPATHFILTER")) ]]; then
		while [[ ("$dir" != "/") && (! -d "$dir/.git") ]]; do
			dir=$(dirname $dir)

			if [[ "$dir" == "/" ]]; then
				dir=""
				break
			fi
		done
	else
		dir=""
	fi

	# Do not return a directory if rootdir contains git-project/.git
	# because a git status is now allowed in internal .git directory.
	if [[ -n "$dir" && $(echo "$rootdir" | grep "$dir/.git") ]]; then
		dir=""
	fi

	echo "$dir"
}

function git-refresh {
	gitpath=$(__git_path)

	if [[ -n $gitpath ]]; then
		gitname=$(basename "$gitpath")
		rm -f "$GITCACHEPATH/$gitname"
	fi
}
