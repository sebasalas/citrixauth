#!/usr/bin/expect
set token_password [lindex $env(TOKEN_PASSWORD) 0]

spawn stoken
expect "Enter password to decrypt token:"
send "$token_password\r"
expect eof
