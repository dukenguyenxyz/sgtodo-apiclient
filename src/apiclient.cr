# TODO: Write documentation for `Apiclient`

require "./config.cr"

module Apiclient
  extend self

  VERSION = "0.1.0"

  def index
    HTTP::Client.get(url(), headers())
  end

  def show(todo_id)
    HTTP::Client.get(url(todo_id.to_s), headers())
  end

  def destroy_all
    HTTP::Client.delete(url(), headers())
  end

  def destroy(todo_id)
    HTTP::Client.delete(url(todo_id.to_s), headers())
  end

  def create(body)
    HTTP::Client.post(url(), headers(), body.to_json)
  end

  def update(todo_id, body)
    HTTP::Client.patch(url(todo_id.to_s), headers(), body.to_json)
  end
end
