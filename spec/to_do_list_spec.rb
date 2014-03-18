require 'rspec'
require 'to_do_list'
require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
  end
end

describe Task do
  describe 'initialize' do
    it 'initializes the class Task and allows instances of Class' do
      new_task = Task.new('practice SQL in green', 2)
      new_task.should be_an_instance_of Task
    end
    it 'provides you with the task name' do
      new_task = Task.new('practice SQL in green', 2)
      new_task.name.should eq 'practice SQL in green'
    end
  end
  it 'begins with zero tasks' do
    Task.all.should eq []
  end
  it 'allows you to save tasks to the database' do
    new_task = Task.new('practice SQL in green', 2)
    new_task.save
    Task.all.should eq [new_task]
  end
  it 'is the same task if it has the same name' do
    new_task1 = Task.new('practice SQL in green', 2)
    new_task2 = Task.new('practice SQL in green', 2)
    new_task1.should eq new_task2
  end

  it 'provides the name and list ID' do
    new_task = Task.new('buy a green goat', 1)
    new_task.list_id.should eq 1
    new_task.name.should eq 'buy a green goat'
  end
end
