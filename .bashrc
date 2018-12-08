# stock .bashrc {{{

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# }}}
# tty {{{

# Disable starting and stopping terminal input with \C-s and \C-q to enable the
# readline binding "\C-s":forward-search-history to work.

stty -ixon
stty werase "^v"		

# }}}
# shell options {{{

shopt -s cdable_vars		
#shopt -s checkjobs		
set +o noclobber		

# }}}
# history {{{

HISTFILESIZE=1000000
HISTSIZE="$HISTFILESIZE"
HISTCONTROL="ignorespace:ignoredups:erasedups"

export HISTFILE

# }}}
# mpd {{{

export MPD_HOST=/var/run/mpd/socket

# }}}
# konsole {{{

export TERMINAL_EMULATOR='/usr/bin/konsole -e'

# }}}
# ruby/rails {{{

export RAILS_ENV=development
export PATH="$HOME/.rbenv/bin:$PATH"
export RUBY_GEM_SYSTEM_DEPENDENCIES_SERVICE_URI='http://localhost:3000/'
eval "$(rbenv init -)"

# }}}
# java {{{

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
export PATH=${JAVA_HOME}/bin:${PATH}

# }}}
# less {{{

export LESS="-i -R"
lesskey

# }}}
# docker {{{

export COMPOSE_HTTP_TIMEOUT=600000

# }}}
# golang {{{

export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin:$GOBIN

# }}}
# kubectl {{{

# {{{ setup

__kubectl_context()
{
  context=$(kubectl config current-context)

  if [ -z $context ]; then
    echo -n ''
  else
    echo -n "[$context]"
  fi
}

source <(kubectl completion bash)

# }}}
# common {{{

k()
{
  kubectl "$@"
}

kd()
{
  kubectl describe "$@"
}

_kgrep()
{
  egrep -i --line-buffered "$@"
}

_k_extract_name()
{
  name=`echo "$1" | head -n2 | tail -n1 | cut -f1 -d' '`

  echo $name
}

_kgfm()
{
  resources=`kg $1 "$2"`

  echo `_k_extract_name "$resources"`
}

_k_run_if_non_empty()
{
  resource=`_kgfm "$1" "$2"`

  if [ -z $1 ]; then
    echo "No matching resources"

    return 1
  fi

  echo "--------------- $resource ---------------"
  sleep 1
  $2 $1
}

kg()
{
  kubectl get $1 | _kgrep "$2"
}

ke()
{
  kubectl edit "$@"
}

kd()
{
  kubectl delete "$@"
}

# }}}
# pods {{{

kgp()
{
  kg pods "$1"
}

kep()
{
  ke pod "$@"
}

kex()
{
  kubectl exec -i -t "$1" -- "${@:-2}"
}

kdp()
{
  kd pod "$@"
}

# monitoring {{{

kgpw()
{
  kgp -w
}

kgpwg()
{
  if [ -z "$2" ]; then
    kgpw 2>&1 | kgrep "$1"
  else
    kgpw 2>&1 | kgrep "$1" | kgrep "$2"
  fi
}

kw()
{
  time kgpwg "$@"
}

kterminating()
{
  kw 'terminating' "$1"
}

kcreating()
{
  kw 'containercreating' "$1"
}

kcrt()
{
  kw 'containercreating|running|terminating' "$1"
}

krunning()
{
  kw 'running' "$1"
}

koom()
{
  kw 'oomkilled' "$1"
}

kloop()
{
  kw 'crashloopbackoff' "$1"
}

kerror()
{
  kw 'error' "$1"
}

kpending()
{
  kw 'pending' "$1"
}

kfaulty()
{
  kw 'oomkilled|error|crashloopbackoff' "$1"
}

kl()
{
  k logs -f "$1" 2>/dev/null

  if [ "$?" == 1 ]; then
    pods=`kgpg $1 | kgrep running`

    if [ -z "$pods" ]; then
      echo "No matching pods"
    else
      pod=`echo "$pods" | head -n1 | cut -f1 -d' '`

      echo "------------ $pod ------------"
      k logs -f $pod
    fi
  fi
}

# }}}

# }}}
# deployments {{{

kdd()
{
  kd deployment "$@"
}

kgd()
{
  kg deployment "$@"
}

kgdg()
{
  kgd | kgrep "$1"
}

ksd()
{
  kubectl scale deployment "$1" --replicas "$2"
}

