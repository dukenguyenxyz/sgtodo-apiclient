# apiclient

[![Build Status](https://travis-ci.org/dukeraphaelng/sgtodo-apiclient.svg?branch=master)](https://travis-ci.org/dukeraphaelng/sgtodo-apiclient)

API Client for Interacting with [Spider-Gazelle To-do API](https://github.com/dukeraphaelng/spider-gazelle-todo)

## Installation

Clone this repository into your directory and `require "__dirname/src/apiclient.cr"`

## Usage

All methods are stored under module Apiclient. All methods are referenced in src/apiclient.cr.

WebMocks are enabled by default in specs. To turn them off to test the live API, please follow instructions to comment and uncomment code detailed in `spec/*`

### Methods

Spider-gazelle To-do API Client supports a single stream and re-uses HTTP connection. To open a stream, simply call `client = Apiclient.open`, the client variable is loaded as the first argument for all `Apiclient` module methods. The methods are listed as below:

- Get this list of all tasks `Apiclient.index(client)`

- Find a single task `Apiclient.show(client, :id)`

- Create a task `Apiclient.create(client, :body)`

- Update a task `Apiclient.update(client, :id, :body)`

- Destroy a task `Apiclient.destroy(client, :id)`

- Destroy all tasks `Apiclient.destroy_all(client)`

When all operations are finished, simply call `client.close` to close the stream

### Params

- Request object

```crystal
id: String
body: {title : String, order : Int32?, completed : Bool}
```

- Response object

```crystal
struct ObjectReponse
  include JSON::Serializable
  getter id : Int32
  getter title : String
  getter order : Int32?
  getter completed : Bool
  getter url : String
end
```

## Contributing

1. Fork it (<https://github.com/your-github-user/apiclient/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Duke Nguyen](https://github.com/dukeraphaelng) - creator and maintainer
