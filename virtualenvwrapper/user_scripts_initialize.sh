#
# Run user-provided initialization scripts
#
global_script="$WORKON_HOME/initialize"
[ -f "$global_script" ] && source "$global_script"
