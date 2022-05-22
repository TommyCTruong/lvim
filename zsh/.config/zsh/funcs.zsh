########################### Change directory ############################

# fd - cd to selected directory
fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
		-o -type d -print 2>/dev/null | fzf +m) &&
		cd "$dir"
}

# fda - including hidden directories
fda() {
	local dir
	dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
}

# fdf - cd into the directory of the selected file
fdf() {
	local file
	local dir
	file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

############################ History ############################

# fh - repeat history
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

############################ Processes ############################

# fkill - kill processes (list only the ones you can kill)
fkill() {
	local pid
	if [ "$UID" != "0" ]; then
		pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
	else
		pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	fi

	if [ "x$pid" != "x" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

portpid() {
	lsof -n -i :$1 | grep LISTEN | awk -F' ' '{print $2}'
}

############################ Git ############################

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
	local branches branch
	branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
		branch=$(echo "$branches" |
			fzf-tmux -d $((2 + $(wc -l <<<"$branches"))) +m) &&
		git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fcoc_preview - checkout git commit with previews
fcoc_preview() {
	local commit
	commit=$(glNoGraph |
		fzf --no-sort --reverse --tiebreak=index --no-multi \
			--ansi --preview="$_viewGitLogLine") &&
		git checkout $(echo "$commit" | sed "s/ .*//")
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
	local commits commit
	commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
		commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
		echo -n $(echo "$commit" | sed "s/ .*//")
}

# BROKEN!
# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
	local out q k sha
	while out=$(
		git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
			fzf --ansi --no-sort --query="$q" --print-query \
				--expect=ctrl-d,ctrl-b
	); do
		mapfile -t out <<<"$out"
		q="${out[0]}"
		k="${out[1]}"
		sha="${out[-1]}"
		sha="${sha%% *}"
		[[ -z "$sha" ]] && continue
		if [[ "$k" == 'ctrl-d' ]]; then
			git diff $sha
		elif [[ "$k" == 'ctrl-b' ]]; then
			git stash branch "stash-$sha" $sha
			break
		else
			git stash show -p $sha
		fi
	done
}

############################ Chrome Browser ############################

# ch - browse chrome history
ch() {
	local cols sep google_history open
	cols=$((COLUMNS / 3))
	sep='{::}'

	google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
	open=open

	cp -f "$google_history" /tmp/h
	sqlite3 -separator $sep /tmp/h \
		"select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
		awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
		fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open >/dev/null 2>/dev/null
}

# cb - browse chrome bookmarks (depends on jq: brew install jq)
cb() {
	bookmarks_path=~/Library/Application\ Support/Google/Chrome/Default/Bookmarks

	jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

	jq -r "$jq_script" <"$bookmarks_path" |
		sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' |
		fzf --ansi |
		cut -d$'\t' -f2 |
		xargs open
}

# c - browse brave history
bh() {
	local cols sep google_history open
	cols=$((COLUMNS / 3))
	sep='{::}'

	google_history="$HOME/Library/Application Support/BraveSoftware/Brave-Browser/Default/History"
	open=open

	cp -f "$google_history" /tmp/h
	sqlite3 -separator $sep /tmp/h \
		"select substr(title, 1, $cols), url
     from urls order by last_visit_time desc" |
		awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
		fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs $open >/dev/null 2>/dev/null
}

############################ Brave Browser ############################

# bb - browse brave bookmarks (depends on jq: brew install jq)
bb() {
	bookmarks_path=~/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/Bookmarks

	jq_script='
        def ancestors: while(. | length >= 2; del(.[-1,-2]));
        . as $in | paths(.url?) as $key | $in | getpath($key) | {name,url, path: [$key[0:-2] | ancestors as $a | $in | getpath($a) | .name?] | reverse | join("/") } | .path + "/" + .name + "\t" + .url'

	jq -r "$jq_script" <"$bookmarks_path" |
		sed -E $'s/(.*)\t(.*)/\\1\t\x1b[36m\\2\x1b[m/g' |
		fzf --ansi |
		cut -d$'\t' -f2 |
		xargs open
}

############################ Docker ############################

# Select a docker container to start and attach to
function da() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}

# Select a running docker container to stop
function ds() {
	local cid
	cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker stop "$cid"
}

# Select a docker container to remove
function drm() {
	local cid
	cid=$(docker ps -a | sed 1d | fzf -q "$1" | awk '{print $1}')

	[ -n "$cid" ] && docker rm "$cid"
}

# Select a docker image or images to remove
function drmi() {
	docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}
