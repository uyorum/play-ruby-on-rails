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

