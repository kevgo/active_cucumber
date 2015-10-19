# ActiveCucumber [![Circle CI](https://circleci.com/gh/Originate/active_cucumber.svg?style=shield)](https://circleci.com/gh/Originate/active_cucumber)

High-level Cucumber helpers for testing
[ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html)-based
database applications using Cucumber tables.


## Verifying database records

ActiveCucumber allows to compare ActiveRecord objects
against Cucumber tables,
with the differences visualized intuitively as a Cucumber table diff.
Only the attributes provided in the table are compared,
the ones not listed are ignored.


### diff_one!

`ActiveCucumber.diff_one!` compares the given ActiveRecord entry with the given
_vertical_ Cucumber table.
These tables have their headers on the left side, and are used to describe
a single record in greater detail.

```cucumber
When loading the last Star Trek TNG episode
Then it returns this episode:
  | SHOW | Star Trek TNG   |
  | NAME | All Good Things |
  | YEAR | 1994            |
```

The `Then` step is easy to implement with ActiveCucumber:

```ruby
Then /^it returns this episode:$/ do |table|
  # @episode contains one loaded entry
  ActiveCucumber.diff_one! @episode, table
end
```


### diff_all!

`ActiveCucumber.diff_all!` verifies that the given _horizontal_ Cucumber table
describes all existing database entries of the given class.
Horizontal Cucumber tables have their headers on top, and define several
records at once:

```cucumber
When I run the importer script with parameter "count=3"
Then the database contains these episodes:
  | SHOW          | NAME                  | YEAR |
  | Star Trek TNG | Encounter at Farpoint | 1987 |
  | Star Trek TNG | The Nth Degree        | 1991 |
  | Star Trek TNG | All Good Things       | 1994 |
```

The last step would be implemented as:

```ruby
Then /^Then the database contains these episodes:$/ do |table|
  ActiveCucumber.diff_all! Episode, table
end
```

The Cucumber table should list the entries sorted by `created_at` timestamp.


### Cucumberators

ActiveCucumber converts the database records into a data table
and matches it against the given Cucumber table.

By default, all attributes are converted into a String.
It is possible to customize this conversion step by creating a
_Cucumberator_ (short for Cucumber Decorator).
This class decorates an ActiveRecord instance, and defines converters
for attribute values into the format used in the Cucumber table.

```ruby
class EpisodeCucumberator < Cucumberator

  # In the SHOW column, print the name of the show of the episode truncated
  def value_of_show
    show.name.truncate 10
  end

end
```

ActiveCucumber automatically finds and uses these Cucumberators if this
naming convention is followed.
