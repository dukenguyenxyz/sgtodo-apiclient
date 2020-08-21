require "spec"    # For testing
require "webmock" # For mocking

require "../src/apiclient" # Main code

# Mocking
require "../src/config.cr"
require "../src/constants.cr"

# Mock data
BODY1 = {"title" => "Commute to work", "completed" => false}
returned_body1 = {
  "id":        235,
  "title":     "Commute to work",
  "completed": true,
  "order":     nil,
  "url":       "#{App::SERVER_URI}/235",
}

BODY2 = {"title" => "Finish spider-gazelle to do app", "completed" => true}
returned_body2 = {
  "id":        234,
  "title":     "Finish spider-gazelle to do app",
  "completed": true,
  "order":     nil,
  "url":       "#{App::SERVER_URI}/234",
}

BODY3 = {"title" => "Go hiking", "completed" => false}
returned_body3 = {
  "id":        236,
  "title":     "Go hiking",
  "completed": true,
  "order":     nil,
  "url":       "#{App::SERVER_URI}/236",
}

task_id = returned_body1["id"].to_s

# Set up testing mock
WebMock.stub(:post, "#{App::SERVER_URI}")
  .with(body: BODY1.to_json)
  .to_return(status: 201, body: returned_body1.to_json)

# Mocking configs

# index
WebMock.stub(:get, "#{App::SERVER_URI}")
  .to_return(body: [returned_body1, returned_body2].to_json)

# show
WebMock.stub(:get, "#{App::SERVER_URI}/#{task_id}")
  .to_return(body: returned_body1.to_json)

# destroy_all
WebMock.stub(:delete, "#{App::SERVER_URI}")
  .to_return(body: ({} of String => String).to_json)

# destroy
WebMock.stub(:delete, "#{App::SERVER_URI}/#{task_id}")
  .to_return(body: ({} of String => String).to_json)

# create
WebMock.stub(:post, "#{App::SERVER_URI}")
  .with(body: BODY2.to_json)
  .to_return(status: 201, body: returned_body2.to_json)

# update
WebMock.stub(:patch, "#{App::SERVER_URI}/#{task_id}")
  .to_return(body: returned_body3.to_json)
