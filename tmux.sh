# Install
sudo apt update
sudo apt install tmux

# Ensure config exists
touch ~/.tmux.conf

# Configure
cat ~/.tmux.conf | grep -q 'setw -g mouse on' || echo 'setw -g mouse on' >> ~/.tmux.conf
