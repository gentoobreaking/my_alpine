#!/bin/bash

Create_EKS_Cluster()
{
echo " - Create an EKS cluster"
eksctl create cluster --region="${AWS_DEFAULT_REGION}" \
--name "${EKS_CLUSTER_NAME}" \
--nodegroup-name "${EKS_CLUSTER_NAME}-nodegrp" \
--node-type "${EKS_NODE_TYPE}" \
--nodes-min "${EKS_NODE_MIN}" \
--nodes-max "${EKS_NODE_MAX}" \
--node-volume-size "${EKS_NODE_VOLUME_SIZE}" \
--ssh-access \
--ssh-public-key ~/.ssh/id_rsa.pub \
--external-dns-access \
--full-ecr-access \
--alb-ingress-access \
--vpc-cidr "${EKS_VPC_CIDR}" \
--vpc-nat-mode HighlyAvailable \
-C true
}

Delete_EKS_Cluster()
{
echo " - Delete an EKS cluster"
eksctl delete cluster --region="${AWS_DEFAULT_REGION}" \
--name "${EKS_CLUSTER_NAME}" \
-C true
}

Test_EKS_cluster()
{
kubectl get nodes
}

Export_Role()
{
echo " - Export the Worker Role Name for use throughout the workshop"

STACK_NAME=$(eksctl get nodegroup --cluster "${EKS_CLUSTER_NAME}" -o json | jq -r '.[].StackName')
INSTANCE_PROFILE_ARN=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} | jq -r '.Stacks[].Outputs[] | select(.OutputKey=="InstanceProfileARN") | .OutputValue')
ROLE_NAME=$(aws cloudformation describe-stacks --stack-name ${STACK_NAME} | jq -r '.Stacks[].Outputs[] | select(.OutputKey=="InstanceRoleARN") | .OutputValue' | cut -f2 -d/)
echo "export ROLE_NAME=${ROLE_NAME}" >> ~/.bash_profile
echo "export INSTANCE_PROFILE_ARN=${INSTANCE_PROFILE_ARN}" >> ~/.bash_profile
cat ~/.bash_profile
}

[ "$1" == "create" ] && Create_EKS_Cluster
[ "$1" == "test" ] && Test_EKS_cluster
[ "$1" == "export" ] && Export_Role
[ "$1" == "delete" ] && Delete_EKS_Cluster
[ "$1" == "" ] && echo " - ./eks_control.sh (create/test/export/delete)"

# --- END --- #