ked()
{
  deployment=`_kgfm deployment "$1"`

  _k_run_if_non_empty "$deployment" 'ke deployment'
}

# }}}
# configmaps {{{

kgc()
{
  kg configmaps "$@"
}

kgcg()
{
  kgc | grep -i "$1"
}

kec()
{
  ke configmap "$@"
}

# }}}

# }}}
# fzf {{{

export FZF_DEFAULT_OPTS="--bind ctrl-l:accept,ctrl-a:select-all,ctrl-d:deselect-all,ctrl-y:toggle-up,ctrl-i:toggle-down,ctrl-r:toggle-sort
                         --algo=v2
                         --tiebreak=index
                         --history-size=1000000
                         --no-mouse
                         --filepath-word
                         --tabstop=2
                         --color=bw
                         --black
                         --select-1
                         --exit-0
                         --multi
                         --sort
                        "
export FZF_DEFAULT_COMMAND="fd --hidden --type f --type l --type d \
                            -E '*webapp*' \
                            -E '*/.git/*' \
                            -E 'go/src/{github,golang,gopkg}*' \
                            -E '.rbenv' \
                            -E '.vim/' \
                            -E 'programming*vendor' \
                            -E 'go/pkg/' \
                            -E '.npm' \
                            -E '.nvm' \
                            -E '.cache' \
                            -E '.mozilla' \
                            -E '.config/google-chrome*' \
                            -E '.config/teamviewer*' \
                            -E '.kde' \
                            -E '.gem/'
                           "
export FZF_BASE_DIR=$HOME
export FZF_CTRL_R_OPTS="$FZF_DEFAULT_OPTS --reverse --history=/home/marwan/.local/share/bash-fzf-history --height 1 --min-height 1 --with-nth=2.. --header= --inline-info"
export FZF_CTRL_T_COMMAND="cd $FZF_BASE_DIR; $FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS --reverse --multi --history=/home/marwan/.local/share/ctrl-t--fzf-history --bind 'ctrl-l:execute(xdg-open $FZF_BASE_DIR/{+} >/dev/null 2>&1 & disown)+abort'"
export FZF_ALT_C_OPTS="$FZF_DEFAULT_OPTS --reverse --no-multi --history=/home/marwan/.local/share/dir-fzf-history"
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS='+c -x' # I don't know what the +c option does since it's not documented in fzf(1)

_fzf_compgen_path() {
  eval $FZF_DEFAULT_COMMAND
}

_fzf_compgen_dir() {
  fd --type d --exclude ".git" . "$1"
}

complete -F _fzf_path_completion -o default -o bashdefault ag
complete -F _fzf_dir_completion -o default -o bashdefault tree

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# }}}
# hub {{{

eval "$(hub alias -s)"

# }}}
# nvm {{{

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# }}}
# git {{{

gpl()
{
  git pull "$@"
}

gpull()
{
  gpl "$@"
}

gp()
{
  git push origin HEAD "$@"
}

gpush()
{
  gp "$@"
}

gpsh() {
  gp "$@"
}

gf()
{
  git fetch "$@"
}

gss()
{
  git stash save "$@"
}

gsa()
{
  git stash apply "$@"
}

gsl()
{
  git stash list "$@"
}

gsp()
{
  git stash pop "$@"
}

gm()
{
  git merge "$@"
}

gmm()
{
  git merge master $@
}

gma()
{
  git merge --abort "$@"
}

gr()
{
  git rebase "$@"
}

grev()
{
  git revert "$@"
}

grc()
{
  gr --continue "$@"
}

gra()
{
  gr --abort "$@"
}

gri()
{
  step=${1:-2}

  echo -n $step | egrep -q -i '^[0-9]+$'

  if [ $? = 0 ]; then
    step='HEAD~'$step
  fi


  git rebase -i $step
}

grm()
{
  wip=`gss | grep -q WIP; echo $?`

  gchm
  gpl
  gch-
  gr master "$@"

  if [ $wip = 0 ]; then
    gsp 2>/dev/null
  fi

}

gc()
{
  if [ -n "$1" ]; then
    git commit -m "$@"
  else
    git commit
  fi
}

gca()
{
  if [ -n "$1" ]; then
    git commit -a -m "$@"
  else
    git commit -a
  fi
}

gcam()
{
  git commit --amend "$@"
}

gcaam()
{
  git commit -a --amend "$@"
}

