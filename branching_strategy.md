
# Git Branching Strategy Guide

This guide outlines a safe and professional Git branching workflow suitable for individual developers and teams working in collaborative environments.

---

## Branch Types and Naming

| Branch        | Purpose                         | Naming Example             |
|---------------|----------------------------------|-----------------------------|
| `main`        | Stable, production-ready code    | `main`                      |
| `dev`         | Integration branch (base for features) | `dev`                 |
| `feature/*`   | New feature development          | `feature/azure-rbac`       |
| `hotfix/*`    | Urgent fixes on production       | `hotfix/critical-bug`      |
| `release/*`   | Pre-production staging branches  | `release/v1.2.0`           |

---

## Test a Merge Without Committing

```bash
git checkout feature/my-feature
git merge dev --no-commit --no-ff
```

- If no conflicts: it's safe to proceed.
- If conflicts: review and fix, or abort:

```bash
git merge --abort
```

---

## Updating a Feature Branch Safely

### Standard Flow (Recommended)

```bash
# Save your current changes
git add .
git commit -m "WIP: ongoing changes"

# Switch to dev and update
git checkout dev
git pull origin dev

# Switch to your feature branch and merge dev into it
git checkout feature/my-feature
git merge dev
```

> This preserves history and avoids rewriting commits.

---

## Avoid on Shared Branches

| Action              | Safe on Shared Branches |
|---------------------|-------------------------|
| `git merge`         | Yes                  |
| `git rebase`        | ❌ No (rewrites history) |
| `git push --force`  | ❌ No (can break others) |

---

## Best Practices for Teams

- Never rebase shared branches
- Always pull and merge the `dev` branch into your feature before pushing
- Protect `main` and `dev` branches (require PRs and reviews)
- Use Pull Requests (PRs) for all merges into `dev` and `main`

---

## Summary

- Use `merge` for safety and team compatibility
- Use `--no-commit` to preview merge safety
- Commit and push only after clean merges
- Protect important branches in your Git hosting platform

---

This guide helps ensure a clean, conflict-free workflow in team-based development projects.
