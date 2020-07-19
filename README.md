# threebot

Threebot login module for [kemalcr.com](kemalcr.com) applications and for crystal lang in general

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     threebot:
       github: crystaluniverse/kemal-threebot
   ```

2. Run `shards install`

## How to use

##### Download, compile & run 0-db (Backend for BCDB)
- `git clone git@github.com:threefoldtech/0-db.git`
- `cd 0-db && make`
- `./zdb --mode seq`

##### Download, compile & run BCDB (Backend for BCDB)
- Install [Rust programming language](https://www.rust-lang.org/tools/install)
- `git clone git@github.com:threefoldtech/bcdb.git`
- `cd bcdb && make`
- copy bcdb binary anywhere `cp bcdb/target/x86_64-unknown-linux-musl/release/bcdb .`
- download `tfuser` utility from [here](https://github.com/crystaluniverse/bcdb-client/releases/download/v0.1/tfuser)
- use `tfuser` to register your 3bot user to explorer and generate seed file `usr.seed` using `./tfuser id create --name {3bot_username.3bot} --email {email}`
- run bcdb : `./bcdb --seed-file user.seed `
- now you can talk to `bcdb` through http via unix socket `/tmp/bcdb.sock`

##### Export needed environment vars
```
export SEED="sY4dAEWZXsPQEMOHzP65hNeDr4+7D0D6fbEm2In22t0="
export OPEN_KYC_URL=https://openkyc.live/verification/verify-sei
export THREEBOT_LOGIN_URL=https://login.threefold.me
```
##### Usage (Kemal.rc example)

```crystal
require "kemal-session"
require "kemal-session-bcdb"
require "kemal"
require "threebot"

include Threebot

def login(context, email, identifier)
  pp! email
  pp! identifier
end
```
###### notes
- You must include `Threebot` module
- You must provide `def login(context, email, identifier)` method with your login logic, including any redirection after successful login

##### Require and add session settings if not included
```crystal

require "kemal"
require "kemal-session"
require "kemal-session-bcdb"

Kemal::Session.config do |config|
  config.cookie_name = "redis_test"
  config.secret = "a_secret"
  config.engine = Kemal::Session::BcdbEngine.new(unixsocket= "/tmp/bcdb.sock", namespace = "kemal_sessions", key_prefix = "kemal:session:")
  config.timeout = Time::Span.new hours: 200, minutes: 0, seconds: 0
end
```

##### URL to use for 3botligin
- URL to redirect to 3bot login   `{domain}/threebot/login`