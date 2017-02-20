# LucidReport

Lucid Report allows you to merge Cucumber JSON reports in order to build a unified execution report. This works with Cucumber versions of 2.x and up with results generated in the JSON format.

## Installation

To get the latest stable release, add this line to your application's Gemfile:

```ruby
gem 'lucid_report'
```

To get the latest code:

```ruby
gem 'lucid_report', git: 'https://github.com/jeffnyman/lucid_report'
```

After doing one of the above, execute the following command:

    $ bundle

You can also install Lucid Report just as you would any other gem:

    $ gem install lucid_report

## Usage

You can configure Lucid Report directly from an instance of the class.

```ruby
require 'report_builder'

LucidReport.configure do |config|
  config.json_path = 'results'
  config.report_path = 'execution'
  config.report_types = [:json, :html]
  config.report_tabs = [:overview, :features, :scenarios, :errors]
  config.report_title = 'Test Execution Rport'
  config.compress_images = true
  config.additional_info = {browser: 'chrome', environment: 'staging'}
end

LucidReport.build_report
```

You can also create your own options hash and pass that in to Lucid Report:

```ruby
options = {
   json_path: 'results',
   report_path: 'execution',
   report_types: ['json', 'html'],
   report_tabs:  [ 'overview', 'features', 'scenarios', 'errors'],
   report_title: 'Test Execution Report',
   compress_images: true,
   additional_info: {'browser' => 'chrome', 'environment' => 'staging'}
 }

LucidReport.build_report(options)
```

### Rake Task

This is an experimental part of Lucid Report. You can add in a Rake task that Lucid Report provides:


```ruby
require 'lucid_report'

load 'lucid_report.rake'
```

Then run rake task `lucid_report` as in these examples:

```bash
rake lucid_report
rake lucid_report['results']
rake lucid_report['results', 'lucid-report']
```

The first command would use all of the default options. The second command provides the location where the JSON files are. The third command provides the JSON location as well as the file name of the report you want to generate.

### Options

There are a few options you can use to configure the execution of Lucid Report. To see these at the command line, just do this:

```bash
lucid_report -h
```

#### Parsing JSON

Lucid Report is designed to take JSON output from Cucumber. Thus it needs to know where to find those files. You can do this by using the `-s` (or `source`) switch to provide a directory where the JSON files are. The default will be the current directory. For example:

```bash
lucid_report -s 'results'
```

This would look for any JSON files in the `results` directory. If you wanted to run Lucid Report from within the `results` directory, you could just do this:

```bash
lucid_report
```

Within Lucid Report, the value of the source location is referred to as `json_path` and is either a string or an array. This means you can provide multiple locations or multiple files for the JSON parsing.

#### Output

You can specify where you want the output to be generated. You do this by using the `-o` (or `--out`) switch to provide a file path and a name. Note that the file name you provide should not have an extension.

```bash
lucid_report -s 'results' -o execution-results
```

This command would look for JSON files in a `results` directory and then write its output in whatever the current directory is and call the file `execution-results.html`.

If you don't specify a path or file, a default of `lucid-report.html` will be generated.

Within Lucid Report, the value of the output location is referred to as `report_path` and is a string.

#### Report Format

You can specify the type of format that you want by using the `-f` (or `--format`). This lets you indicate the type of output file you want to build. The default is HTML but you can also specify JSON, which is currently the only other report type supported. You can also specify that you want both types generated.

```bash
lucid_report -s 'results' -f json
```

Within Lucid Report, the value of the report type is referred to as `report_types` and is an array holding the types to build. This can be an array of symbols ([:json, :html]) or an array of strings (['html', 'json']).

#### Report Tabs

You can specify the tabs you want to appear on your report by using the `-t` (or `--tabs`). By default Lucid Report will generate an overview tab and a features tab. You can specify others. The options are currently 'overview', 'features', 'scenarios', 'errors'.

```bash
lucid_report -s 'results' -t overview,features,scenarios,errors
```

Within Lucid Report, the value of the report tabs is referred to as `report_tabs` and is an array that holds the tab names you want generated. This acn be an array of symbols ([:overview, :features, :scenarios, :errors]) or an array of strings (['overview', 'features', 'scenarios', 'errors']).

#### Image Compression

Since test executions can include embedded images, you can specify whether those images should be compressed by using the `-c` (or `--compress`) switch.

```bash
lucid_report -s 'results' -c true
```

You set this value to true to reduce the size of HTML report by compressing any embedded images. Within Lucid Report, this value is referred to as `compress_images` and is a boolean.

#### Report Title

You can specify the title of the report using the `-T` (or `--title`) switch. By default this title will be "Lucid Results".

```bash
lucid_report -s 'results' -T 'Test Report'
```

Within Lucid Report, the value of the title is referred to as `report_title` and is a string.

#### Additional Report Information

You can specify additional information that you want generated as part of the report. You can do this using the `-I` (or `--info`) switch. This must be a key, value bit of information and you can include multiple such key, value pairs.

```bash
lucid_report -s 'results' -I "browser: 'chrome', environment: 'staging"
```

Within Lucid Report, the value of the additional information is stored in `additional_info` and is a hash.

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/jeffnyman/lucid_report](https://github.com/jeffnyman/lucid_report). The testing ecosystem of Ruby is very large and this project is intended to be a welcoming arena for collaboration on yet another test-supporting tool. As such, contributors are very much welcome but are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

The Lucid Report gem follows [semantic versioning](http://semver.org).

To contribute to Lucid Report:

1. [Fork the project](http://gun.io/blog/how-to-github-fork-branch-and-pull-request/).
2. Create your feature branch. (`git checkout -b my-new-feature`)
3. Commit your changes. (`git commit -am 'new feature'`)
4. Push the branch. (`git push origin my-new-feature`)
5. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

## Author

* [Jeff Nyman](http://testerstories.com)

## License

Lucid Report is distributed under the [MIT](http://www.opensource.org/licenses/MIT) license.
See the [LICENSE](https://github.com/jeffnyman/lucid_report/blob/master/LICENSE.md) file for details.
