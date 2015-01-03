brew install bash
brew install bash-completion2
chsh -s /usr/local/bin/bash
echo "/usr/local/bin/bash" >> /ec/shells

add to .extra or profiles

GIT_AUTHOR_NAME="Chris Ng"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="chaoselixir@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi
