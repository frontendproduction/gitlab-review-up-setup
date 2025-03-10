#!/usr/bin/env bash
export ACCESS_KEY='...'
export SECRET_KEY='...'
terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
