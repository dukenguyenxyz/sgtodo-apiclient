require "./spec_helper"

describe Apiclient, focus: true do
  task = {} of String => String | Int32 | Bool

  Spec.before_suite {
    Apiclient.destroy_all
    response = Apiclient.create({"title" => "Commute to work", "completed" => false})
    task = JSON.parse(response.body).as_h
  }

  it "should find the task through id" do
    response = Apiclient.show(task["id"])
    response.status_code.should eq(200)
    JSON.parse(response.body).as_h["id"].should eq(task["id"])
  end

  it "should create and update tasks" do
    body = {"title" => "Finish spider-gazelle to do app", "completed" => true}
    response = Apiclient.create(body)
    response.status_code.should eq(201)
    JSON.parse(response.body).as_h["title"].should eq(body["title"])
  end

  it "should return a list of tasks" do
    response = Apiclient.index
    response.status_code.should eq(200)
    JSON.parse(response.body).as_a.size.should eq(2)
  end

  it "should not find the task" do
    response1 = Apiclient.show("1233")
    response1.status_code.should eq(404)

    response2 = Apiclient.destroy("1233")
    response2.status_code.should eq(404)

    body = {"title" => "read Nietzsche's zarathustra"}
    response3 = Apiclient.update("1233", body: body)
    response3.status_code.should eq(404)
  end

  it "should find and destroy a task" do
    response1 = Apiclient.destroy(task["id"])
    response1.status_code.should eq(200)

    response2 = Apiclient.index
    JSON.parse(response2.body).as_a.size.should eq(1)
  end

  it "should destroy all tasks" do
    response1 = Apiclient.destroy_all
    response1.status_code.should eq(200)

    response2 = Apiclient.index
    response2.status_code.should eq(200)
    JSON.parse(response2.body).as_a.size.should eq(0)
  end
end
