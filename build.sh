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
  count=$(echo "${line}" | awk -F":" '{print NF-1}')
  [[ $count -ne 1 && $count -ne 3 ]] \
    && warn "ERROR: Wrong format!" \
    && echo "Ignoring line ${line_nr}: ${line}" \
    && continue

  name=${line%%:*}

  # skip build for entries where the name does match the first parameter (if present)
  # allowing to build only one dependency at a time.
  [[ $# -ne 0 ]] && [[ $1 != $name ]] && continue

  dest_folder=${line#*:}
  src_folder="${SRC_DIR}/${name}"

  if [ $count -ne 1 ]
    then
      build=${dest_folder#*:}
      build=${build%%:*}
      {
        pushd $src_folder \
          && eval $build \
          && popd
      } || {
        warn "ERROR: Could not evaluate build command" \
          && echo "Ignoring line ${line_nr}: ${line}" \
          && continue
      }
      dist=${dest_folder##*:}
      dest_folder=${dest_folder%%:*}
      src_folder="${src_folder}/${dist}"
  fi

  dest_folder="wp-content/${dest_folder}/${name}"

  cp -rf $src_folder/. $dest_folder \
    || warn "ERROR: Could not copy files for ${name}"

done < "$BUILD_CONF"

popd