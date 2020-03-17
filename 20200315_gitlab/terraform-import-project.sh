#!/bin/bash
# jq -r '.[].path_with_namespace' projects | awk -F'"' '{print $1}' | awk -F'/' '{print $2}' > list
# created the list file
while read -r var;
do terraform import gitlab_project.${var} username/${var};
done < list