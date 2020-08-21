require "./spec_helper"

describe Apiclient, focus: true do
  task = Apiclient.create(BODY1)

  Spec.before_suite {
    # # Uncomment to disable webmock for live test
    # Apiclient.destroy_all
    # task = Apiclient.create(BODY1)
  }

  it "should find the task through id" do
    Apiclient.show(task.id).id.should eq(task.id)
  end

  it "should create a task" do
    Apiclient.create(BODY2).title.should eq(BODY2["title"])
  end

  it "should update a task" do
    Apiclient.update(task.id, BODY3).title.should eq(BODY3["title"])
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
