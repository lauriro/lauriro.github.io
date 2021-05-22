
mkdir ~/.ssh
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys ~/.ssh/config ~/.ssh/known_hosts
chmod 600 ~/.ssh/authorized_keys ~/.ssh/config ~/.ssh/known_hosts
# Generating SSH keys

REPO=~/.config/dotfiles.git
printf "Enter your full name: "
read NAME
printf "Enter your email: "
read MAIL

ssh-keygen -t rsa -b 2048 -C "$MAIL"
ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub

git config --global user.name "$NAME"
git config --global user.email "$MAIL"

git clone --bare -n ssh://git@bitbucket.org/lauriro/dotfiles.git $REPO
git --git-dir $REPO config core.bare false
git --git-dir $REPO config core.worktree $HOME
git --git-dir $REPO read-tree -v HEAD
git --git-dir $REPO checkout-index -a -q

#git config --global core.excludesfile ~/.gitignore

