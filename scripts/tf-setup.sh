#!/bin/bash

(terraform workspace new dev || terraform workspace select dev)
terraform fmt
