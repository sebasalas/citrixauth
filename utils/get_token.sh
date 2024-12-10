#!/usr/bin/expect
spawn stoken
expect "Enter password to decrypt token:"
send "password\r"
expect eof

