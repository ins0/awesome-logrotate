#!/bin/bash

# _    _                         _
#| |  | |                       (_)
#| |__| | ___ _ __ _ __ ___  ___ _
#|  __  |/ _ \ '__| '_ ` _ \/ __| |
#| |  | |  __/ |  | | | | | \__ \ |
#|_|  |_|\___|_|  |_| |_| |_|___/_|
# https://twitter.com/hermsi_codes

# Define variables
LOGFILE=$1 # Set STDIN as Logfile, use absolute path!
SIZE=10 # Max-size in MB when logfile should get archived
AGE=7 # Max-age in days when logfile should get archived
TIMESTAMP=`date +%Y%m%d` # Define current timestamp
ARCHIVELOG=${LOGFILE}.${TIMESTAMP} # Put logfile and timestamp together for archiving

# Let's see if everything we need is present
function check_command_required() {
	command -v ${1} &>/dev/null
	if [ ${?} -eq 0 ] ; then
		command -v ${1}
	else
		echo "Can not allocate ${1}, which is necessary. Aborting..."
                exit 1
        fi
}

USE_PRINTF=$(check_command_required printf)
        if [ ${?} -eq 1 ] ; then
                $(command -v echo) ${USE_PRINTF}
                exit 1
        fi

USE_FIND=$(check_command_required find)
        if [ ${?} -eq 1 ] ; then
                $(command -v echo) ${USE_FIND}
                exit 1
        fi

USE_CP=$(check_command_required cp)
        if [ ${?} -eq 1 ] ; then
                $(command -v echo) ${USE_CP}
                exit 1
        fi

USE_CAT=$(check_command_required cat)
        if [ ${?} -eq 1 ] ; then
                $(command -v echo) ${USE_CAT}
                exit 1
        fi

USE_GZIP=$(check_command_required gzip)
        if [ ${?} -eq 1 ] ; then
                $(command -v echo) ${USE_GZIP}
                exit 1
        fi

# Check if logfile is present. If false, abort.
if [ ! -f ${LOGFILE} ]; then
  ${USE_PRINTF} "\n%s" "${LOGFILE} can not be allocated, aborting..."
  exit 1
fi

# Check if logfile is larger than desired MB. If true, archive. If false, check age of logfile.
if [[ ! $(${USE_FIND} ${LOGFILE} -type f -size +$(( ${SIZE} * 1024 ))c 2>/dev/null) ]]; then
	if [[ ! $(${USE_FIND} ${LOGFILE} -type f -mtime +${AGE} 2>/dev/null) ]]; then
		${USE_PRINTF} "\n%s\n" "${LOGFILE} has not reached ${SIZE}MB and is not older than ${AGE} Days yet, aborting..."
		exit 1
	else
        	${USE_CP} ${LOGFILE} ${ARCHIVELOG} # Copy Logfile in order to archive it
        	${USE_CAT} /dev/null > ${LOGFILE} # Truncate current logfile
        	${USE_GZIP} -f -9 ${ARCHIVELOG} # Compress archived logfile
	fi
fi
