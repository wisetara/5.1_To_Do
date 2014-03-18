require 'pg'
require './lib/to_do_list'

DB = PG.connect({:dbname => 'to_do'})

def welcome
  puts "\u Welcome to the To Do list! \u"
  main_menu
end
