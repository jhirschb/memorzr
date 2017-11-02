#!/usr/bin/env

#set -e;

# EDIT THIS
DIRECTORIES=(one two three);


# Show Help #
if [ "${1}" = "" ]; then

	echo "#  applyToAll.sh";
	echo "#  usage applyToAll.sh \"<command>\"";
	echo "#  <command> kann ein beliebiges Statement sein. ";
	echo "#  Beispiel: applyToAll.sh \"git checkout develop\"";
	echo "#  Die Anführungszeichen sind wichtig, wenn <command> Leerzeichen enthält";

	exit 0;
fi

# Do it #
current_dir=$(pwd);
COUNT=1;
SIZE=${#DIRECTORIES[@]};

echo "apply ${1} to: ";

for directory in ${DIRECTORIES[@]}; do

	domaindir=${directory};
	if [ -e ${domaindir} ]; then

		printf "| %-3s of %-3s | %s" "${COUNT}" "${SIZE}" "${domaindir}"
		cd $domaindir;

		eval "${1}";
		
		cd ${current_dir};
		
	else
		echo "FEHLER: ${domaindir} existiert nicht! Bitte in das Verzeichnis wechseln in dem die Working Copies liegen.";
		exit 1;
	fi;
	(( COUNT++ ));
done

exit 0;
