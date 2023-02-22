#!/bin/bash

while getopts k:h:s: flag
do
    case "${flag}" in
        k) key=${OPTARG};;
        h) hostname=${OPTARG};;
        s) service=${OPTARG};;
    esac
done

# if [[ -z "$key" || -z "$hostname" || -z "$service" ]]; then
#     printf "\nMissing required parameter.\n"
#     printf "  syntax: deployFiles.sh -k <pem key file> -h <hostname> -s <service>\n\n"
#     exit 1
# fi

printf "\n----> Deploying files for $service to $hostname with $key\n"

# Step 1
printf "\n----> Clear out the previous distribution on the target.\n"
ssh -i /Users/ethanmchls/Desktop/Programming-stuff/cs260/260aws.pem ubuntu@ethanmchls.click << ENDSSH
rm -rf services/simon/public
mkdir -p services/simon/public
ENDSSH

# Step 2
printf "\n----> Copy the distribution package to the target.\n"
scp -r -i /Users/ethanmchls/Desktop/Programming-stuff/cs260/260aws.pem * ubuntu@ethanmchls.click:services/simon/public
