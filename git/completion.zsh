# Set up completion for scripts in git/bin.
local -a user_commands
local user_command

# * = executable files
# N = ignore no matches
for user_command in ${0%/*}/bin/git-*(*N); do
  local name="$(basename "$user_command")"

  # If there is a completion function it likely has a #description in the second
  # line and is picked up automatically.
  (( $+functions[_$name] )) && continue

  name="${name#git-}"
  name="${name%.*}"
  user_commands+=($name:"run $user_command")
done

zstyle ':completion:*:*:git:*' user-commands $user_commands
