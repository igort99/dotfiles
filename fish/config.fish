if status is-interactive
    # Commands to run in interactive sessions can go here
end

set PATH $HOME/.cargo/bin $PATH
nvm use 20.11.0 >/dev/null ^&1

# Set up PATH for Doom Emacs
set -x PATH $HOME/.emacs.d/bin $PATH

# Remove the fish greeting message
set -U fish_greeting ""

set PATH $PATH ~/.nvm
set -x PATH $PATH /opt/nvim-linux64/bin
set -gx PATH $PATH /usr/bin

# Install Ruby Gems to ~/gems
set -Ux GEM_HOME $HOME/gems
set -Ux PATH $HOME/gems/bin $PATH

set -x COLORTERM truecolor
set -x TERM xterm-256color


# Aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

alias qemu='/usr/bin/qemu-system-x86_64'


function git-task
    set branch_name (git rev-parse --abbrev-ref HEAD)
    echo $branch_name | grep -Eo "(BRAME|B20|IN)-[0-9]+"
end

# Function to commit with the task ID from the current branch
function gc
    set task_id (git-task)

    if test -z "$task_id"
        echo "Error: Unable to extract task ID from branch name."
        return 1
    end

    git commit -m "$task_id: $argv"
end

set -x TERM alacritty
alias nv='nvim .'
