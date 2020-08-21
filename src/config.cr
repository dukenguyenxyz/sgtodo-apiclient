require "http/client" # require "crest" # Curl lib
require "json"
require "responsible"

require "./constants.cr"

def url(path : String? = nil)
  !path.nil? ? File.join(App::SERVER_URI, path) : App::SERVER_URI
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