gcamn()
{
  git commit --amend --no-edit "$@"
}

gcaamn()
{
  git commit -a --amend --no-edit "$@"
}

gcamnpf()
{
  git commit --amend --no-edit "$@"
  git push -f origin HEAD
}

gcaamnpf()
{
  git commit -a --amend --no-edit
  git push -f origin HEAD
}

gpf()
{
  git push -f origin HEAD "$@"
}

gs()
{
  git status "$@"
}

g()
{
  git "$@"
}

gd()
{
  git diff --patch-with-stat "${@:-HEAD}"
}

gdh()
{
  git diff --patch-with-stat HEAD "$@"
}

gdm()
{
  git diff --patch-with-stat master "$@"
}

gdiff()
{
  gd "$@"
}

gsh()
{
  git show --patch-with-stat "$@"
}

gl()
{
  git log --no-merges --invert-grep --grep='^Version [0-9\.]+$' --pretty=oneline --pretty=format:"%H - \"%an\" - %ar -  %s" "$@"
}

gls()
{
  git log --no-merges --invert-grep --grep='^Version [0-9\.]+$' --pretty=oneline --pretty=format:"%s" "$@"
}

glm()
{
  gl master.. "$@"
}

glms()
{
  gls master.. "$@"
}

gch()
{
  git checkout "$@"
}

gb()
{
  git branch "$@"
}

gbm()
{
  old_branch=`git rev-parse --abbrev-ref HEAD`

  git branch -m $old_branch $2
  git push origin :$old_branch $2
  git push origin -u $2
}

gbd()
{
  branch=${1:-`git rev-parse --abbrev-ref HEAD`}

  if [ "$branch" == 'master' ]; then
    echo "You're trying to delete master!"

    return
  fi

  git checkout master
  echo "Deleting local '$branch' branch..."

  args="$@"

  if [ -n "$args" ] && [ "$args" != "$branch" ]; then
    args="$args $branch"
  else
    args="$branch"
  fi

  git branch -D "$args"
  echo "Deleting remote '$branch' branch (if any)..."
  git push origin :$branch
}

gbdl()
{
  branch=`git rev-parse --abbrev-ref HEAD`

  git checkout master
  git branch -D $branch "$@"
}

gch-()
{
  gch - "$@"
}

gchb()
{
  git checkout -b "$@"
  git push -u origin HEAD
}

gnb()
{
  gchb "$@"
}

gnbl()
{
  git checkout -b "$@"
}

gchm()
{
  git checkout master "$@"
}

grh()
{
  step=${1:-0}

  echo -n $step | egrep -q -i '^[0-9]+$'

  if [ $? = 0 ]; then
    step='HEAD~'$step
  fi

  git reset --hard $step
}

grs()
{
  step=${1:-0}

  git reset --soft HEAD~"$1"
}

gsd()
{
  git stash drop "$@"
}

gsc()
{
  git stash clear "$@"
}

ga()
{
  git add -v "$@"
}

gaa()
{
  git add -v . "$@"
}

gcf()
{
  git clean -f -d "$@"
}

gcfd()
{
  git clean -d -n "$@"
}

grp()
{
  how_far=$1

  if [ -z ${how_far} ]; then
    how_far='HEAD'
  else
    how_far="HEAD~${how_far}"
  fi

  git rev-parse $how_far
}

gmv() {
  git mv -v -f "$@"
}

grmv() {
  git rm -f "$@"
}

grmvc() {
  git rm --cached "$@"
}

grl() {
  git reflog
}

gcl() {
  git clone "$@"
}

gdc() {
  git diff --cached "$@"
}

