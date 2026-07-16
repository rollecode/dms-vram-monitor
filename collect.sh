#!/bin/sh
# Emits TYPE<TAB>MIB<TAB>PID<TAB>NAME<TAB>DETAIL per line, unsorted.
# P = process (killable), F = free (pinned), U = used, T = total.
# Parses the plain nvidia-smi table rather than --query-compute-apps, which
# omits pure graphics clients (driftwm, Xwayland, electron) and so misses most
# of the used VRAM. Names there are truncated argv, so resolve via comm.

detail_for() {
  _pid=$1
  _comm=$2
  _cmd=$(tr '\0' '\n' < "/proc/$_pid/cmdline" 2>/dev/null)
  [ -z "$_cmd" ] && return

  _t=$(printf '%s\n' "$_cmd" | sed -n 's/^--type=//p' | head -1)
  if [ -n "$_t" ]; then
    printf '%s' "$_t"
    return
  fi

  case "$_comm" in
    python*|node|bun|ruby|perl|java)
      _s=$(printf '%s\n' "$_cmd" | sed -n '2,$p' | grep -v '^-' | head -1)
      [ -n "$_s" ] && printf '%s' "$(basename "$_s")"
      ;;
    claude|bash|sh|zsh|fish|nvim|vim|git)
      _c=$(readlink "/proc/$_pid/cwd" 2>/dev/null)
      [ -n "$_c" ] && printf '%s' "$(basename "$_c")"
      ;;
    WebKitWebProcess|*WebProcess)
      # The webview itself says nothing useful; its parent is what owns it.
      _ppid=$(awk '{print $4}' "/proc/$_pid/stat" 2>/dev/null)
      _p=$(cat "/proc/$_ppid/comm" 2>/dev/null)
      [ -n "$_p" ] && printf 'via %s' "$_p"
      ;;
  esac
}

nvidia-smi 2>/dev/null | awk '
/Processes:/{p=1} !p{next}
/MiB \|/{
  mem=""
  for (i=1;i<=NF;i++) if ($i ~ /MiB$/) { mem=$i; sub("MiB","",mem) }
  if (mem=="" || $5 !~ /^[0-9]+$/) next
  pid=$5
  c=""; f="/proc/" pid "/comm"; getline c < f; close(f)
  if (c=="") c="pid " pid
  printf "%d\t%s\t%s\n", mem, pid, c
}' | while IFS="$(printf '\t')" read -r mem pid name; do
  printf 'P\t%s\t%s\t%s\t%s\n' "$mem" "$pid" "$name" "$(detail_for "$pid" "$name")"
done

nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader,nounits 2>/dev/null | awk -F', ' '
{
  printf "U\t%d\t-\tused\t\n", $1
  printf "F\t%d\t-\tFree\t\n", $2-$1
  printf "T\t%d\t-\ttotal\t\n", $2
}'
