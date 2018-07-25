#! /bin/bash

# once sourced by the shell, this script provides two functions:

# gn        to open a file with gnumeric
# gp        to update the file with gnumeric's selection

# requires grep, sed, awk, and the xsel utility


# name of the target file: used in gn () and gp ()
# ==================================================
gn_file=

# take note of target file and open it with gnumeric if not already opened
# ==================================================
gn () {
    # sanity checks
    if [[ -z $1 ]]; then
        echo 'Usage: gn file'
        return
    fi
    if ! [[ -f $1 && -r $1 ]]; then
        echo "Cannot find/use $1"
        return
    fi
    # yes, this is right; job report, if any, has "$gn_file" not expanded
    if jobs -l | grep 'Running.* gnumeric "$gn_file"' > /dev/null; then
        echo 'Already editing with gnumeric.'
        return
    fi
    echo 'Once done, select the part of the spreadsheet you want to save,'
    echo 'press Ctrl-C, go back to the command line, and type gp [ENTER].'
    # do the job
    gn_file=$1
    gnumeric "$gn_file" &
}

# paste selection into target file and close gnumeric
# ==================================================
gp () {
    # sanity checks
    if [[ -z $gn_file || ! -f $gn_file ]]; then
        echo 'Cannot find/use target file.'
        return
    fi
    local gnumeric_job=$( jobs -l | grep 'Running.* gnumeric "$gn_file"' )
    if [[ -z $gnumeric_job ]]; then
        echo 'No gnumeric instance to paste from.'
        return
    fi
    if [[ -z $( xsel -ob ) ]]; then
        echo 'Nothing to paste.'
        return
    fi
    local temp_file=$( mktemp "$PWD/temp.XXXXXX" )
    # paste X selection (o = output, b = clipboard mode)
    xsel -ob > "$temp_file"
    # replace tabs to get a CSV file
    local tab=$'\t'
    sed --in-place "s/$tab/,/g" "$temp_file"
    # must close gnumeric before updating file
    local job_id=$( echo "$gnumeric_job" | awk '{print $2}' )
    kill "$job_id"
    mv --backup "$temp_file" "$gn_file"
    echo "$gn_file updated."
}
