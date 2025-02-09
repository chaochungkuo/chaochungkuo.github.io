{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.ruby
    pkgs.bundler
    pkgs.jekyll
    pkgs.nodejs  # If your Jekyll project uses JS dependencies
  ];
}

# nix-shell
# bundle install
# bundle exec jekyll serve
