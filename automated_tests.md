# Automated Tests

Both cucumber and rspec are used, with any code that is common to both frameworks
living in 'test_common'.

Running features in either rspec or cucumber can be done in any registered browser
using the DRIVER environment variable.  This can be set to :-

o rack_test (useful for debugging as you dont get timeouts - but no JS support)
o chrome (real browser using selenium)
o firefox (real browser using selenium)
o phantomjs (fake headless browser using the same browsing engine as chrome - but it is assumed this project will die eventually)
