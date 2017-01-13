###
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
###

EventLog = require('resin-event-log')
resin = require('resin-sdk-preconfigured')
token = require('resin-token')
_ = require('lodash')

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
exports.getInstance = _.memoize ->
	resin.models.config.getMixpanelToken().then (mixpanelToken) ->
		return EventLog mixpanelToken, 'CLI',

			beforeCreate: (type, jsonData, applicationId, deviceId, callback) ->
				token.getData().then (user) =>
					@start(user, callback)
				.catch(callback)

			afterCreate: (type) ->

				# We do this in the `afterCreate` create hook
				# since this function is called *after* the event
				# is emitted to the backend, therefore we log the
				# corresponding event before closing the session.
				@end() if type is 'User Logout'
