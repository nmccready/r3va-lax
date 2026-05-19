---
trigger: always_on
---

# git

When doing agent work the agent shall commit code and push to the git repository regularly. This allows for a historical record of changes, facilitates collaboration, and enables easy rollback if needed. The agent should follow best practices for commit messages, such as being descriptive and concise, to ensure that the history is clear and understandable for all collaborators. Additionally, the agent should ensure that code is properly tested before committing to maintain the integrity of the codebase.

Ideally new work should be done in a new branch, and then merged back to main via pull request. However, for simplicity and speed, the agent may commit directly to main if the changes are small and low-risk. The key is to maintain a clear and organized commit history that reflects the evolution of the project over time.
