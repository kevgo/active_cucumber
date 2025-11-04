# Changelog

## 1.1.0 (2025-11-04)

- Update required Ruby version to >= 3.2
- Use modern Ruby features
- More careful meta programming
- More explicit return values

## 1.0.0 (2016-05-10)

- stable release

## 0.2.1 (2015-09-01)

- Update dependencies

## 0.2.0 (2015-08-31)

- Add `attributes_for` method to parse Cucumber tables into attribute hashes

## 0.1.0 (2015-08-30)

- Can compare objects in addition to AREL relations

## 0.0.10 (2015-08-29)

- Add context support to Cucumberators

## 0.0.9 (2015-08-28)

- Sort table entries by id

## 0.0.8 (2015-08-27)

- nil columns for association fields now work for factories that would make that
  association by default

## 0.0.7 (2015-08-26)

- Context support for creators

## 0.0.6 (2015-08-25)

- Require FactoryGirl explicitly

## 0.0.5 (2015-08-24)

- Include FactoryGirl methods

## 0.0.4 (2015-08-23)

- Rename creator to active_record_builder

## 0.0.3 (2015-08-22)

- `create_many` now returns the created records
- Remove database indexes for speed improvements
- Better error logging

## 0.0.2 (2015-08-21)

- Add `create_one` method

## 0.0.1 (2015-08-20)

- Core functionality for creating ActiveRecord objects from Cucumber tables
- Support for comparing ActiveRecord objects against Cucumber tables
- `diff_one!` for vertical table comparisons
- `diff_all!` for horizontal table comparisons
- Creator classes for transforming Cucumber table values
- Cucumberator classes for decorating ActiveRecord instances
- FactoryBot integration
