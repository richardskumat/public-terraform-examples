#!/bin/bash
# terraform import gitlab_project_variable.example 12345:project_variable_key
while read -r var;
do terraform import gitlab_project_variable."$(echo ${var} | awk -F':' '{print $1}')" username/"$(echo ${var} | awk -F'_' '{print $1}')":"$(echo ${var} | awk -F':' '{print $2}')";
done < repo_vars_sorted