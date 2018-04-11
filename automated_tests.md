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

### Requirements To Run Tests In Docker Containers
The Docker and Docker Compose tool are required to run the tests inside docker containers. Please follow the official instructions to install them in your system.

Windows users will also need to install the [GNU Make](http://gnuwin32.sourceforge.net/packages/make.htm) tool.

### How to run the Security Tests

Open your terminal, change directory to the app's root folder and run:
```
make security-tests
```

That will spin up the zap proxy and the app docker containers, run the tests and export the zap report on your local machine.

### How to run the Spec Tests

Open your terminal, change directory to the app's root folder and run:
```
make spec-tests
```
