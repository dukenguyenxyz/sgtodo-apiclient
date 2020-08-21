require "./config.cr"

module Apiclient
  VERSION = "0.1.0"

  extend self

  # Use a single stream
  def open
    HTTP::Client.new(App::SERVER_HOST)
  end

  def index(client)
    ~client.get(todo_path, headers()) >> Array(ObjectReponse)
  end

  def show(client, todo_id)
    ~client.get(todo_path(todo_id), headers()) >> ObjectReponse
  end

  def destroy_all(client)
    ~client.delete(todo_path, headers()) >> Nil
  end

  def destroy(client, todo_id)
    ~client.delete(todo_path(todo_id), headers()) >> Nil
  end

  def create(client, body)
    ~client.post(todo_path, headers(), body.to_json) >> ObjectReponse
  end

  def update(client, todo_id, body)
    ~client.patch(todo_path(todo_id), headers(), body.to_json) >> ObjectReponse
  end
end
