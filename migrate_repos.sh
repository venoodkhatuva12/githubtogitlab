#!/bin/bash

# Set your GitHub and GitLab credentials
GITHUB_USERNAME="your_github_username"
GITHUB_ACCESS_TOKEN="your_github_access_token"
GITLAB_USERNAME="your_gitlab_username"
GITLAB_ACCESS_TOKEN="your_gitlab_access_token"

# Set the source GitHub and destination GitLab URLs
GITHUB_API="https://api.github.com"
GITLAB_API="https://gitlab.com/api/v4"

# Function to create a repository in GitLab
create_gitlab_repo() {
    local repo_name=$1
    local visibility=$2

    curl --header "PRIVATE-TOKEN: ${GITLAB_ACCESS_TOKEN}" --data "name=${repo_name}&visibility=${visibility}" "${GITLAB_API}/projects"
}

# Function to migrate a single repository
migrate_repository() {
    local repo_name=$1

    # Clone the repository from GitHub
    git clone --mirror "https://github.com/${GITHUB_USERNAME}/${repo_name}.git"
    cd "${repo_name}.git"

    # Create a repository in GitLab
    create_gitlab_repo "${repo_name}" "private"

    # Push the repository with all branches and tags to GitLab
    git push --mirror "https://gitlab.com/${GITLAB_USERNAME}/${repo_name}.git"

    cd ..
    rm -rf "${repo_name}.git"
}

# Read the list of repositories from the file
repo_file="$1"
if [ -z "$repo_file" ]; then
    echo "Please provide a file containing the list of repositories."
    exit 1
fi

if [ ! -f "$repo_file" ]; then
    echo "File $repo_file not found."
    exit 1
fi

# Migrate each repository from the file
while IFS= read -r repo; do
    migrate_repository "$repo"
done < "$repo_file"
