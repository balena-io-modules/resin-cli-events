m = require('mochainon')
_ = require('lodash')
Promise = require('bluebird')
resin = require('resin-sdk-preconfigured')
logger = require('../lib/logger')

describe 'Logger:', ->

	describe '.getInstance()', ->

		describe 'given there is a mixpanel token', ->

			beforeEach ->
				@getMixpanelTokenStub = m.sinon.stub(resin.models.config, 'getMixpanelToken')
				@getMixpanelTokenStub.returns(Promise.resolve('asdf'))

			afterEach ->
				@getMixpanelTokenStub.restore()

			it 'should eventually become an object', (done) ->
				logger.getInstance().then (instance) ->
					m.chai.expect(_.isObject(instance)).to.be.true
				.nodeify(done)
