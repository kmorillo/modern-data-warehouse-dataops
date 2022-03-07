#!/usr/bin/env bash

#TODO add these to init script with variables
# export AZURE_LOCATION="westus"
# export AZURE_TENANT_ID="b7c4d562-d8f6-47ee-bab9-b9ee602bc6f0"
# export AZDO_PIPELINES_BRANCH_NAME="deploy1"


## Print out all environment variables currently set in dev container
echo "All Environment Variables:"
env -0 | sort -z | tr '\0' '\n'

echo "Configure az devops cli"
az devops configure --defaults organization="$AZDO_ORGANIZATION_URL" project="$AZDO_PROJECT"

echo "Install requirements depending if devcontainer was openned at root or in parking_sensor folder."

{ # try
    az account show --output table
    echo 
} || { # catch
    # Assume opened at 'PARKING_SENSORS' folder, the below should work
    pip install -r ./src/ddo_transform/requirements_dev.txt
    az login --tenant $AZURE_TENANT_ID
    az account list --output table
}
echo 

az account set -n 'VS - Morillo'
az account show --output table

echo 
## az config set defaults.location=westus2 defaults.group=MyResourceGroup
az group list --output table

echo




#git config --global user.email "kevin.morillo@tallan.com"
#git config --global user.name "Kevin Morillo"

./deploy.sh






