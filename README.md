# Stars

Eventually will be an app that collects stars from the people you follow on GitHub in different ways than GitHub.com does. Nothing to see right now though.

## Setup

```
# setup env file from example, don't forget to update .env with github oauth
# app key and secret
mv .env.example .env

# bundle this bad boy
script/bootstrap

# setup the db for dev and test
bin/rake db:create db:migrate db:test:prepare

# run the server and open in browser
script/server
open http://localhost:3000

# or run the tests
script/test
```
