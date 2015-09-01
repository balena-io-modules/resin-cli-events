
/*
The MIT License

Copyright (c) 2015 Resin.io, Inc. https://resin.io.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 */
var logger, _;

_ = require('lodash');

logger = require('./logger');


/**
 * @module events
 */


/**
 * @summary Send a CLI event
 * @function
 * @public
 *
 * @description
 * Any extra option apart from `application` and `device` will be sent to the server as extra event data.
 *
 * Consult https://github.com/resin-io/resin-event-log for available events.
 *
 * @param {String} event - event name
 * @param {Object} [options] - event options
 * @param {Number} [options.application] - application id
 * @param {Number} [options.device] - device id
 *
 * @example
 * events.send('application.create', application: 27)
 */

exports.send = function(event, options) {
  if (options == null) {
    options = {};
  }
  return logger.getInstance().then(function(instance) {
    var data, eventAction;
    eventAction = _.get(instance, event);
    if (eventAction == null) {
      throw new Error("Event not found: " + event);
    }
    data = _.omit(options, 'application', 'device');
    if (_.isEmpty(data)) {
      data = void 0;
    }
    return eventAction.call(instance, data, options.application, options.device);
  });
};
