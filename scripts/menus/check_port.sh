#!/bin/sh
# Copyright (C) Juewuy

load_lang check_port

check_port() {
    if [ "$1" -gt 65535 ] || [ "$1" -le 1 ]; then
        msg_alert "\033[31m$CHECK_PORT_RANGE_ERR\033[0m"
        return 1
    elif echo "|$mix_port|$redir_port|$dns_port|$db_port|" | grep -q "|$1|"; then
        msg_alert "\033[31m$CHECK_PORT_DUP_ERR\033[0m"
        return 1
    elif netstat -ntul | grep -q ":$1[[:space:]]"; then
        msg_alert "\033[31m$CHECK_PORT_OCCUPIED_ERR\033[0m"
        return 1
    else
        return 0
    fi
}
