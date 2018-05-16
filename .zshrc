#
# User configuration sourced by interactive shells
#                                                 
                                                  
# Change default zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
                                        
# Start zim                             
[ -s ${ZIM_HOME}/init.zsh ] && . ${ZIM_HOME}/init.zsh
                                                       
PATH="$HOME/.local/bin:$PATH"
