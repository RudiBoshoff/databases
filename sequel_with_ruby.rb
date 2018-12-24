# DOESN'T WORK JUST AN EXAMPLE OF A TYPICAL FORMAT (FOLLOWING A TUTORIAL)

require 'sequel'
require 'pg'

DB = Sequel.connect('postgress://user:passwprd@localhost/dbname')

DB.create_table :people do
  primary key :id
  String :first_name
  String :last_name
  Integer :age
end

people = DB[:people]
people.insert(:first_name => "Bob", :last_name => "Ross", :age => 32)

puts "There are #{people.count} people in teh database"

people.each do |person|
  puts person[:first_name]
end

DB.fetch("SELECT * FROM people") do |row|
  puts row[:first_name]
end
