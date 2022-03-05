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

param keyvault_owner_object_id string
param datafactory_principal_id string


resource keyvault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: '${project}-kv-${env}-${deployment_id}'
  location: location
  tags: tags
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableSoftDelete: false
    enabledForTemplateDeployment: true
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: keyvault_owner_object_id
        permissions: {
            keys: [
                'all'
            ]
            secrets: [
                'all'
            ]
        }
      }
      {
          tenantId: subscription().tenantId
          objectId: datafactory_principal_id
          permissions: {
              secrets: [
                  'get'
                  'list'
              ]
          }
      }
    ]
  }
}

output keyvault_name string = keyvault.name
output keyvault_resource_id string = keyvault.id
