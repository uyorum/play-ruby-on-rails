# play-ruby-on-rails
Junk source codes about Ruby on Rails

## Introducing RSpec
Base codes is from [uyorum/rails-tutorial](https://github.com/uyorum/rails-tutorial)

## Feature spec with Javascript
Selenium requires geckodriver when usin recent Firefox

``` shell
$ brew install geckodriver
```

Almost skips need wait to finish; not only Javascript but also moving page with `click_link`.
It is better then inserting `sleep` to use `find` or `have_xxx` to wait to finish updating page. It can insert wait by using `have_xxx` in expectation.

(cf. [teamcapybara/capybara: Acceptance test framework for web applications](https://github.com/teamcapybara/capybara#asynchronous-javascript-ajax-and-friends))

## Guard

1. Insert `guard-rspec` in Gemfile
1. `bundle install`
1. `bundle exec guard init rspec`  
    This command generates Guardfile in app root
1. `bundle exec guard`

## Spring
1. Insert `spring-command-rspec` in Gemfile
1. `bundle exec spring binstub rspec`
1. `bin/spring stop`
