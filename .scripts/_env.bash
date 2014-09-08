#!/dev/null

set -e -E -u -o pipefail -o noclobber -o noglob +o braceexpand || exit 1
trap 'printf "[ee] failed: %s\n" "${BASH_COMMAND}" >&2' ERR || exit 1
export -n BASH_ENV

_workbench="$( readlink -e -- . )"
_scripts="${_workbench}/.scripts"
_tools="${pallur_tools:-${_workbench}/.tools}"
_temporary="${pallur_temporary:-${pallur_TMPDIR:-${TMPDIR:-/tmp}}}"

_PATH="${pallur_PATH:-${_tools}/bin:${PATH}}"
_HOME="${pallur_HOME:-${HOME}}"
_TMPDIR="${pallur_TMPDIR:-${TMPDIR:-${_temporary}}}"

_generic_env=(
		PATH="${_PATH}"
		HOME="${_HOME}"
		TMPDIR="${_TMPDIR}"
)

_git_bin="$( PATH="${_PATH}" type -P -- git || true )"
if test -z "${_git_bin}" ; then
	echo "[ww] missing \`git\` (Git DSCV) executable in path: \`${_PATH}\`; ignoring!" >&2
	_git_bin=false
fi

_git_args=()
_git_env=(
		"${_generic_env[@]}"
)
