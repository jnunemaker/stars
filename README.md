# Stars

Collects github.com stars from people you follow. Not much to see right now though.

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
