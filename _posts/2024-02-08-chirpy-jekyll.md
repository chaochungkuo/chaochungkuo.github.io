---
title: My setting for Jekyll site with Chirpy theme as a GitHub Page
date: 2024-02-08
categories: [Programming, web]
tags: [jekyll, chirpy, disqus]     # TAG names should always be lowercase
published: true
---

Here I want to share and record the configuration of this Jekyll site. Here are the main steps:

1. Fork the chirpy repo to as my own repo on GitHub.
   - Fork this repo: [https://github.com/cotes2020/jekyll-theme-chirpy](https://github.com/cotes2020/jekyll-theme-chirpy)
   - Read more about this theme: [https://chirpy.cotes.page/](https://chirpy.cotes.page/)
2. Rename this repo as *GitHubUserName*.github.io
3. Customize *_config.yml* file
4. Add images and favicons
5. Add pages under _tabs
6. Add posts under _posts
7. Activate GitHub page in Settings > Pages
8. Configure [Disqus](https://disqus.com/) for commenting
   - Activate disqus in *_config.yml*

Deploy the site locally:

```shell
bundle exec jekyll serve
```