declare -x -A GIT_ALIASES_COMPLETION_MAP=( ['gpl']='pull'
                                           ['gpull']='pull'
                                           ['gp']='push'
                                           ['gpsh']='push'
                                           ['gpush']='push'
                                           ['gf']='fetch'
                                           ['gss']='stash'
                                           ['gsa']='stash'
                                           ['gsl']='stash'
                                           ['gm']='merge'
                                           ['gma']='merge'
                                           ['gr']='rebase'
                                           ['gri']='rebase'
                                           ['grc']='rebase'
                                           ['gra']='rebase'
                                           ['grm']='rebase'
                                           ['grmv']='rm'
                                           ['grmvc']='rm'
                                           ['gc']='commit'
                                           ['gca']='commit'
                                           ['gcam']='commit'
                                           ['gcaam']='commit'
                                           ['gcamn']='commit'
                                           ['gcaamn']='commit'
                                           ['gcamnpf']='push'
                                           ['gcaamnpf']='push'
                                           ['gpf']='push'
                                           ['gs']='status'
                                           ['g']='git'
                                           ['gd']='diff'
                                           ['gdh']='diff'
                                           ['gdm']='diff'
                                           ['gdiff']='diff'
                                           ['gsh']='show'
                                           ['gl']='log'
                                           ['gls']='log'
                                           ['glm']='log'
                                           ['glms']='log'
                                           ['gch']='checkout'
                                           ['gb']='branch'
                                           ['gbd']='branch'
                                           ['gbdl']='branch'
                                           ['gbm']='branch'
                                           ['gchb']='checkout'
                                           ['gnb']='checkout'
                                           ['gchm']='checkout'
                                           ['gch-']='checkout'
                                           ['grh']='reset'
                                           ['grs']='reset'
                                           ['gsd']='stash'
                                           ['gsc']='stash'
                                           ['gsp']='stash'
                                           ['ga']='add'
                                           ['gaa']='add'
                                           ['gcf']='clean'
                                           ['gcfd']='clean'
                                           ['grp']='git'
                                           ['gmv']='mv'
                                           ['grm']='rm'
                                           ['grl']='reflog'
                                           ['gcl']='clone'
                                           ['gdc']='diff'
                                           ['grev']='revert'
                                         )

# }}}
# task {{{

__tc()
{
  context=$(task context | grep yes | grep -v grep | awk '{print $1;}')

  if [ -z $context ]; then
    echo -n ''
  else
    echo -n "[$context]"
  fi
}

_t()
{
  task "$@"
}

t()
{
  task "$@"
}

tl()
{
  task "$@" list
}

tn()
{
  tpd "$@"
}

tpd()
{
  task \(priority and due\) "$@"
}

tpad()
{
  tpd "$@"
}

tdap()
{
  tpd "$@"
}

tdp()
{
  tpd "$@"
}

tpod()
{
  task priority or due "$@"
}

tdop()
{
  tpod "$@"
}

ta()
{
  task "$@" add
}

tv()
{
  task "$@" active
}

tu()
{
  task "$@" undo
}

tdl()
{
  task "$@" delete
}

tdu()
{
  task "$@" due
}

tt()
{
  task "$@" tags
}

tc()
{
  if [ -n "$1" ]; then
    task context "$@"
  else
    task context none
  fi >/dev/null 2>/dev/null
}

tcn()
{
  tc none "$@"
}

tcw()
{
  tc work "$@"
}

tcp()
{
  tc productivity "$@"
}

ts()
{
  task "$@" start; tv
}

tstop()
{
  task "$@" stop
}

tstp()
{
  tstop "$@"
}

ti()
{
  task "$@" information
}

tbl()
{
  task "$@" blocked
}

tbgl()
{
  task "$@" blocking
}

td()
{
  task "$@" done
}

tdn()
{
  task "$@" completed
}

te()
{
  task "$@" edit
}

tm()
{
  task modify "$@"
}

tan()
{
  task annotate "$@"
}

treopen()
{
  tm "$@" status:pending end:
}

tpp()
{
  task "$@" priority:H -ACTIVE
}

tpph()
{
  tpp "$@" -ACTIVE
}

tppm()
{
  task "$@" priority:M -ACTIVE
}

tppl()
{
  task "$@" priority:L -ACTIVE
}

tp()
{
  task "$@" priority:H
}

tph()
{
  tp "$@"
}

tpm()
{
  task "$@" priority:M
}

tpl()
{
  task "$@" priority:L
}

tap()
{
  ta "$@" +productivity
}

tnow()
{
  ta "$@"
  t +LATEST modify priority:H due:now
  t +LATEST start
  t +LATEST
}

tshow()
{
  t show | less
}

export TASK_ALIASES=( _t
                      t
                      tl
                      tn
                      tpd
                      tpad
                      tdap
                      tdp
                      tpod
                      tdop
                      ta
                      tv
                      tu
                      tdl
                      tdu
                      tt
                      tc
                      tcn
                      tcw
                      tcp
                      ts
                      tstop
                      tstp
                      ti
                      tb
                      tbg
                      td
                      tdn
                      te
                      tm
                      tan
                      treopen
                      tpp
                      tpph
                      tppm
                      tppl
                      tp
                      tph
                      tpm
                      tpl
                      tap
                      tnow
                    )

