# Ginko
A library to search Japanese banks and branches for Ruby

[![Build Status](https://travis-ci.org/yu123/ginko.png)](https://travis-ci.org/yu123/ginko)

## Renamed
Previously called `ginko`

## Feature
- comprehensive list of Japanese banks and their branches


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ginko'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ginko

## Usage
### search banks
```ruby
Ginko::Bank.search('みつい')
# => [#<Ginko::Bank:0x007fcd9570eb48 @code="0009", @name="三井住友", @name_e="mitsuisumitomo", @name_h="みついすみとも", @name_k="ミツイスミトモ">,
 #<Ginko::Bank:0x007fcd9570ead0 @code="0294", @name="三井住友信託", @name_e="mitsuisumitomoshintaku", @name_h="みついすみともしんたく", @name_k="ミツイスミトモシンタク">,
 #<Ginko::Bank:0x007fcd9570eaa8 @code="3126", @name="みついし農協", @name_e="mitsuishinoukiyou", @name_h="みついしのうきよう", @name_k="ミツイシノウキヨウ">]

```

### find bank
```ruby
Ginko::Bank.find('9900')
# => #<Ginko::Bank:0x007fcd956954c8 @code="9900", @name="ゆうちょ", @name_e="yuuchiyo", @name_h="ゆうちよ", @name_k="ユウチヨ">
```

### search branches
```ruby
bank = Ginko::Bank.find('0009')
bank.branches.search('新宿')
# => [{"code"=>"221", "name"=>"新宿", "name_k"=>"シンジユク", "name_h"=>"しんじゆく", "name_e"=>"shinjiyuku"},{"code"=>"259", "name"=>"新宿西口", "name_k"=>"シンジユクニシグチ", "name_h"=>"しんじゆくにしぐち", "name_e"=>"shinjiyukunishiguchi"},{"code"=>"661", "name"=>"新宿通", "name_k"=>"シンジユクドオリ", "name_h"=>"しんじゆくどおり", "name_e"=>"shinjiyukudoori"}]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yu123/ginko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
