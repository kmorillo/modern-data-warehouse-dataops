## To run locally, first connect to Azure
$ErrorActionPreference = 'Stop'
$subscriptionName = "Dev Playground"  # 'Concierge Subscription' 
$tenantId = "b7c4d562-d8f6-47ee-bab9-b9ee602bc6f0" # Tallan
$defaultResourceGroupName = "rg-kevin-morillo-dev-001"

# $bicepTemplateFile = "main.bicep"
# $bicepParameterFile = "main.parameters.dev.json"
# $doDeploy = $false
# $doPostDeploy = $false

Write-Output "Running script..."
$loc = $PSScriptRoot
Write-Host "Setting current directory to $loc"
Set-Location $loc


#######################################################################################################################
# Functions
#######################################################################################################################

function DoLoginToAzure(){
    Write-Output "Get context..."
    $context = Get-AzContext

    if($null -eq $context){
        $acct = Connect-AzAccount -Tenant $tenantId
        $context = $acct.Context
    }
    
    if($context.Tenant.Id -ne $tenantId -or $context.Subscription.Name -ne $subscriptionName){
        $context = Set-AzContext -Tenant $tenantId -SubscriptionName $subscriptionName
    }
    
    if($null -ne $defaultResourceGroupName -and $defaultResourceGroupName -ne ""){
        Write-Output "Setting default resource group..."
        Set-AzDefault -ResourceGroupName $defaultResourceGroupName
    }else{
        Write-Output "Getting default resource group name..."
        Get-AzDefault -ResourceGroup
    }
}

#######################################################################################################################
# Main
#######################################################################################################################


#DoLoginToAzure

