# Stars

Eventually will be an app that collects stars from the people you follow on GitHub in different ways than GitHub.com does. Nothing to see right now though.

## Setup

```
mv .env.example .env
# update .env with github oauth app key and secret
script/bootstrap
bin/rake db:create db:migrate db:test:prepare
script/server
open http://localhost:3000
```