# }}}
# source completions {{{

# This have to exeucte at the end of the file

pwd=$PWD; cd ~/.bash_completion.d; for i in `ls`; do source ./$i; done; cd $pwd

# }}}
# PATH {{{

export PATH="/home/marwan/.local/bin:/usr/local/bin:$PATH"

# }}}
# PS1 {{{

export PS1="\u@\h\w \$(__tc)\$(__git_ps1 '[%s]')\$ "

# }}}
# chrome {{{

# google-chrome(){
#   command google-chrome --kiosk >/dev/null 2>/dev/null & disown
# }

# }}}
# tor {{{

tor(){
  command tor >/dev/null 2>/dev/null & disown
}

# }}}
# tmux {{{

source ~/bin/tmux.completion.bash.sh
tmux new-session -s default 2>/dev/null

if [ $? == 1 ]; then
  tmux attach-session -t default 2>/dev/null
fi

# }}}
# misc shortcuts {{{
# {{{ utils

cp()
{
  builtin command cp -v "$@"
}

mv()
{
  builtin command mv -v "$@"
}

rm()
{
  builtin command rm -v "$@"
}

chmod()
{
  builtin command chmod -v "$@"
}

chown()
{
  builtin command chown -v "$@"
}

function help()
{
  builtin help "$@" | less
}

bl()
{
  watch -n1 'acpi'
}

calc()
{
  echo "scale=7;$1" | bc -l
}

mkdir()
{
  command mkdir -v -p "$@"
}

dlocate()
{
  command dlocate "$@" | less
}

s2ram()
{
  sudo pm-suspend
}

s2disk()
{
  sudo pm-hibernate
}

sb()
{
  source ~/.bashrc
}

bkp()
{
  ~/bin/backup & disown
}

rmf()
{
  command rm -rvf "$@"
}

function grep()
{
  command grep "$@" | command grep -v 'grep'
}

z()
{
  command zathura "$@"
}

function find()
{
  fd "$@"
}

killall()
{
  command killall -v "$@"
}

# }}}
# {{{ media

song()
{
  format="file"
  track="$(mpc -f "%$format%" current)"

  if echo "$track" | grep -i -q "^http://.*"; then
    format="title"
  fi

  basename "$(mpc -f "%$format%" current)" ".mp3"
}

csong()
{
  song | xclip -selection c
}

vlc()
{
  command vlc "$@" >/dev/null 2>/dev/null & disown
}

audacious()
{
  command audacious "$@" >/dev/null 2>&1 & disown
}

music()
{
  tmux send-keys -t "media:0.0" C-z 'ncmpcpp' Enter
  $TERMINAL_EMULATOR tmux attach-session -t media 2>/dev/null 1>&2 & disown
}

mpv()
{
  command mpv --loop "$@"
}

cam()
{
  mplayer tv://
}

# }}}
# {{{ web

google-chrome()
{
  command google-chrome --allow-outdated-plugins "$@" >/dev/null 2>/dev/null & disown
}

# }}}
# {{{ mail

mail()
{
  _initialize_mutt_panes
  $TERMINAL_EMULATOR tmux attach-session -t mail:1.0 2>/dev/null 1>&2 & disown
}

mutt-pub()
{
  /usr/bin/mutt -F ~/.muttrc.pub
}

mutt-priv()
{
  /usr/bin/mutt -F ~/.muttrc.priv
}

mutt-work()
{
  /usr/bin/mutt -F ~/.muttrc.work
}

_initialize_mutt_panes()
{
  i=0

  for profile in work priv pub; do
    tmux send-keys -t "mail:$i.0" C-z "mutt-$profile" Enter
    ((i++))
  done
}

# }}}
# {{{ pkg

dpkg()
{
  command dpkg "$@" | less
}

apt-get()
{
  sudo apt-get -y "$@"
}

aptitude()
{
  _aptitude -y "$@"
}

_aptitude()
{
  for i in "$@"; do
    if [ "$i" = aptitude ]; then
      continue;
    fi

    if echo "$i" | egrep -q "^[^-]"; then
      # Not console mode so pipe to less.
      sudo aptitude "$@" | less
      return;
    fi
  done

  # aptitude will start in console mode.
  sudo aptitude "$@"
}

# }}}
# }}}
