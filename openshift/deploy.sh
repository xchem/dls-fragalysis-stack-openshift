#!/usr/bin/env bash

# It is assumed that the PVs NFS volumes
# have been made available to the OpenShift cluster.

# You will need to be logged into the cluster (master)
# with the oc command set available at the command-line
# and you will need to have logged in as the admin user
# at some point in the past.

echo
echo "+ Creating PVs..."

#oc login -u admin > /dev/null
oc process -f fs-pv-nfs.yaml | oc create -f -
oc process -f fs-graph-pv-nfs.yaml | oc create -f -

echo
echo "+ Creating PVCs..."

oc project fragalysis-cicd > /dev/null

oc process -f ../templates/fs-db-pvc.yaml | oc create -f -
oc process -f ../templates/fs-db-backup-pvc.yaml | oc create -f -
oc process -f ../templates/fs-graph-jun2018-pvc.yaml | oc create -f -
#oc process -f ../templates/fs-cartridge-pvc.yaml | oc create -f -

echo
echo "+ Creating Secrets..."

oc process -f ../templates/fs-secrets.yaml | oc create -f -

echo
echo "+ Deploying Application..."

oc process -f ../templates/fs-graph-jun2018.yaml | oc create -f -
oc process -f ../templates/fs-graph.yaml | oc create -f -
oc process -f ../templates/fs-db.yaml | oc create -f -
#oc process -f ../templates/fs-cartridge.yaml | oc create -f -
oc process -f ../templates/fs-web.yaml | oc create -f -
oc process -f ../templates/fs-db-backup.yaml | oc create -f -
