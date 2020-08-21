require "./spec_helper"

describe Apiclient, focus: true do
  task = Apiclient.create({"title" => "Commute to work", "completed" => false})

  Spec.before_suite {
    Apiclient.destroy_all
    task = Apiclient.create({"title" => "Commute to work", "completed" => false})
  }

  it "should find the task through id" do
    Apiclient.show(task.id).id.should eq(task.id)
  end

  it "should create a task" do
    body = {"title" => "Finish spider-gazelle to do app", "completed" => true}
    Apiclient.create(body).title.should eq(body["title"])
  end

  it "should update a task" do
    body = {"title" => "Go hiking", "completed" => false}
    Apiclient.update(task.id, body).title.should eq(body["title"])
  end

  it "should return a list of tasks" do
    Apiclient.index.size.should eq(2)
  end

  it "should find and destroy a task" do
    Apiclient.destroy(task.id).nil?.should eq(true)
  end

  it "should destroy all tasks" do
    Apiclient.destroy_all.nil?.should eq(true)
  end
end
