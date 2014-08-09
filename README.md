# hubot-teamwork

Interact with the teamwork api via your hubot.  Supports listing and completing tasks.

## Commands:
    hubot complete task <id> - completes the task and confirms the status
    hubot tasks (<user-id>) - lists upcoming tasks (pass in the user id for a specific user, otherwise uses the global user)
    
## Configuration:
    HUBOT_TEAMWORK_API_KEY
    HUBOT_TEAMWORK_URL
    HUBOT_TEAMWORK_DEFAULT_USER

### Thanks

Some concepts and ideas taken from https://github.com/jhubert/hubot-tweeter