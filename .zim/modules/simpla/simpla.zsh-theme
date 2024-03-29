# A simple prompt with advanced git features that displays information in a minimal way

_string_reductor() {
  # Take the COLUMNS/6 first characters
  local string=${1:0:$(($COLUMNS / 6))}
  [ "$string" = "$1" ] || string="$string…"
  print "$string"
}

_pwd_reduced() {
  local max_columns=$(($COLUMNS / 6))
  if [ "$1" ] ;then
    local dir_path=${PWD#${1%/*}/*}
  else
    local dir_path=$PWD
  fi
  local dir_path_size=${#dir_path}

  # Path too long, shrink it
  if [ "$1" ]; then
    local repo="${dir_path%%/*}"

    if [ "$repo" = "$dir_path" ] ;then
      print "%U$repo%u"
    elif [ $dir_path_size -gt $max_columns ] ;then
      local half_max_columns=$(($max_columns / 2))
      print "%U${dir_path:0:$half_max_columns}%u…${dir_path:$(($dir_path_size - half_max_columns)):$dir_path_size}"    
    else
      print "%U$repo%u/${dir_path#*/}"    
    fi    
  elif [ $dir_path_size -gt $max_columns ] ;then
    print "…${dir_path:$(($dir_path_size - $max_columns)):$dir_path_size}"
  else
    print "$dir_path"
  fi
}

_git_prompt_info() {
  if [ "$1" ] ;then
    local git_status=$(git status -sb --porcelain=v2)

    # Branch name
    ref=${git_status##*branch.head }
    ref=${ref%%
*}

    # Commits ahead/behind
    branch_ab=${git_status##*\# branch.ab +}
    commits_to_push=${branch_ab%% *}

    commits_to_pull=${branch_ab#*-}
    commits_to_pull=${commits_to_pull%%
*}
    [ $commits_to_push -gt 0 ] 2>/dev/null && commits_to_push=%B%F{cyan}%b$commits_to_push⇑ || commits_to_push=
    [ $commits_to_pull -gt 0 ] 2>/dev/null && commits_to_pull=%B%F{red}%b$commits_to_pull⇓  || commits_to_pull=

    branch=$(_string_reductor "$ref")

    case ${git_status##*
} in
      \#*) print "$commits_to_pull\
$commits_to_push\
%F{green}$branch";;
      *)
        del=
        ins=
        # Only show +/- when stat not empty
        if ! stat=$(git diff --exit-code --shortstat "$ref" -- 2>/dev/null);then
          stat=${stat#*, }
          ins=+${stat% i*}
          stat=${stat##*, }
          del=-${stat% d*}
          
          # Check if there are additions/deletions
          [ "$ins" -eq "$ins" ] 2>/dev/null || ins=
          [ "$del" -eq "$del" ] 2>/dev/null || del=
        fi

        # Parse each status line
        local IFS=$'\n'
        for line in ${=git_status} ;do
          case $line in
            "? "*|1\ [.A-Z][A-Z]\ *) new=$(( new + 1 )) ;;
          esac
          case $line in
            1\ A[A.]\ *) add=$(( add + 1 )) ;;
            1\ R[R.]\ *) rename=$(( rename + 1 )) ;;
            1\ D[D.]\ *) delete=$(( delete + 1 )) ;;
            1\ M[M.]\ *) modify=$(( modify + 1 )) ;;
          esac
        done

        print "\
$commits_to_pull\
$commits_to_push\
%F{white}$new\
%F{green}$add\
%F{blue}$rename\
%F{red}$delete\
%F{magenta}$modify\
%F{yellow}$branch\
%F{green}$ins\
%F{red}$del";;
    esac
  fi
}

prompt_precmd() {
  local git_path
  if git_path=$(git rev-parse --show-toplevel 2>/dev/null) ;then
    local fetch_time=$(stat -c '%Z' $git_path/.git/FETCH_HEAD 2>/dev/null || printf 0)
    # Fetch if not done since more than an hour
    [ $(( ${EPOCHREALTIME%.*} - $fetch_time )) -gt 3600 ] && git fetch --all --tags --prune --prune-tags
  fi

  PROMPT="%(!:%B%F{red}%m:%B%F{green}%m)%f%b %(?:%F{cyan}:%F{magenta})$(_pwd_reduced $git_path)%f "
  RPROMPT="$(_git_prompt_info $git_path)%f"
}

prompt_setup() {
  add-zsh-hook precmd prompt_precmd
}

prompt_setup "$@"
