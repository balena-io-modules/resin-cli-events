###
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
###

EventLog = require('resin-event-log')
resin = require('resin-sdk')

###*
# @summary Get event logger instance
# @function
# @protected
#
# @description
# This function contains a configured instance of `resin-event-log`.
# See https://github.com/resin-io/resin-event-log for details.
#
# @fulfil {Object} - logger instance
# @returns {Promise}
#
# @example
# logger.getInstance().then (instance) ->
# 	instance.user.login()
###
exports.getInstance = ->
	resin.models.config.getMixpanelToken().then (token) ->
		return EventLog token, 'CLI',

			beforeCreate: (type, jsonData, applicationId, deviceId, callback) ->
				resin.auth.getUserId().then (userId) =>
					@start(userId, callback)
				.catch(callback)

			afterCreate: (type) ->

				# We do this in the `afterCreate` create hook
				# since this function is called *after* the event
				# is emitted to the backend, therefore we log the
				# corresponding event before closing the session.
				@end() if type is 'User Logout'
