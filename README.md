# crystallix-pages

Small library which helps you to create `.crweb` files which used by Crystallix (https://github.com/De-Os/crystallix)

## Installation

Add this to your `shard.yml`:
```yaml
dependencies:
  mysql-interface:
    github: De-Os/crystallix-pages
```

## Usage

First of all, add `require` and create new `CRYSTALLIX::PAGE`:

```crystal
require "crystallix-pages"

page = CRYSTALLIX::Page.new
```

After that, you can write anything to the page and headers:

```crystal
page.add "<html><head><title>Crystallix page</title></head>"
page.add "<body>It works with <pre>#{`crystal -v`}!</pre></body></html>"
# code...
page.header("Content-Language", "en")
# any other code...
```

After you did all your stuff use `close` to echo contents to `STDOUT`:
```crystal
# after all code
page.close
```

## Building

After you did all tests and ready to go, build your executable with
```bash
crystal build src/my_page.cr --release --progress -o my_page.crweb
```

Make sure you got `.crweb` and use it in Crystallix!

## CGI Variables

You can access CGI Variables using `CRYSTALLIX::variable_name`, like:

```crystal
if CRYSTALLIX::USER_AGENT =~ /chrome/i
  page.add "Hello, Chrome!"
else
  page.add "Hello, browser!"
end
```

Supported variables:

* `CRYSTALLIX::SERVER_NAME`, string
* `CRYSTALLIX::REDIRECT_STATUS`, string
* `CRYSTALLIX::SERVER_PROTOCOL`, string
* `CRYSTALLIX::REQUEST_METHOD`, string, always upcase
* `CRYSTALLIX::QUERY_STRING`, string
* `CRYSTALLIX::REMOTE_ADDR`, string
* `CRYSTALLIX::SERVER_PORT`, integer
* `CRYSTALLIX::CONTENT_TYPE`, string
* `CRYSTALLIX::CONTENT_LENGTH`, integer
* `CRYSTALLIX::USER_AGENT` (`HTTP_USER_AGENT` from CGI), string
* `CRYSTALLIX::ACCEPT` (`HTTP_ACCEPT` from CGI), string
* `CRYSTALLIX::COOKIES` (`HTTP_COOKIES` from CGI), string

## Body

Also, you can get body if POST was used:

```crystal
if CRYSTALLIX::REQUEST_METHOD == "POST"
  page.header("Content-Type", ["text/plain", "charset=utf-8"])
  page.add "Hey, you're using post! That's your body:\n\n"
  page.add CRYSTALLIX::BODY
else
  page.add "Use POST method!"
end
```
