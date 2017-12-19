# Design Documentation For Help With Fees Calculator

## Overview

The application is a standard rails 5.1.4 application at the time of writing.

It asks the user for information 1 question at a time, each one being validated before 
moving on to the next.

The calculation service is then responsible for passing each answer on to all
underlying calculators (of which there will be approximately 7 - but at the time
of writing only disposable_income calculator is written).

Any calculator can throw an :abort symbol to stop the chain and say "I've not got enough info yet"

The calculation service knows about all the questions to be answered and in which
order, so can guide the UI to present the correct forms to the user in the correct order.

## External Gems

### active_model_attributes

[Click here for github page](https://github.com/Azdaroth/active_model_attributes)

This gem fills in the gap in active model that rails has not implemented yet.

Rails 5 introduced an attributes API, very similar to what we used to use with virtus.
However, they added the underlying detailed stuff to active model, but the top level
API was only added to active record.

It is expected that in the future, rails will add the same high level API to active model, 
which will mean that this gem can be removed as long as it is implemented in the same
way (which it is expected to be).

