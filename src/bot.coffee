# Description
#   Complete a task in teamworkpm
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_TEAMWORK_API_KEY
#   HUBOT_TEAMWORK_URL
#   HUBOT_TEAMWORK_DEFAULT_USER
#
# Commands:
#   hubot complete task <id> - completes the task and confirms the status
#   hubot tasks (<user-id>) - lists upcoming tasks (pass in the user id for a specific user, otherwise uses the global user)
#
# Author:
#   ready4god2513

Teamwork = require './teamwork'
config =
  default_user: process.env.HUBOT_TEAMWORK_DEFAULT_USER
  teamwork_url: process.env.HUBOT_TEAMWORK_URL
  teamwork_api_key: process.env.HUBOT_TEAMWORK_API_KEY

module.exports = (robot) ->

  robot.respond /tasks( [0-9]+)?/i, (msg) ->
    msg.send "listing tasks"
    user_id = msg.match[1] or config.default_user
    try
      teamwork = new Teamwork robot, config.teamwork_url, config.teamwork_api_key
      teamwork.listTasks user_id, (str) ->
        msg.send str
    catch e
      msg.send "Error #{e}"

  robot.respond /complete task ([0-9]+)/i, (msg) ->
    try
      teamwork = new Teamwork robot, config.teamwork_url, config.teamwork_api_key
      teamwork.completeTask msg.match[1], (str) ->
        msg.send str
    catch e
      msg.send "Error: #{e}"