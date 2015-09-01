m = require('mochainon')
_ = require('lodash')
Promise = require('bluebird')
logger = require('../lib/logger')
events = require('../lib/events')

describe 'Events:', ->

	describe 'given an empty logger instance', ->

		beforeEach ->
			@loggerGetInstanceStub = m.sinon.stub(logger, 'getInstance')
			@loggerGetInstanceStub.returns(Promise.resolve({}))

		afterEach ->
			@loggerGetInstanceStub.restore()

		describe 'given an event that does not exist', ->

			beforeEach ->
				@event = 'foo.bar.baz'

			it 'should be rejected with an error', ->
				promise = events.send(@event)
				m.chai.expect(promise).to.be.rejectedWith("Event not found: #{@event}")

	describe 'given a single word event that exists', ->

		beforeEach ->
			@loggerSpy = m.sinon.spy()
			@instance = test: @loggerSpy
			@loggerGetInstanceStub = m.sinon.stub(logger, 'getInstance')
			@loggerGetInstanceStub.returns(Promise.resolve(@instance))

		afterEach ->
			@loggerGetInstanceStub.restore()

		describe 'given no options', ->

			it 'should call the event with no arguments', (done) ->
				events.send('test').then =>
					m.chai.expect(@loggerSpy).to.have.been.calledOnce
					m.chai.expect(@loggerSpy).to.have.been.calledWith(undefined, undefined, undefined)
				.nodeify(done)

			it 'should call the event with the correct context', (done) ->
				events.send.call({}, 'test').then =>
					m.chai.expect(@loggerSpy).to.have.been.calledOn(@instance)
				.nodeify(done)

		describe 'given an application id', ->

			it 'should pass the application id as the second argument', (done) ->
				events.send('test', application: 17).then =>
					m.chai.expect(@loggerSpy).to.have.been.calledOnce
					m.chai.expect(@loggerSpy).to.have.been.calledWith(undefined, 17, undefined)
				.nodeify(done)

		describe 'given a device id', ->

			it 'should pass the device id as the third argument', (done) ->
				events.send('test', device: 3).then =>
					m.chai.expect(@loggerSpy).to.have.been.calledOnce
					m.chai.expect(@loggerSpy).to.have.been.calledWith(undefined, undefined, 3)
				.nodeify(done)

		describe 'given random options only', ->

			it 'should pass the custom options as the first argument', (done) ->
				events.send 'test',
					hello: 'world'
					foo: 'bar'
				.then =>
					m.chai.expect(@loggerSpy).to.have.been.calledOnce
					m.chai.expect(@loggerSpy).to.have.been.calledWith
						hello: 'world'
						foo: 'bar'
				.nodeify(done)

		describe 'given application/device ids and extra options', ->

			it 'should pass the arguments correctly', (done) ->
				events.send 'test',
					application: 17
					device: 3
					hello: 'world'
					foo: 'bar'
				.then =>
					m.chai.expect(@loggerSpy).to.have.been.calledOnce
					m.chai.expect(@loggerSpy).to.have.been.calledWith
						hello: 'world'
						foo: 'bar'
					, 17, 3
				.nodeify(done)

	describe 'given a two word event that exists', ->

		beforeEach ->
			@loggerSpy = m.sinon.spy()
			@loggerGetInstanceStub = m.sinon.stub(logger, 'getInstance')
			@loggerGetInstanceStub.returns Promise.resolve
				hello: world: @loggerSpy

		afterEach ->
			@loggerGetInstanceStub.restore()

		it 'should pass the arguments correctly', (done) ->
			events.send 'hello.world',
				application: 17
				device: 3
				hello: 'world'
				foo: 'bar'
			.then =>
				m.chai.expect(@loggerSpy).to.have.been.calledOnce
				m.chai.expect(@loggerSpy).to.have.been.calledWith
					hello: 'world'
					foo: 'bar'
				, 17, 3
			.nodeify(done)

	describe 'given a multiple word event that exists', ->

		beforeEach ->
			@loggerSpy = m.sinon.spy()
			@loggerGetInstanceStub = m.sinon.stub(logger, 'getInstance')
			@loggerGetInstanceStub.returns Promise.resolve
				one: two: three: four: @loggerSpy

		afterEach ->
			@loggerGetInstanceStub.restore()

		it 'should pass the arguments correctly', (done) ->
			events.send 'one.two.three.four',
				application: 17
				device: 3
				hello: 'world'
				foo: 'bar'
			.then =>
				m.chai.expect(@loggerSpy).to.have.been.calledOnce
				m.chai.expect(@loggerSpy).to.have.been.calledWith
					hello: 'world'
					foo: 'bar'
				, 17, 3
			.nodeify(done)
