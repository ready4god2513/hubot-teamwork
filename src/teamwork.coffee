class Teamwork

  constructor: (@robot, @baseURL, @key) ->
    this.validateOptions()
    @auth = 'BASIC ' + new Buffer("#{@key}:xxx").toString('base64')

  completeTask: (id, cb) ->
    @robot.http("#{@baseURL}/tasks/#{id}/complete.json")
      .headers(Authorization: @auth)
      .put() (err, res, body) ->
        switch res.statusCode
          when 200
            cb "Great!  Task #{id} was marked complete"
          else
            cb body

  listTasks: (user_id, cb) ->
    baseURL = @baseURL
    @robot.http("#{@baseURL}/tasks.json?filter=anytime&pageSize=10&include=overdue&sort=duedate&responsible-party-ids=#{user_id}")
      .headers(Authorization: @auth)
      .get() (err, res, body) ->
        return cb err if err
        tasks = JSON.parse(body)
        for task in tasks["todo-items"]
          cb "#{task.content} - #{baseURL}/tasks/#{task.id}"


  validateOptions: ->
    unless @key
      throw 'The HUBOT_TEAMWORK_API_KEY must be provided'
    unless @baseURL
      throw 'The HUBOT_TEAMWORK_URL must be provided'

module.exports = Teamwork