# Help With Fees Calculator

[![Maintainability](https://api.codeclimate.com/v1/badges/77c694c93b7434aec737/maintainability)](https://codeclimate.com/github/ministryofjustice/hwf-calculator/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/77c694c93b7434aec737/test_coverage)](https://codeclimate.com/github/ministryofjustice/hwf-calculator/test_coverage)

This application is the help with fees calculator.

It allows a citizen to establish if they are likely to get help with court or tribunal fees without going through the full application.

## Installation

The project can be run using normal ruby methods or using docker if you are not wanting to install ruby on your machine, or just want to keep things neat and tidy.

The docker solution is generally preferred if you just want to run this, not doing any development work.

If you want to contribute (see contributing guidelines below) then you are going to be a developer so would probably be happier just running it using ruby on your machine.

### Running Via Docker

If you want to get up and running with a production like server on your local machine, see the section below 'Running a production like server locally'

There are many more ways of using docker, even for development and these will be documented below as they are available.

#### Running In Dev Env

There is a docker-compose commands to start a Development environment. Once you have clone the code on your local and you have Docker and Docker compose tool installed, run the following command from the root folder of the app

```
docker-compose -p hwf-calculator up --build web
```

### Running Using Ruby

This project uses RVM (ruby version manager).  If you do not have it, please install it from https://rvm.io

Once RVM is installed, open a terminal window in the directory where you cloned the project and do the following :-

```
    ./bin/setup                         # This will install all dependencies
    bundle exec rake parallel:spec      # This will run the tests in parallel for speed
    bundle exec rails s                 # This wil run the server

```

then in future, just ```bundle exec rails s``` every time you want to run the server.

## Running A Production Like Server Locally

If you are a tester or just anyone that just wants to run the app without
developing on it, a script has been written just for you.  Simply type

```./bin/dev/production_server```

in either a terminal window (linux and OSX) or a 'Docker Quickstart Terminal' (docker toolbox for windows)

and you will have a server running on port 3000 which you can access in your web browser by going to http://localhost:3000.  
**_WINDOWS USERS:_**
In windows you will probably have to setup port forwarding from the 'virtual machine' that docker uses back to your host machine using the port number specified or 3000 if none specified.
Once this is done, you should be able to access from localhost:3000 - if not, you may well have a firewall issue.

If you want to run it on another port, simply set the PORT environment variable first, changing the command to :-

```PORT=4000 ./bin/dev/production_server```

which will do the same, but with port 4000 this time

If you are a windows user, the script is just running ```docker-compose up``` in the 'docker/server' directory, so you can do the same.

## Development

There are no external dependencies outside of the normal bundler requirement, so a simple bundle install will get you going, then its just a normal rails project.

The application has been developed using BDD using both rspec and cucumber.  Generally, the cucumber suite is for the QA team to manage and the rspec suite for developers.

Both can be run in parallel easily as there is no database to worry about etc..  so if you've got a multi core machine this will get the tests to run much quicker.  Use parallel_rspec or parallel_cucumber as required.

The page object pattern is heavily used to prevent our tests being full of capybara type stuff, meaning the tests read much more like plain english and the technical details are nicely wrapped up in page objects.  These page objects are in test_common/page_objects and any shared 'sections' in test_common/sections'

Note that as we have 2 test suites, all code which is common to both is stored in the 'test_common' directory and required as needed by each test suite.

## Design Documentation

[[Click Here]](design_documentation.md)

## Automated Tests

[[Click Here]](automated_tests.md)
