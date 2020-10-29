#!/bin/bash

# consts
WORKDIR="_FR_/"
REPLACEMENT="[YOUR SECRET]"

# args
FILES=$1

git_filter_branch() {
    file=$1
    echo "[git_filter_branch] applying $file";
    
    git filter-branch --force --index-filter \
      "git rm --cached --ignore-unmatch $file" \
      --prune-empty --tag-name-filter cat -- --all
}

replace_file_secrets() {
    file=$1
    echo "[replace_file_secrets] file: $file";

    secrets=( "$@" )
    secrets="${secrets[@]:1}"
    echo "[replace_file_secrets] secrets: $secrets";

    for secret in $secrets
    do
        replace_file_secret $file $secret
    done
}

replace_file_secret() {
    file=$1
    secret=$2

    replaced_file="$file.updated"

    echo "[replace_file_secret] $secret on $file"
    sed -e "s/${secret}/${REPLACEMENT}/g" $file > $replaced_file
    
    cp $replaced_file $file
    rm $replaced_file
}

[ -d "$WORKDIR" ] && rm -R _FR_
mkdir "$WORKDIR"

while IFS= read -r line
do
    IFS=', ' read -r -a array <<< "$line"
    file=${array[0]}
    secrets="${array[@]:1}"

    echo "Working on file: $file"

    filename="$WORKDIR$file"
    dir=$(dirname $filename)
    mkdir -p $dir
    cp $file "$filename"

    git_filter_branch $file
    replace_file_secrets $filename $secrets
done < "$FILES"

cp -R "$WORKDIR/." .

rm -R "$WORKDIR"