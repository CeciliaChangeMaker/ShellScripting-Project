#!/bin/bash
#####################################

# About: This script is to list the users who have read and write access to my organisation
# input: export "username"
# input: export "Token
# Owner: Cecilia.
# GitHub API URL
API_URL="https://api.github.com"

# GitHub username and personal access token
USERNAME=$username
TOKEN=$token

# Organization information
ORG_NAME="CeciliaTheChangeMakers"

# Function to make a GET request to the GitHub API
function github_api_get {
    local endpoint="$1"
    local url="${API_URL}/${endpoint}"

    # Send a GET request to the GitHub API with authentication
    curl -s -u "${USERNAME}:${TOKEN}" "$url"
}

# Function to list users within the organization
function list_organization_members {
    local endpoint="orgs/${ORG_NAME}/members"

    # Fetch the list of members in the organization
    members="$(github_api_get "$endpoint" | jq -r '.[].login')"

    # Display the list of organization members
    if [[ -z "$members" ]]; then
        echo "No members found for the organization ${ORG_NAME}."
    else
        echo "Members of the organization ${ORG_NAME}:"
        echo "$members"
    fi
}

# Main script

echo "Listing members of the organization ${ORG_NAME}..."
list_organization_members
