
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/raduan/.oh-my-zsh"

# Troubles with mosh:
export LC_ALL="en_US.UTF-8"


# Set clang as default c and c++ compiler
export PATH="/usr/local/opt/llvm/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# zsh syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
alias vim='/usr/local/bin/Vim'

export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin
export PATH=~/go/bin:$PATH
export PATH="/Users/raduan/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Making life easier
alias cdd='cd ~/Desktop'
alias cdp='cd ~/Desktop/projects'
alias prp='poetry run python'
alias gs='git status'
alias gsu='git status -uno'
alias gcm='git commit -m'
alias gpoh='git push origin HEAD'
alias ga='git add'
alias gc='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gp='git pull'
alias gmm='git merge master'
alias pgcm='poetry run git commit -m'
function gcai() {
  # run Claude under a spinner, capture its stdout
  COMMIT_MSG=$(gum spin \
    --spinner moon \
    --title "Generating commit…" \
    --show-output \
    -- /Users/raduan/.claude/local/claude --model "sonnet" -p \
    "look at the changes that I have staged, and write a one liner commit message for these changes, based on conventionalcommits 1.0 styleguide. use format: <emoji> type(scope): <one-sentence-summary>. put a unique emoji in the beginning that reflects the change the closest, and add a space between it and type(scope) that follows. YOU MUST OUTPUT ONLY THE ONE LINER COMMIT MESSAGE IN REQUESTED FORMAT."
  )

  # now commit
  git commit -m "$COMMIT_MSG"
}

function gbs() {
    branches=$(git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)' | head -30)
    branch=$(echo "$branches" | fzf)
    if [ -n "$branch" ]
    then
        echo "You have selected the branch '$branch'"
        git checkout $branch
    else
        echo "No branch selected"
    fi
}
function gsync() {
  git fetch upstream
  # Check if main branch exists
  if git show-ref --verify --quiet refs/heads/main; then
    git checkout main
    git merge upstream/main
  # If main doesn't exist, fallback to master
  elif git show-ref --verify --quiet refs/heads/master; then
    git checkout master
    git merge upstream/master
  else
    echo "Neither 'main' nor 'master' branch exists in this repository."
    return 1
  fi
}

function gda() {
  ##########################################################################
  # Abort the whole function cleanly if the user hits Ctrl-C  (SIGINT)     #
  ##########################################################################
  trap 'echo; echo "❌  Aborted."; return 130' INT      # 130 = "killed by SIGINT"

  # ── locate repo root ───────────────────────────────────────────────────
  local repo
  repo=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "❌  not inside a Git repo" >&2
    trap - INT            # restore default handling before leaving
    return 1
  }

  # ── prefix from repo-root to cwd (e.g. "pdl/") ─────────────────────────
  local prefix
  prefix=$(git rev-parse --show-prefix)

  # ── build root-relative pathspecs from args (or this dir) ──────────────
  local root_args=()
  if [[ $# -eq 0 ]]; then
    root_args=( "$prefix" )
  else
    for a in "$@"; do
      a=${a#./}                           # trim leading ./
      root_args+=( "${prefix}${a}" )
    done
  fi

  # ── porcelain lines we care about:                                     ──
  #    * ??        (untracked)                                            │
  #    * XY where Y ≠ " " (there are unstaged edits)                      ▼
  local plist
  plist=$(git -C "$repo" status --porcelain --untracked-files=all \
            -- "${root_args[@]}" \
          | awk '
              substr($0,1,2)=="??" {print}
              substr($0,2,1)!=" "   {print}
            ')

  # ── collect the unique root-relative paths into an array  ──────────────
  local IFS=$'\n'
  local -a root_paths=($(printf '%s\n' "$plist" | awk '{print $2}' | sort -u))

  # ── loop over each file  ───────────────────────────────────────────────
  local root_path file
  for root_path in "${root_paths[@]}"; do
    [[ -z $root_path ]] && continue
    file=${root_path#$prefix}            # path visible from the current dir

    # preview
    if grep -q "^?? $root_path" <<<"$plist"; then
      echo "🔍  new file: $file"
      bat -- "$file"
    else
      git -C "$repo" diff -- "$root_path"
    fi
    echo

    # confirm & stage
    if gum confirm "Stage changes for $file?" </dev/tty; then
      git -C "$repo" add -- "$root_path"
      echo "✅  staged: $file"
    else
      echo "❌  skipped: $file"
    fi
    echo
  done

  trap - INT      # restore default handling
}

export DENO_INSTALL="/Users/raduan/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="/Users/raduan/.cargo/bin:$PATH"
alias openbb='/Applications/OpenBB\ Terminal/OpenBB\ Terminal'


# Added by Windsurf
export PATH="/Users/raduan/.codeium/windsurf/bin:$PATH"

# bun completions
[ -s "/Users/raduan/.bun/_bun" ] && source "/Users/raduan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export FLYCTL_INSTALL="/Users/raduan/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
# Intel Homebrew (for when specifically needed)
alias brew-intel="/usr/local/bin/brew"
export OPENSSL_DIR=/opt/homebrew/opt/openssl@3
export PKG_CONFIG_PATH=/opt/homebrew/opt/openssl@3/lib/pkgconfig
export PATH="/opt/homebrew/bin:$PATH"
alias af='agentfarm'

# opencode
export PATH=/Users/raduan/.opencode/bin:$PATH
alias claude="~/.claude/local/claude"
alias cc="claude"
alias ccyolo="claude --dangerously-skip-permissions"

