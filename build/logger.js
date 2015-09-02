
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
var EventLog, resin, token;

EventLog = require('resin-event-log');

resin = require('resin-sdk');

token = require('resin-token');


/**
 * @summary Get event logger instance
 * @function
 * @protected
 *
 * @description
 * This function contains a configured instance of `resin-event-log`.
 * See https://github.com/resin-io/resin-event-log for details.
 *
 * @fulfil {Object} - logger instance
 * @returns {Promise}
 *
 * @example
 * logger.getInstance().then (instance) ->
 * 	instance.user.login()
 */

exports.getInstance = function() {
  return resin.models.config.getMixpanelToken().then(function(mixpanelToken) {
    return EventLog(mixpanelToken, 'CLI', {
      beforeCreate: function(type, jsonData, applicationId, deviceId, callback) {
        return token.getData().then((function(_this) {
          return function(user) {
            return _this.start(user, callback);
          };
        })(this))["catch"](callback);
      },
      afterCreate: function(type) {
        if (type === 'User Logout') {
          return this.end();
        }
      }
    });
  });
};
