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


resource appinsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: '${project}-appi-${env}-${deployment_id}'
  location: location
  tags: tags
  kind: 'other'
  properties: {
    Application_Type: 'other'
  }
}

output appinsights_name string = appinsights.name
