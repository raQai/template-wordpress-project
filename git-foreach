#!/bin/bash

source script.conf
source script.utils

SCRIPT_SOURCE=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
pushd $SCRIPT_SOURCE

line_nr=0

while read -r line || [[ -n "$line" ]]
do
  ((++line_nr))

  # skip comments and empty lines
  is_comment_or_empty $line && continue

  name=${line%%:*}
  repository=${line#*:}
  folder="${SRC_DIR}/${name}"

  # wrong format
  [[ $line != *":"* ]] || [[ -z $name ]] || [[ -z $repository ]] \
    && warn "ERROR: Wrong format!" \
    && echo "Ignoring line ${line_nr}: ${line}" \
    && echo "See README for documentation." \
    && continue

  # check if folder exists, if not clone
  [[ ! -d $folder ]] && git clone $repository $folder

  [[ ! -d $folder ]] \
    && warn "ERROR: Source folder '${folder}' does not exist." \
    && echo "There might have been an error cloning the repository '${repository}'" \
    && echo "Ignoring line ${line_nr}: ${line}" \
    && continue

  [[ $# -eq 0 ]] && continue

  pushd $folder

  info "${name}: git ${@}"
  git "$@"

  popd

done < "$REPOSITORIES_CONF"

popd