#!/usr/bin/expect
# Dynamically determine the script's directory
set script_dir [file dirname [file normalize [info script]]]

# Load TOKEN_PASSWORD from config.sh
set token_password [exec sh -c "source $script_dir/config.sh && echo \$TOKEN_PASSWORD"]

# Start stoken and provide the token password
spawn stoken
expect "Enter password to decrypt token:"
send "$token_password\r"
expect eof
