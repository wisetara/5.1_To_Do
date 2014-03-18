require 'rspec'
require 'pg'
require 'list'

DB = PG.connect({:dbname => 'to_do_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM lists *;")
  end
end

describe List do
  it 'is initialized as a class and an instance' do
    new_list = List.new('Groceries')
    new_list.should be_an_instance_of List
  end

  it 'reveals the name of the list' do
    list = List.new('Groceries')
    list.name.should eq 'Groceries'
  end

  it 'is the same list if it is the same name' do
    list1 = List.new('Groceries')
    list2 = List.new('Groceries')
    list1.should eq list2
  end

  it 'starts off with an empty list' do
    List.all.should eq []
  end

  it 'lets you save lists to the database' do
    list = List.new('Groceries')
    list.save
    List.all.should eq [list]
  end
end
