require "http/client" # require "crest" # Curl lib
require "uri"
require "json"
require "responsible"

require "./constants.cr"

def url(path : String? = nil)
  path.nil? ? App::SERVER_URL : File.join(App::SERVER_URL, path)
end

def todo_path(todo_id : Int32? = nil)
  todo_id.nil? ? "/todos" : "/todos/#{todo_id}"
end

def headers
  head = HTTP::Headers.new
  App::HEADERS.each do |key, value|
    head[key] = value
  end

  head
end

struct ObjectReponse
  include JSON::Serializable
  getter id : Int32
  getter title : String
  getter order : Int32?
  getter completed : Bool
  getter url : String
end
