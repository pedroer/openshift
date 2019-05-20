# openshift
Monitoring script for openshift - Disk Usage - Pods

This script is to be used in the "master" node of an openshift cluster.

It lists all Projects, and for each project, all pods, an go inside each pod and get its disk usage.

If its more than 70% it will show a message and can send an email if you need.

Script made following the example of Robs.
http://www.tigrou.nl/2016/04/08/monitor-disk-space-in-your-docker-container/
