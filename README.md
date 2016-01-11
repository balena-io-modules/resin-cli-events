resin-cli-events
----------------

[![npm version](https://badge.fury.io/js/resin-cli-events.svg)](http://badge.fury.io/js/resin-cli-events)
[![dependencies](https://david-dm.org/resin-io/resin-cli-events.png)](https://david-dm.org/resin-io/resin-cli-events.png)
[![Build Status](https://travis-ci.org/resin-io/resin-cli-events.svg?branch=master)](https://travis-ci.org/resin-io/resin-cli-events)
[![Build status](https://ci.appveyor.com/api/projects/status/0txhcryylwxqq4e7?svg=true)](https://ci.appveyor.com/project/resin-io/resin-cli-events)

Join our online chat at [![Gitter chat](https://badges.gitter.im/resin-io/chat.png)](https://gitter.im/resin-io/chat)

Resin.io CLI event client.

Role
----

The intention of this module is to provide an easy interface for the Resin CLI to send analytics.

Installation
------------

Install `resin-cli-events` by running:

```sh
$ npm install --save resin-cli-events
```

Documentation
-------------

<a name="module_events.send"></a>
### events.send(event, [options])
Any extra option apart from `application` and `device` will be sent to the server as extra event data.

Consult https://github.com/resin-io/resin-event-log for available events.

**Kind**: static method of <code>[events](#module_events)</code>  
**Summary**: Send a CLI event  
**Access:** public  

| Param | Type | Description |
| --- | --- | --- |
| event | <code>String</code> | event name |
| [options] | <code>Object</code> | event options |
| [options.application] | <code>Number</code> | application id |
| [options.device] | <code>Number</code> | device id |

**Example**  
```js
events.send('application.create', application: 27)
```

Support
-------

If you're having any problem, please [raise an issue](https://github.com/resin-io/resin-cli-events/issues/new) on GitHub and the Resin.io team will be happy to help.

Tests
-----

Run the test suite by doing:

```sh
$ gulp test
```

Contribute
----------

- Issue Tracker: [github.com/resin-io/resin-cli-events/issues](https://github.com/resin-io/resin-cli-events/issues)
- Source Code: [github.com/resin-io/resin-cli-events](https://github.com/resin-io/resin-cli-events)

Before submitting a PR, please make sure that you include tests, and that [coffeelint](http://www.coffeelint.org/) runs without any warning:

```sh
$ gulp lint
```

License
-------

The project is licensed under the Apache 2.0 license.
