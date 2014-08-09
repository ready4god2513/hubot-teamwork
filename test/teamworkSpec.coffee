require 'mocha'
chai = require 'chai'
expect = chai.expect
Teamwork = require './../src/teamwork'
Mitm = require 'mitm'
http = require 'scoped-http-client' # Required by hubot
Robot = require 'hubot/src/robot'
robot = new Robot(null, 'mock-adapter', false, 'teamwork')

baseURL = 'http://test.teamworkpm.com'
key = 'asdf'

describe 'Teamwork', ->

  beforeEach ->
    this.mitm = Mitm()

  afterEach ->
    this.mitm.disable()

  describe '#completeTask', ->

    it 'completes tasks', ->
      id = 123
      teamwork = new Teamwork(robot, baseURL, key)
      this.mitm.on 'request', (req, res) ->
        res.statusCode = 201

      teamwork.completeTask id, (msg) ->
        expect(msg).to.equal("Great!  Task #{id} was marked complete")