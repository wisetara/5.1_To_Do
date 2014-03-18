require 'pg'

DB = PG.connect({:dbname => 'to_do_test'})

class Task

  attr_reader :task_name, :all

  def initialize(task_name, list_id)
    @task_name = task_name
    @list_id = list_id
  end

  def name
    @task_name
  end

  def self.all
    results = DB.exec("SELECT * FROM tasks;")
    tasks = []
    results.each do |result|
      task_name = result['name']
      list_id = result['id'].to_i
      tasks << Task.new(task_name, list_id)
    end
    tasks
  end

  def save
    DB.exec("INSERT INTO tasks (name, id) VALUES ('#{@task_name}', '#{@list_id}');")
  end

  def ==(another_task)
    self.name == another_task.name && self.list_id == another_task.list_id
  end

  def list_id
    @list_id
  end
end

