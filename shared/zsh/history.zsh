export HISTSIZE=999999999
export HISTFILESIZE=999999999
export SAVEHIST=999999999

# https://qiita.com/sho-t/items/d553dd694900cae0966d
setopt extended_history
setopt hist_allow_clobber
setopt hist_fcntl_lock
setopt hist_find_no_dups 
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
# setopt hist_no_functions
# setopt hist_no_store

setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history_time
