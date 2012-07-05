Simple ETL Excel Format Plugin
==============================

[Simple ETL](https://github.com/nicolaracco/simple_etl) is an easy-to-use toolkit to help you with ETL (Extract Transform Load) operations.

SimpleETL::Excel is a format plugin that will allow you to parse excel files, using the [Spreadsheet](https://github.com/voraz/spreadsheet) gem.

## How to use

Template definition code: :excel

This format is nearly identical to the base definition (described in the [Simple ETL Readme](https://github.com/nicolaracco/simple_etl)).

### Differences from the base definition

By default a template definition will work with the first sheet defined in an .xls file. If you want to change the sheet you can use the _use_sheet_ helper:

```ruby
    use_sheet 3 # => will use the third sheet
```

By default when a sheet is not found, the parser will return an empty set of rows. If you want, you can tell the parser to raise an error if the sheet is not found:

```ruby
    raise_error_on_void_sheet # => #parse will raise a VoidSheetError
```

Each field defined in the template has a 'at' property that describe the field index.

By default the field index will start from 0 and will act as a field counter.

You can set a specific index using the :at attribute.

```ruby
    string  :name         # => at: 0
    string  :surname      # => at: 1

    integer :age,  at: 21 # => at: 21
    integer :sons         # => at: 22
```
