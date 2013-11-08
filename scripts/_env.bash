#!/dev/null

set -e -E -u -o pipefail -o noclobber -o noglob +o braceexpand || exit 1
trap 'printf "[ee] failed: %s\n" "${BASH_COMMAND}" >&2' ERR || exit 1
export -n BASH_ENV

_workbench="$( readlink -e -- . )"
_repositories="${_workbench}/repositories"
_scripts="${_workbench}/.scripts"
_tools="${_workbench}/.tools"

_PATH="${_tools}/bin:${PATH}"

_git_bin="$( PATH="${_PATH}" type -P -- git || true )"
if test -z "${_git_bin}" ; then
	echo "[ww] missing \`git\` (Git DSCV) executable in path: \`${_PATH}\`; ignoring!" >&2
	_git_bin=git
fi

_git_args=()
_git_env=()
while read _git_env_var ; do
	_git_env+=( "${_git_env_var}" )
done < <( env )
