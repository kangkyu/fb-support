Common code needed by the other Fb gems
=======================================

Fb::Support provides common functionality to all Fb gems.
It is considered suitable for internal use only at this time.

The **source code** is available on [GitHub](https://github.com/fullscreen/fb-support) and the **documentation** on [RubyDoc](http://www.rubydoc.info/gems/fb-support/frames).

[![Build Status](http://img.shields.io/travis/Fullscreen/fb-support/master.svg)](https://travis-ci.org/Fullscreen/fb-support)
[![Coverage Status](http://img.shields.io/coveralls/Fullscreen/fb-support/master.svg)](https://coveralls.io/r/Fullscreen/fb-support)
[![Dependency Status](http://img.shields.io/gemnasium/Fullscreen/fb-support.svg)](https://gemnasium.com/Fullscreen/fb-support)
[![Code Climate](http://img.shields.io/codeclimate/github/Fullscreen/fb-support.svg)](https://codeclimate.com/github/Fullscreen/fb-support)
[![Online docs](http://img.shields.io/badge/docs-✓-green.svg)](http://www.rubydoc.info/gems/fb-support/frames)
[![Gem Version](http://img.shields.io/gem/v/fb-support.svg)](http://rubygems.org/gems/fb-support)

Fb::Support provides:

* [Fb.configure](http://www.rubydoc.info/gems/fb-support/Fb/Config#configure-instance_method)
* [Fb::Configuration](http://www.rubydoc.info/gems/fb-support/Fb/Configuration)
* [Fb::HTTPRequest](http://www.rubydoc.info/gems/fb-support/Fb/HTTPRequest)
* [Fb::HTTPError](http://www.rubydoc.info/gems/fb-support/Fb/HTTPError)

## Waiting Time

Facebook has [hourly rate limiting](https://developers.facebook.com/docs/graph-api/advanced/rate-limiting/#application-level-rate-limiting). `Fb::HTTPRequest` has `waiting_time` class variable
to sleep the amount of time (in seconds) when it is approaching (with 85% of usage)
in case the variable is set as follows.

```rb
Fb::HTTPRequest.waiting_time = 360
```

How to test
===========

In order to run the tests you need to have one Facebook access token and set
it as an environment variable:

    export FB_TEST_ACCESS_TOKEN="5040|67b895"

There are many [documented ways](https://developers.facebook.com/docs/facebook-login/access-tokens#apptokens) to generate a test access token.
The easiest way is probably to:

- create a Facebook app
- copy its app Id and app Secret
- join them as "app-id|app-secret"… that is a valid access token!


How to contribute
=================

Contribute to the code by forking the project, adding the missing code,
writing the appropriate tests and submitting a pull request.

In order for a PR to be approved, all the tests need to pass and all the public
methods need to be documented and listed in the guides. Remember:

- to run all tests locally: `bundle exec rspec`
- to generate the docs locally: `bundle exec yard`
- to list undocumented methods: `bundle exec yard stats --list-undoc`

Thanks :tada:
