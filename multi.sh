#!/bin/bash

# 1.Process Management
# Function to list all running processes
list_processes() {
    ps -eo pid,user,%mem
}


# Function to kill a process by PID
kill_process() {
    read -p "Enter the PID of the process to kill: " pid
    kill -9 $pid && echo "Process $pid killed." || echo "Failed to kill process $pid."
}


# Function to monitor system load
monitor_load() {
    top
}

# 2.Disk Management
# Function to view disk usage
view_disk_usage() {
    df -h
}

# Function to view disk free space
view_disk_free_space() {
    df -h --output=avail
}

# Function to manage partitions (list partitions)
manage_partitions() {
    lsblk 
}

#3.File Management
# Function to search for files
search_files() {
    read -p "Enter the directory to search in: " directory
    read -p "Enter the filename to search for: " filename
    find $directory -name "$filename"
}

# Function to create a file or directory
create_file_or_dir() {
    read -p "Enter the full path of the file or directory to create: " path
    if [[ $path == */ ]]; then
        mkdir -p "$path" && echo "Directory $path created."
    else
        touch "$path" && echo "File $path created."
    fi
}

# Function to delete a file or directory
delete_file_or_dir() {
    read -p "Enter the full path of the file or directory to delete: " path
    rm -rf "$path" && echo "Deleted $path."
}

# Function to rename a file or directory
rename_file_or_dir() {
    read -p "Enter the current path: " current_path
    read -p "Enter the new path: " new_path
    mv "$current_path" "$new_path" && echo "Renamed $current_path to $new_path."
}

# Function to backup files or directories
backup_files() {
    read -p "Enter the path of the file or directory to backup: " source
    read -p "Enter the destination path: " destination
    cp -r "$source" "$destination" && echo "Backup of $source completed."
}



#4.User Management
# Function to list all users
list_users() {
    cut -d: -f1 /etc/passwd
}

# Function to add a new user
add_user() {
    read -p "Enter the new username: " username
    read -p "Enter the home directory (leave blank for default): " home_dir
    if [ -z "$home_dir" ]; then
        sudo useradd $username
    else
        sudo useradd -m -d $home_dir $username
    fi
    echo "User $username added."
}

# Function to delete a user
delete_user() {
    read -p "Enter the username to delete: " username
    sudo userdel -r $username && echo "User $username deleted."
}

# Function to change user password
change_password() {
    read -p "Enter the username to change the password: " username
    sudo passwd $username
}

#5.System Information
# Function to display system uptime
display_uptime() {
    uptime -p
}

# Function to display memory usage
display_memory_usage() {
    free -h
}

#6.Help Menu
# Function to display the help menu
display_help() {
    echo "Usage: $0 [option]"
    echo "Options:"
    echo "  --list-processes             List all running processes"
    echo "  --kill-process               Kill a process by PID"
    echo "  --monitor-load               Monitor system load"
    echo "  --view-disk-usage            View disk usage"
    echo "  --view-disk-free-space       View available disk space"
    echo "  --manage-partitions          List disk partitions"
    echo "  --search-files               Search for files by name"
    echo "  --create-file-or-dir         Create a file or directory"
    echo "  --delete-file-or-dir         Delete a file or directory"
    echo "  --rename-file-or-dir         Rename a file or directory"
    echo "  --backup-files               Backup files or directories"
    echo "  --list-users                 List all users"
    echo "  --add-user                   Add a new user"
    echo "  --delete-user                Delete a user"
    echo "  --change-password            Change user password"
    echo "  --display-uptime             Display system uptime"
    echo "  --display-memory-usage       Display memory usage"
    echo "  --help, -h                   Display this help message"
}

case $1 in
    --list-processes)
        list_processes
        ;;
    --kill-process)
        kill_process
        ;;
    --monitor-load)
        monitor_load
        ;;
    --view-disk-usage)
        view_disk_usage
        ;;
    --view-disk-free-space)
        view_disk_free_space
        ;;
    --manage-partitions)
        manage_partitions
        ;;
    --search-files)
        search_files
        ;;
    --create-file-or-dir)
        create_file_or_dir
        ;;
    --delete-file-or-dir)
        delete_file_or_dir
        ;;
    --rename-file-or-dir)
        rename_file_or_dir
        ;;
    --backup-files)
        backup_files
        ;;
    --list-users)
        list_users
        ;;
    --add-user)
        add_user
        ;;
    --delete-user)
        delete_user
        ;;
    --change-password)
        change_password
        ;;
    --display-uptime)
        display_uptime
        ;;
    --display-memory-usage)
        display_memory_usage
        ;;
    --help | -h)
        display_help
        ;;
    *)
        echo "Invalid option. Use --help or -h for usage information."
        exit 1
        ;;
esac

