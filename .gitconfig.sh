#!/bin/zsh

# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

function current_branch() {
  git_current_branch
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in main trunk; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo master
}

alias ga.='git add .'
alias ga='git add .'
alias gb='git branch'
alias gbD='git branch -D'
alias gbd='git branch -d'
alias gc!='git commit -v --amend && gpf'
alias gcm='git checkout $(git_main_branch) && gfa && gl'
alias gcnmsg='git commit -nm'
alias gco-='git checkout -'
alias gco='git checkout'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gdw='git diff --word-diff'
alias get-staged="git diff --cached --name-only"
alias gfa='git fetch --all --prune'
alias gfom='git fetch --prune origin master:master && git rebase master'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='loghours && git pull --rebase origin master && git push origin "$(git_current_branch)" && loghours'
alias gl='git pull'
alias glb='git pull origin $(current_branch)'
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias gpf!='git push --force'
alias gpf='git push --force-with-lease origin $(current_branch)'
alias grb='git rebase origin/master'
alias grbip='gfom && echo "---------Fetched latest master---------" && git rebase -i origin/master && echo "---------Rebased to latest master---------" && git push --force-with-lease origin $(current_branch) && echo "---------Pushed to remote---------"'
alias grbipn='gfom && echo "---------Fetched latest master---------" && git rebase -i origin/master && echo "---------Rebased to latest master---------" && git push -o ci.skip --force-with-lease origin $(current_branch) && echo "---------Pushed to remote---------"'
alias loghours='echo ------------------------ LOG HOURS PLS ---------------------------'

# Refactor to function
# alias format="get-staged | xargs prettier --write 2> /dev/null"
alias remove-log="git add .; git diff --cached --name-only | xargs sed -i /console.log/d; git add ."
alias remove-tmp="git add .; git diff --cached --name-only | rg '\-tmp' | xargs rm -vf | wc -l | { read no; echo no files deleted }; git add ."
alias remove-f="git add .; git diff --cached --name-only | xargs sed -i 's/fdescribe(/describe(/g; s/fit(/it(/g'; git add ."
alias remove-all="git add .; git diff --cached --name-only | tee >(xargs sed -i /console.log/d) >(rg '\-tmp' | xargs rm -vf | wc -l | { read no; echo no files deleted }) >(xargs sed -i 's/fdescribe(/describe(/g; s/fit(/it(/g'); git add ."

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

function gcmsg () {
  loghours
  branch=$(git_current_branch) 
  if [[ ${branch} == "master" ]]
  then
    echo "You are on master, please checkout a branch."
    return
  fi
  branch=${branch##*\/} 
  branch=${branch%-[[:alpha:]]} 
  if [[ $2 == "n" ]]
  then
    git commit -nm "$branch $1"
  else
    git commit -m "$branch $1"
  fi
}

# Enhanced gcmsg with push/E2E prompts
function gcmsg_enhanced () {
  loghours
  branch=$(git_current_branch) 
  if [[ ${branch} == "master" ]]
  then
    echo "You are on master, please checkout a branch."
    return
  fi
  branch=${branch##*\/} 
  branch=${branch%-[[:alpha:]]} 
  if [[ $2 == "n" ]]
  then
    git commit -nm "$branch $1"
  else
    git commit -m "$branch $1"
  fi
  
  # Check if commit was successful
  if [[ $? -eq 0 ]]; then
    echo ""
    echo "✅ Commit successful!"
    
    # Ask if user wants to push
    echo -n "🚀 Push now? (y/N): "
    read -r push_choice
    if [[ $push_choice =~ ^[Yy]$ ]]; then
      echo ""
      echo -n "🧪 Run E2E tests locally? (y/N): "
      read -r e2e_choice
      
      if [[ $e2e_choice =~ ^[Yy]$ ]]; then
        echo ""
        echo "🧪 Running E2E tests..."
        if npx cypress run --browser chrome; then
          echo "✅ E2E tests passed!"
          echo "🚀 Pushing to remote..."
          grbip
        else
          echo "❌ E2E tests failed. Not pushing."
          echo "💡 Fix the tests and run 'grbip' manually when ready."
          return 1
        fi
      else
        echo "🚀 Pushing to remote (E2E tests skipped)..."
        grbip
      fi
    else
      echo "ℹ️  Not pushing. Run 'grbip' manually when ready."
    fi
  else
    echo "❌ Commit failed."
    return 1
  fi
}

# Alias for the enhanced version
alias gcmsg='gcmsg_enhanced'
