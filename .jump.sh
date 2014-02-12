#!/bin/bash

export MARKPATH=$HOME/.marks

function jump {
        cd -P $MARKPATH/$1 2>/dev/null || echo "No such mark: $1"
}

function j {
	jump $@
}

function mark {
        mkdir -p $MARKPATH; ln -s $(pwd) $MARKPATH/$1
}

function unmark {
        rm -i $MARKPATH/$1
}

function marks {
        ls -l ~/.marks | awk '/^l/ {print $9 " -> " $11}'
}

_jump() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local result=$(compgen -d "$MARKPATH/$cur" -- "$cur")

        if [[ -n "$result" && $(echo "$result" | wc -l) -eq 1 ]]; then
                result+="/"
        fi


        COMPREPLY=( $(echo "$result" | sed -e "s#$MARKPATH/##") )
}

_unmark() {
        local cur=${COMP_WORDS[COMP_CWORD]}
        local wordlist=$(find $MARKPATH -type l -printf "%f\n")
        COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$cur"))
        return 0
}

complete -o nospace -o filenames -F _jump jump j
complete -F _unmark unmark

