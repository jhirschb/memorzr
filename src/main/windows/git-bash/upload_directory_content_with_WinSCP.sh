#!/usr/bin/env bash
# throttled upload to a ftp server
# script to transfer files from a local pc to a remote for further processing.
# The remote directory is polled by a second application where too many files will cause problems.
# Once all files have been processsed the directory will be renamed with a prefix to mark it as processed.
#
# Usage:
# single run
#   transfer_directory_content.sh xyz
# called in a loop like
#   for f in $(ls -d *); do transfer_directory_content.sh ${f/\//};done


FTPCLIENT="/c/Program Files (x86)/WinSCP/WinSCP.com";
HOST="sftp://<user>:<pass>@<host>";
HOSTKEY="-hostkey=*"; #change this if your environment is insecure
R_DIR="<remote_dir>";
R_WATERMARK=20;
LOCAL_DIR=$1;
PREFIX_DONE="x-";

if [ -z "$LOCAL_DIR" ]; then
    echo "Usage: ./upload_directory_content.sh <directory_name>";
    exit 0;
fi

function transfer {
#    check the remote dir contents and if it is (almost) empty start transfering all (`ls *´) files from the given directory
    R_FILECOUNT=$(${FTPCLIENT} -ini=nul -command "open ${HOST} -hostkey=*" "cd ${R_DIR}" "ls" "exit" | wc -l)
    echo "file count in remote directory: "$R_FILECOUNT;
    
    if [ $R_FILECOUNT -lt $R_WATERMARK ]; then
        echo "continue upload";

        "${FTPCLIENT}" -ini=nul \
        -command "open ${HOST} -hostkey=*" \
        "cd  ${R_DIR}" \
        "lcd $LOCAL_DIR" \
        "put *" \
        "exit";
        mv $LOCAL_DIR $PREFIX_DONE$LOCAL_DIR;
        exit 0;
    else 
        echo "wait for 1 minute";
        sleep 1m;
        transfer;
    fi
}

transfer;
