#### Installing
```
bundle install
```

#### Usage (How to find a language)
```
irb
> require './main.rb'
> $database = Database.new('./data.json')
> $database.populate_database
> Search.new($database).find(query: "Microsoft")
> Search.new($database).find(query: "microsoft --compiled --reflective")
> Search.new($database).find(query: "Lisp Common")
> Search.new($database).find(query: 'Interpreted "Thomas Eugene"')
> Search.new($database).find(query: 'john --array')
```
###### For more details add ``` .map(&:to_s) ``` after find

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
