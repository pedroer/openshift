#!/bin/bash

# get all projects
projects=$(oc get projects|awk '{print $1}')
host=$(hostname)

for project in $projects
do
  echo "Project: $project"
  oc project $project > /dev/null 2>&1
  
  #Get all Running Pods
  pods=$(oc get pods | grep Running|awk '{print $1}')

  for pod in $pods
  do
    percentages=($(oc exec $pod df|grep -vi use|awk '{print +$5}'))  
    mounts=($(oc exec $pod df|grep -vi use|awk '{print $6}'))

    for index in ${!mounts[*]}; do
        echo "Mount ${mounts[index]}: ${percentages[index]}%"
        if (( ${percentages[index]} > 70 )); then
            message="[ERROR] At $host, Project $project, and Pod $pod the mount ${mounts[index]} is at ${percentages[index]}% of its disk space. Please check this."
            echo $message
	          #echo $message | mail -s "Openshift POD $pod at $host, project $project is out of disk space" "xyz@abcd.com"
        fi
    done
  done
done
