
# run: curl -s http://lauri.rooden.ee/setup.sh | sh -s --

mkdir -p ~/.config ~/.ssh

# Prepare .ssh folder and files
chmod 700 ~/.ssh
touch ~/.ssh/authorized_keys ~/.ssh/config ~/.ssh/known_hosts
chmod 600 ~/.ssh/authorized_keys ~/.ssh/config ~/.ssh/known_hosts

# Generating SSH keys
ssh-keygen -t rsa -b 2048 -C "lauri@rooden.ee-$(hostname -s)"

cat .ssh/id_rsa.pub
read -p "Add previous key to github..."

git clone --bare git@github.com:lauriro/dotfiles.git ~/.config/dotfiles.git

export GIT_DIR=~/.config/dotfiles.git
export GIT_WORK_TREE=~
git reset --hard
unset GIT_DIR
unset GIT_WORK_TREE

