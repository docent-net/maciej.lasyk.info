#!/usr/bin/env bash

if [ -z "$GCP_SERVICE_ACCOUNT" ]; then
    echo "GCP_SERVICE_ACCOUNT not set; exiting"
    exit
fi

if [ -z "$GCP_PROJECT" ]; then
    echo "GCP_PROJECT not set; exiting"
    exit
fi

GCLOUD=`which gcloud`

if [ -z "$GCLOUD" ]; then
    echo "gcloud not found in the PATH; exiting"
    exit
fi

GSUTIL=`which gsutil`

if [ -z "$GSUTIL" ]; then
    echo "gsutil not found in the PATH; exiting"
    exit
fi

GCP_APIS=(iam.googleapis.com cloudresourcemanager.googleapis.com)
ERR=0
echo -e "\nEnabling APIs in project ${GCP_PROJECT}... wait"
for _API in "${GCP_APIS[@]}"
do
    echo -e "\t${_API}"
    ${GCLOUD} service-management enable ${_API} 1> /dev/null
    if [ "$?" != "0" ]; then
        ERR=1
    fi
done

if [ ${ERR} != "0" ]; then
    echo "Something went wrong with enabling APIs. You'll have to debug.."
    exit
else
    echo "APIs enabled successfully in project ${GCP_PROJECT}."
fi

IAM_ROLES=( roles/compute.admin \
            roles/iam.securityReviewer \
            roles/iam.serviceAccountActor \
            roles/iam.serviceAccountAdmin \
            roles/resourcemanager.projectIamAdmin \
            roles/storage.admin)

ERR=0
echo -e "\nAssigning IAM roles... wait"
for _ROLE in "${IAM_ROLES[@]}"
do
    echo -e "\t${_ROLE}"
    ${GCLOUD} projects add-iam-policy-binding ${GCP_PROJECT} --member "serviceAccount:${GCP_SERVICE_ACCOUNT}" --role "${_ROLE}" 1> /dev/null
    if [ "$?" != "0" ]; then
        ERR=1
    fi
done

if [ ${ERR} != "0" ]; then
    echo "Something went wrong with assigning IAM roles. You'll have to debug.."
    exit
else
    echo "IAM roles assigned successfully to user ${GCP_SERVICE_ACCOUNT} in project ${GCP_PROJECT}"
fi

echo -e "\nAdding WRITE permissions to terraform state bucket... wait"
gsutil acl ch -u ${GCP_SERVICE_ACCOUNT}:W gs://cw-voluum-terraform-states 1> /dev/null
if [ "$?" != "0" ]; then
    echo "Can't assign WRITE permissions for ${GCP_SERVICE_ACCOUNT} on cw-voluum-terraform-states bucket. Please debug."
    exit
else
    echo "WRITE Permissions assigned successfully."
fi