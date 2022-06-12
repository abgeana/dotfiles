#! /usr/bin/zsh

# get the absolute path to the directory where the script is located
script_path=$(readlink -f $0)
script_dir=$(dirname $script_path)

# set the permissions for files to 0600
find $script_dir -type f -exec chmod 0600 '{}' \;

# set the permissions for directories to 0700
find $script_dir -type d -exec chmod 0700 '{}' \;

# set the permission of this script back to 0700
chmod 0700 $script_path
