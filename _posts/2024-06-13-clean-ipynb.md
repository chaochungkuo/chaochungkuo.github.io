---
title: Stripping results from ipynb for committing clean notebook to Github
date: 2024-06-13
categories: [Programming, Python]
tags: [ipynb]  # TAG names should always be lowercase
published: true
---

When you are working on a Github repository with Jupyter Notebooks (ipynb), it is very likely that you only want to track the scripts by git, instead of tracking all the executed results. If you just add/commit/push the ipynb files as how you do normally, you might accidentally upload all the executed results to Github already (such as tables, figures and texts ...etc). Here are some codes to fix this.

## Clean the ipynb

```bash
find . -name "*.ipynb" -exec jupyter nbconvert --clear-output --inplace {} \;
```

## Rebase git commits

If you have to go back to a certain commit and overwrite the current one, here is some examples.

```bash
git rebase -i HEAD~5
find . -name "*.ipynb" -exec jupyter nbconvert --clear-output --inplace {} \;
git add -u
git commit -m "clean ipynb"
git rebase --continue
git status
git push origin main --force
```

These lines let you select the commit you want to rebase, clean ipynb files, finish the rebase and then overwrite the origin/main.
