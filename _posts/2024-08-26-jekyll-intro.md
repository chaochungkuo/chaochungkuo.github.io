---
title: Introduction to Managing a Jekyll Site with Ruby, Gems, and Bundler
date: 2024-08-26
categories: [Programming, web]
tags: [ruby, gems, jekyll, bundler]  # TAG names should always be lowercase
published: true
---

If you're new to Jekyll and the Ruby ecosystem, managing a Jekyll site along with its dependencies can seem a bit overwhelming. However, once you understand the basics of Ruby, Gems, and Bundler, you'll find it quite manageable. This article will introduce you to these concepts and guide you through managing a Jekyll site.

## What is Ruby?

Ruby is a programming language known for its simplicity and productivity. It is used for building various types of applications, including web applications. Jekyll, a popular static site generator, is written in Ruby.

## What are Gems?

Gems are packages of Ruby code that can be shared and used across different Ruby applications. They add functionality to your project. For example, `jekyll-seo-tag` is a gem that helps enhance your site's SEO metadata.

## What is Bundler?

Bundler is a tool used for managing gem dependencies for Ruby projects. It ensures that the exact versions of gems specified in your project are used and installed. Bundler relies on two main files:

- **`Gemfile`**: Lists the gems your project needs.
- **`Gemfile.lock`**: Records the exact versions of gems installed, ensuring consistency across different environments.

## Setting Up and Managing a Jekyll Site

### 1. Creating a New Jekyll Site

To create a new Jekyll site, run the following commands:

```bash
gem install jekyll bundler
jekyll new my-awesome-site
cd my-awesome-site
```

This installs Jekyll and Bundler, creates a new Jekyll site in the `my-awesome-site` directory, and navigates into that directory.

### 2. Understanding the Gemfile

The `Gemfile`, located in the root directory of your Jekyll site, specifies which gems are needed. Here’s a basic example:

```ruby
source "https://rubygems.org"

gem "jekyll", "~> 4.2.0"
gem "jekyll-sass-converter"
gem "jekyll-seo-tag"
```

- `source "https://rubygems.org"`: Specifies where to find the gems.
- `gem "jekyll", "~> 4.2.0"`: Specifies the Jekyll gem and its version.
- `gem "jekyll-sass-converter"`: Adds support for Sass (CSS preprocessor).
- `gem "jekyll-seo-tag"`: Adds SEO tags to your site.

### 3. Installing Gems

To install the gems listed in your `Gemfile`, run:

```bash
bundle install
```

This command reads your `Gemfile`, resolves dependencies, and installs the gems. It also creates or updates the `Gemfile.lock` file to reflect the exact versions installed.

### 4. Running Your Jekyll Site Locally

To start a local server and view your Jekyll site, use:

```bash
bundle exec jekyll serve
```

- `bundle exec` ensures that the command uses the versions of gems specified in your `Gemfile.lock`.
- `jekyll serve` starts the local server.

Your site will typically be accessible at [http://localhost:4000](http://localhost:4000).

### 5. Updating Gems

To update the gems to their latest versions, modify the `Gemfile` if needed and run:

```bash
bundle update
```

This updates the gems and regenerates the `Gemfile.lock` file.

### 6. Adding New Gems

To add a new gem, such as `jekyll-feed`, update the `Gemfile` like this:

```ruby
gem "jekyll-feed"
```

Then run:

```bash
bundle install
```

This installs the new gem and updates the `Gemfile.lock` file.

## Example Workflow

Here’s a typical workflow for managing a Jekyll site:

1. **Create a New Site**:
   ```bash
   jekyll new my-site
   cd my-site
   ```

2. **Install Gems**:
   ```bash
   bundle install
   ```

3. **Run the Site Locally**:
   ```bash
   bundle exec jekyll serve
   ```

4. **Add or Update Gems**:
   - Modify `Gemfile`.
   - Run `bundle install` or `bundle update`.

5. **Deploy**: Deploy your site to a hosting provider like GitHub Pages.

## Additional Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Bundler Documentation](https://bundler.io/)
- [RubyGems](https://rubygems.org/)

By following these steps, you'll be able to manage your Jekyll site effectively and understand how Ruby, Gems, and Bundler work together. Happy Jekyll-ing!
