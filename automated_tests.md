# Automated Tests

Both cucumber and rspec are used, with any code that is common to both frameworks
living in 'test_common'.

Running features in either rspec or cucumber can be done in any registered browser
using the DRIVER environment variable.  This can be set to :-

* rack_test (useful for debugging as you dont get timeouts - but no JS support)
* chrome (real browser using selenium)
* firefox (real browser using selenium)
* phantomjs (fake headless browser using the same browsing engine as chrome - but it is assumed this project will die eventually)

The suite can also be run in either english or welsh.  To change this, set the TEST_LOCALE environment
variable to either 'en' or 'cy'.  Note that if this environment variable is not provided it 
defaults to english (en).

## Persona Based Scenarios

Scenario's can use persona's to define inputs into the test process.
These are defined in test_common/fixtures/personas.yml

and can be access in cucumber features as 

```ruby
personas.fetch(:john)
```


## Messaging

Scenarios can be run in multiple languages, so messaging needs defining for the test
suite in multiple languages.
This uses the same I18n gem that rails uses, but accessed via the 'messaging' helper method
as follows

```ruby
messaging.translate('key', locale: :en)

```


## How To Run The Test

There are two ways to run the tests. The first is to run them on your local environment and the second via Docker.

### Running Tests Locally

First you need to prepare your local environment by following the Installation instructions. After your environment is ready, open your terminal and execute the following commands:

To run the Rspec suite
```
bundle exec parallel_rspec spec
```

To run the Cucumber suite
```
bundle exec parallel_cucumber features
```

### Running Tests Via Docker

Running the tests via docker only requires to install the Docker and Docker Compose tool. Please follow the official instructions to install them in your system. After you have both tools, open your terminal and execute the following commands:

To run the Rspec suite
```
docker-compose -p hwf-calculator up --build rspec-tests
```

To run the Cucumber suite
```
docker-compose -p hwf-calculator up --build cucumber-tests
```
