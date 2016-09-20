# Pure::Extractor

Gem providing a command line utility for extracting information from the Pure CRIS System to JSON files ready for importing into DMA Online.

## Installation

Install the gem from rubygems:

    $ gem install pure-extractor

## Usage

Provides an executable called `pure-extractor` to extract information from Pure using the Pure WS Rest APIs via [puree](https://github.com/lulibrary/puree).

### Example Usage

With authenticated Pure server

```
pure-extractor -s "http://pure.lancs.ac.uk/ws/rest" -u "username", -p "password" -o "/home/users/output-folder/organisation.json" organisation
```

With unauthenticated Pure server

```
pure-extractor -s "http://pure.lancs.ac.uk/ws/rest" -o "/home/users/output-folder/organisation.json" organisation
```

### Command Line Arguements

In order to support both unauthenticated and authenticated pure servers the username and password arguments are not required.

Generic usage

```
pure-extractor -s SERVER_URL -u USERNAME -p PASSWORD -o OUTPUT_FILE EXTRACT_AREA
```

| Option | Description |
| --- | --- |
| -h, --help | Display the help text explaining how to use the command line utility |
| -o, --output-file | File to output the retrieved data to, when specifying "all" as what to extract this is the directory to place the output files in |
| -s, --server | The URL for the Pure WS Rest service including protocol eg. `http://pure.lancs.ac.uk/ws/rest` |
| -u, --username | Username for the Pure WS Rest service, not required if Pure WS requests are unauthenticated |
| -p, --password | Password for the Pure WS Rest service, not required if Pure WS requests are unauthenticated |

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pure-extractor.

