
/*
Copyright 2016 Resin.io

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
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
