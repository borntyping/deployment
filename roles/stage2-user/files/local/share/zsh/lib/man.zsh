man() {
    env \
    LESS_TERMCAP_md=$(printf "\e[1;34m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[4;34m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    man "$@"
}
