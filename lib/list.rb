class List

  attr_reader :list_name

  def initialize(list_name)
    @list_name = list_name
  end

  def name
    @list_name
  end

  def ==(another_list)
    self.name == another_list.name
  end

  def self.all
    results = DB.exec("SELECT * FROM lists;")
    lists = []
    results.each do |result|
      list_name = result['name']
      lists << List.new(list_name)
    end
    lists
  end

  def save
    DB.exec("INSERT INTO lists (name) VALUES ('#{@list_name}');")
  end
end
