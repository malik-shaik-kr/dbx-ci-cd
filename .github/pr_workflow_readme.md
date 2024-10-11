# Pull Request Workflow Documentation

## Overview of the PR Process

### Explanation of the Workflow

The Pull Request (PR) process is a crucial part of our development workflow, allowing team members to submit changes for review before merging them into the **main** branch. Each PR serves as a formal request to merge code from a feature or bug-fix branch into the main branch.

### Importance of the Main Branch

The main branch is our primary codebase. It contains stable and approved code ready for production. Ensuring that only thoroughly reviewed and tested code enters the main branch is essential for maintaining the quality and reliability of our projects.

## Step-by-Step Guide

### How to Create a PR

1. **Create a Feature Branch**: Before making changes, create a new branch from the **main** branch. Use a descriptive name that reflects the purpose of your changes.
   ```bash
   git pull origin main # To fetch remote changes
   git checkout -b feature/your-feature-name
   ```
2. **Make Your Changes**: Implement the necessary changes in your codebase.
3. **Pull Latest Changes from Main**: Before committing your changes, make sure your branch is up to date with the latest changes from the main branch:
   ```bash
   git pull origin main
   ```
4. **Handle Merge Conflicts**: If there are any merge conflicts after pulling from the main branch, Git will notify you. Follow these steps to resolve conflicts:
   - Open the files with conflicts. Look for conflict markers (e.g., `<<<<<<<`, `=======`, `>>>>>>>`).
   - Manually edit the files to resolve the conflicts.
   - After resolving, stage the changes:
   ```bash
   git add .
   ```
5. **Continue with Commit**: Once all conflicts are resolved and staged, commit your changes with a clear and concise commit message.
   ```bash
   git add .
   git commit -m "Description of changes"
   ```
6. **Push Your Branch**: Push your feature branch to the remote repository.
7. **Open a Pull Request**: Go to the GitHub repository, navigate to the "Pull Requests" tab, and click "New Pull Request." Select your branch and the main branch, then fill out the PR template with details about your changes.

### How to Review and Approve PRs

1. **Review the Code**: Access the PR and review the changes made. Look for code quality, logic errors, and adherence to coding standards.
2. **Leave Comments**: If you have suggestions or concerns, leave comments directly on the lines of code or in the PR discussion.
3. **Approve the PR**: If the changes meet the team's standards, click on the "Approve" button.

### The Process of Merging and Deleting Branches

1.  **Merge the PR**: Once approved, the PR can be merged into the main branch. Click the "Merge" button in the PR interface.
2.  **Delete the Branch**: After merging, you will be prompted to delete the feature branch. Click the "Delete branch" button to remove it from the repository. This helps keep the repository clean and organized.

## Examples

### Sample PR Submission

1.  Create a new branch:
    ```bash
    git checkout -b fix/issue-123
    ```
2.  Implement a fix for issue 123 and commit:
    ```bash
    git commit -m "Fix issue 123 by correcting the calculation logic"
    ```
3.  Pull the latest changes from main:
    ```bash
    git pull origin main
    ```
4.  Push and create a PR:
    ```bash
    git push origin fix/issue-123
    ```
5.  Open a PR on GitHub, describing the changes made.

By following this documentation, new team members should have a clear understanding of our PR process, the importance of the main branch, and how to manage their branches effectively. Welcome to the DQ Team!
