# KRM's website

A repository for my personal website, built by [Jekyll](https://jekyllrb.com) and running on [GitHub Pages](https://pages.github.com).

Check out out at https://kalebmckone.com.

## Building

To build the site, you need Ruby and several other dependencies. Follow the guide for your system
at [the Jekyll docs](https://jekyllrb.com/docs/).

The following is what I do on my systems (Ubuntu 18.04, zsh)

1. `sudo apt-get install ruby-full build-essential zlib1g-dev`
2. `echo '# Install Ruby Gems to ~/gems' >> ~/.zshrc`
3. `echo 'export GEM_HOME="$HOME/gems"' >> ~/.zshrc`
3. `echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.zshrc`
4. `source ~/.zshrc`

Test your installation of dependencies that Jekyll relies on by running `bundle exec jekyll serve`
in a Jekyll project. If you receive an error such as `Could not find i18n-0.9.5 in any of the sources`, you might need to run a `bundle install` to complete the missing dependencies.