# githubtogitlab
To use this script, follow these steps:

1: Replace the placeholders your_github_username, your_github_access_token, your_gitlab_username, and your_gitlab_access_token with your actual credentials.
2: Save the script to a file, e.g., migrate_repos.sh, and make it executable using chmod +x migrate_repos.sh.
3: Prepare a file, e.g., repos.txt, containing the list of repositories to migrate, with each repository name on a separate line.
4: Run the script using ./migrate_repos.sh repos.txt, providing the repository file as an argument.

The script will read each repository name from the file, migrate it from GitHub to GitLab, and continue with the next repository until all repositories have been migrated.

Make sure to keep your credentials secure and do not share them with anyone.
