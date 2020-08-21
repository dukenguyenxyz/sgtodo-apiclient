require "spec"             # For testing
require "../src/apiclient" # Main code
require "../src/config.cr"
require "../src/constants.cr"

# Posting data body
BODY1 = {"title" => "Commute to work", "completed" => false}

BODY2 = {"title" => "Finish spider-gazelle to do app", "completed" => true}

BODY3 = {"title" => "Go hiking", "completed" => false}

# MOCKING: Comment out the whole following code if you want to disable mocking data and use the live url for testing

require "webmock" # Mocking

# Mock data
returned_body1 = {
  "id":        235,
  "title":     "Commute to work",
  "completed": true,
  "order":     nil,
  "url":       "#{url(235.to_s)}",
}

returned_body2 = {
  "id":        234,
  "title":     "Finish spider-gazelle to do app",
  "completed": true,
  "order":     nil,
  "url":       "#{url(234.to_s)}",
}

returned_body3 = {
  "id":        236,
  "title":     "Go hiking",
  "completed": true,
  "order":     nil,
  "url":       "#{url(236.to_s)}",
}

task_id = returned_body1["id"].to_s

# Set up testing mock
WebMock.stub(:post, url())
  .with(body: BODY1.to_json)
  .to_return(status: 201, body: returned_body1.to_json)

# Mocking configs

# index
WebMock.stub(:get, url())
  .to_return(body: [returned_body1, returned_body2].to_json)

# show
WebMock.stub(:get, url(task_id))
  .to_return(body: returned_body1.to_json)

# destroy_all
WebMock.stub(:delete, url())
  .to_return(body: ({} of String => String).to_json)

# destroy
WebMock.stub(:delete, url(task_id))
  .to_return(body: ({} of String => String).to_json)

# create
WebMock.stub(:post, url())
  .with(body: BODY2.to_json)
  .to_return(status: 201, body: returned_body2.to_json)

# update
WebMock.stub(:patch, url(task_id))
  .to_return(body: returned_body3.to_json)
