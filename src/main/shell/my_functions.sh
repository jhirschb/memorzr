#!/bin/bash
#
# source this in your .bash_profile.sh to provide some usefull helpers
#

function git_latest {
	echo "Benutzung: git_latest <tag-name>";
	PATTERN=${1};
	echo "lade den neuesten Stand vom upstream...";
	git fetch;
	
	echo "suche das neueste git Tag mit dem Pattern: ${PATTERN}";
	TAG=`git tag -l "${PATTERN}*" --sort=-taggerdate | head -n 1`;
	 
	echo "das neueste Tag ist: "
	echo "   "${TAG};
}

