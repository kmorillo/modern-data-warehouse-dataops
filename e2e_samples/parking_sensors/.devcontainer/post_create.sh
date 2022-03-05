#!/usr/bin/env bash

echo "Configure az devops cli"
az devops configure --defaults organization="$AZDO_ORGANIZATION_URL" project="$AZDO_PROJECT"

echo "Install requirements depending if devcontainer was openned at root or in parking_sensor folder."

# Assume opened at 'PARKING_SENSORS' folder, the below should work
## pip install -r ./src/ddo_transform/requirements_dev.txt

#if [ -f "../e2e_samples/parking_sensors/src/ddo_transform/requirements_dev.txt" ]; then
#    pip install -r ../e2e_samples/parking_sensors/src/ddo_transform/requirements_dev.txt
#elif [ -f "e2e_samples/parking_sensors/src/ddo_transform/requirements_dev.txt" ]; then
#    pip install -r e2e_samples/parking_sensors/src/ddo_transform/requirements_dev.txt
#fi
