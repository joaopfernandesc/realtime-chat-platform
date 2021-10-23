# Ruby on Rails: Realtime Chat Platform

## Project Specifications

**Environment**  

- Ruby version: 2.7.1
- Rails version: 6.0.2
- Default Port: 8000

**Commands**
- run: 
```bash
bin/bundle exec rails server --binding 0.0.0.0 --port 8000
```
- install: 
```bash
bin/env_setup && source ~/.rvm/scripts/rvm && rvm --default use 2.7.1 && bin/bundle install
```
- test: 
```bash
RAILS_ENV=test bin/rails db:migrate && RAILS_ENV=test bin/bundle exec rspec
```
    
## Question description

In this challenge, you are part of a team that is building a Realtime Chat Platform. One requirement is for a REST API service to persist and broadcast a message using the Rails framework and ActionCable. You will need to add functionality to add messages to the system as well as broadcast it to the WebSocket stream. The team has come up with a set of requirements including API format, response codes, and data validations.

The definitions and detailed requirements list follow. You will be graded on whether your application performs data processing based on given use cases exactly as described in the requirements.

Each message has the following structure:

- `id`: The unique ID of the message.
- `sender`: The username of the person who sent the message.
- `body`: The content of the message.
- `room`: The name of the chat room.

### Sample message JSON:

```
{
  "id": 1,
  "sender": "username",
  "body": "Hello world",
  "room": "movies"
}
```

## Requirements:

`POST /messages`:
- expects the following payload:
```
{
  "sender": "username",
  "body": "Hello world",
  "room": "movies"
}
```
- performs the following validations:
  - sender is present
  - body is present
  - room is present
- if any of the above validations fail, returns status code 422
- if all validations pass successfully, does the following:
  - adds the given object to the database
  - returns status code 201, and the response body is the JSON of created record, including its id
  - broadcasts a message to the stream `chat_channel_{room}`, where `{room}` is taken from incoming parameters. The message to the stream contains the following data:
  ```
  {
    "id": 1,
    "sender": "username",
    "body": "Hello world",
    "room": "movies"
  }
  ```

`ChatChannel`
- Subscribing to the channel function accepts the `room` parameter. 
- If `room` is present, subscribes to the stream `chat_channel_{room}`
- If `room` is not present, subscribes to the stream `general_chat_channel`
