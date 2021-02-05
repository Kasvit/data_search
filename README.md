#### Installing
```
bundle install
```

#### Usage (How to find a language)
```
irb
> require './main.rb'
> Search.new("Microsoft").result
> Search.new("Microsoft").result
> Search.new("Lisp Common").result
> Search.new('Interpreted "Thomas Eugene"').result
> Search.new("Interpreted 'Thomas Eugene'").result
> Search.new('john --array --test').result
```
###### For more details add ``` .map(&:to_s) ``` after result

#### Testing
```
bundle exec rspec
```
Or
```
rake spec
```
Or
```
guard
```
