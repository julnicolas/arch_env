#export PATH="~/go/bin:~/bin:~/scripts:~/.local/bin:$PATH"
export PATH="/home/julien/scripts:/home/julien/.local/bin:$PATH"

# Aliases
alias copy='wl-copy'   # copy stdin to clipboard
alias paste='wl-paste' # display clipboard to stdout
alias lsf="ls -F | grep -ve '^.*/$'" # ls files only
alias lsd="ls -F | grep -e '^.*/$' --color=never" # ls directories only
alias gss="git status"
alias glo="git log --oneline"
alias gfi="git diff-tree --name-only -r --no-commit-id"
alias gsc="git show --compact-summary"
#alias daxfr="dig +noedns axfr mydomain.fr @ip"
alias ddelta='delta --syntax-theme "Dracula" --side-by-side'

### Fzf with preview mode
# $1 is the language parameter (-l) for bat
#
# dependencies: bat, fzf
fzfp() {
	if [ -n "$1" ]; then
		PLANG="-l $1"
	fi
	fzf --preview="bat --color always $PLANG {}"
}

### Fzf with preview mode for text browsing
# $1 is the text file to look into
#
# dependencies: bat, fzf
fzft() {
	if [ -z "$1" ]; then
		echo 'error - missing input text file'
		return 1
	fi

	TEXT_FILE="$1"
	fzf --preview="grep -A 10 {} < $TEXT_FILE | bat --color always -l man" < "$TEXT_FILE"
}

### Man with wings
#
#dependencies: man, bat
ban() {
	man $@ | bat -l man --style plain
}

#### VENV UTILITIES

# Create a virtual environment for the active pyenv-enabled python version
# create_venv myvenv
create_venv()
{
	echo 'creating a virtual environment for the active pyenv-enabled python version'
	echo "enabled version - $(pyenv version)"

	if ! which pyenv > /dev/null; then
		echo 'error - pyenv is not installed'
		exit 1
	fi

	local VENV_NAME="$1"
	if [ -z "$VENV_NAME" ]; then
		echo 'missing venv name'
		exit 1
	fi

	# Create venv
	if ! pyenv exec python -m venv ~"/.venvs/$VENV_NAME"; then
		exit 1
	fi
}

# Source a virtual environment
source_venv()
{
	local VENV_NAME="$1"
	if [ -z "$VENV_NAME" ]; then
		echo 'missing venv name'
		exit 1
	fi

	# ~ is not evaluated as local path if in the quotes
	source ~"/.venvs/$VENV_NAME/bin/activate"
}

# list_venvs
ls_venvs()
{
	ls -1 ~/.venvs
}

# remove a python virtual env
rm_venv()
{
	local VENV_NAME="$1"
	if [ -z "$VENV_NAME" ]; then
		echo 'missing venv name'
		exit 1
	fi

	rm -rf ~/.venvs/"$VENV_NAME"
}

########

# Path to your oh-my-zsh installation.
export ZSH=~"/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula-julien"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	#git
	colored-man-pages
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# zsh-autosuggestion
typeset -A ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#656d67'

#zsh-highlighting
# main plugin - change default colors
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

#ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#656d67'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#ff005f'

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Observability Profile

# opam configuration
[[ ! -r /home/julien/.opam/opam-init/init.zsh ]] || source /home/julien/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# import my created dependencies
source ~/.shell_profiles/zsh/arch_linux/*

