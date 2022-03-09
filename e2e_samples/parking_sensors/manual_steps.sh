#!/bin/bash

##TODO:
# General
    # Add flag to allow override / drop and recreate all
    # convert from bash to PowerShell scripts
    # Hide sensitive info from logs and output
    # log file instead of console

# Init
# Infra/ARM/Bicep
    # setup rg & vnet first
    # dbx - setup using templates w/ vnet integration https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/vnet-inject#arm-vnet-only
    # dbx - implement sp credentials to generate PAT 
        # curl -X POST -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=client_credentials&client_id=<appid>&resource=https://management.core.windows.net/&client_secret=<secret>" https://login.microsoftonline.com/<tenantid>/oauth2/token
        # then
        # curl -X GET -H "Authorization: Bearer <token>" https://adb-3693162143392221.1.azuredatabricks.net/api/2.0/clusters/list
    # kv - allow enableSoftDelete = false by allowing ignoring if existing key vault exists when running arm deploy
    # sa - allow --overwrite
    # syn - replace dedicated pool with full synapse deploy
# DevOps
    # Add option to skip DevOps pipeline deploy if they exist, or implement upsert.




## Print out all environment variables currently set in dev container
echo "All Environment Variables:"
env -0 | sort -z | tr '\0' '\n'

echo "Configure az devops cli"
az devops configure --defaults organization="$AZDO_ORGANIZATION_URL" project="$AZDO_PROJECT"

echo "Login to Azure"
{ # try
    az account show --output table
    echo 
} || { # catch
    az login --tenant $AZURE_TENANT_ID
    az account list --output table
}
echo 

az account set -n 'VS - Morillo'
az account show --output table

echo 
## az config set defaults.location=westus2 defaults.group=MyResourceGroup
az group list --output table

echo "########################"

#git config --global user.email "kevin.morillo@tallan.com"
#git config --global user.name "Kevin Morillo"

{ #try
    echo "Checking and removing existing purged key vault 'mdwdops-kv-dev-d01km'"
    (az keyvault list-deleted) | grep '"name": "mdwdops-kv-dev-d01km"'
    az keyvault purge -n 'mdwdops-kv-dev-d01km'
} || { #catch
    echo
}

./deploy.sh


# { # try

# } || { # catch

# }



