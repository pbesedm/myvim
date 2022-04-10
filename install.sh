#!/bin/bash

function check_if_path_is_a_git_repo() {
    local path=$1

    if [ -d "${path}" ]; then
        pushd "${path}" &>/dev/null || return 1
        git rev-parse --is-inside-work-tree
        popd &>/dev/null || return 1
    fi
}

function main() {

    local vimrc_path="$1"

    while read -r line; do
        local repo_local_path
        local github_url
        local if_git_work_tree
        local repo_abs_path="${BUNDLE_ABS_PATH}/${repo_local_path}"
        local ret

        repo_abs_path=$(echo "${line}" | awk '{print $1}' | awk -F'/' '{print $2}')
        github_url=$(echo "${line}" | awk '{print $2}')

        if [ ! -d "${repo_abs_path}" ]; then
            echo "git clone --recursive ${github_url} ${repo_abs_path}"
            git clone --recursive "${github_url}" "${repo_abs_path}"
        else
            if_git_work_tree=$(check_if_path_is_a_git_repo "${repo_abs_path}")
            if [ "${if_git_work_tree}" != "true" ]; then
                rm -rf "${repo_abs_path}"
                echo "fetch git repo failed, git re-clone --recursive ${github_url} ${repo_abs_path}"
                git clone --recursive "${github_url}" "${repo_abs_path}"
            fi
        fi

        ret=$?
        if [ "${ret}" -ne 0 ]; then
            echo -e "\e[31;1m Clone ${github_url} Failed!\e[0m"
        fi

    done < <(grep '^Plugin' "${vimrc_path}" | awk '{print $2}' | awk -F"'" '{print $2}' | awk '{header="https://github.com/";addr=$1;git=".git";url=(header""addr""git);print addr,url}')

    if type clang &>/dev/null; then
        cd YouCompleteMe && ./install.py --clang-completer --go-completer --system-libclang
    else
        cd YouCompleteMe && ./install.py --clang-completer --go-completer
    fi

    ret=$?
    if [[ "${ret}" -ne 0 ]]; then
        echo -e '\e[31;1m YouCompleteMe compile Failed!\e[0m'
        exit 1
    fi
}

ROOTPATH="$(pwd)/myvim"
BUNDLE_ABS_PATH="${ROOTPATH}/vim/bundle"


echo -e '\e[31;1mCloning myvim ...\e[0m'

if [ ! -d myvim ]; then
    git clone --recursive https://github.com/pbesedm/myvim.git
fi

mkdir -p "${BUNDLE_ABS_PATH}" && cd "${BUNDLE_ABS_PATH}" || exit 1

main "${ROOTPATH}/vimrc"

exit 0

cd "${ROOTPATH}" || exit 1
ln -sf "${ROOTPATH}/vimrc" ~/.vimrc
ln -sf "${ROOTPATH}/vim" ~/.vim

echo -e '\e[32;1mInstall myvim Done!\e[0m'
echo -e '\e[32;1mNow run \"sudo pip install --user powerline-status" to support powerline.\e[0m'

exit 0
