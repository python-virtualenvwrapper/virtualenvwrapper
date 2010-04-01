#
# Run user-provided initialization scripts
#
global_script="$WORKON_HOME/preinitialize"
[ -f "$global_script" ] && source "$global_script"
