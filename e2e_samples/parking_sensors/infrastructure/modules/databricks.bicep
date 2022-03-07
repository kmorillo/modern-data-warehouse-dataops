param project string
@description('The name of the environment. This must be dev, test, or prod.')
@allowed([
  'dev'
  'stg'
  'prod'
])
param env string

@description('The tags to apply to the resource')
param tags object

param location string = resourceGroup().location
param deployment_id string
param contributor_principal_id string
param dbx_tier string = 'trial'



//https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles
var contributor = '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'


resource databricks 'Microsoft.Databricks/workspaces@2018-04-01' = {
  name: '${project}-dbw-${env}-${deployment_id}'
  location: location
  tags: tags
  sku: {
    name: dbx_tier
  }
  properties: {
    managedResourceGroupId: '${subscription().id}/resourceGroups/${project}-dbw-rg-${env}-${deployment_id}'
  }
}

resource databricks_roleassignment 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(databricks.id)
  scope: databricks
  properties: {
    roleDefinitionId: contributor
    principalId: contributor_principal_id
  }
}

output databricks_output object = databricks
output databricks_id string = databricks.id
