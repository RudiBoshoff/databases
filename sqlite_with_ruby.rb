require "sqlite3"
$db = SQLite3::Database.new("test_db")
$db.results_as_hash = true

def disconnect_and_quit
  $db.close
  puts "bye"
  exit
end

def create_table
  if File.exist?("test_db")
    puts "Database already exists"
  else
    puts "Creating people table"
    $db.execute %q{
      CREATE TABLE people (
        id integer primary key AUTOINCREMENT,
        name varchar(50),
        job varchar(50),
        gender varchar(6),
        age integer
      )
     }
  end
end

def add_person
  puts "Enter name:"
  name = gets.chomp
  puts "Enter job:"
  job = gets.chomp
  puts "Enter a gender:"
  gender = gets.chomp
  puts "Enter age:"
  age = gets.chomp
  $db.execute("INSERT INTO people (name, job, gender, age) VALUES (?,?,?,?)",
  name, job, gender, age)
end

def find_person
  puts "Enter name or ID of person you wish to find:"
  id = gets.chomp
  person = $db.execute("SELECT * FROM people WHERE name = ? OR id = ?",
     id, id.to_i).first

  unless person
    puts "No such entry found."
    return
  end

  puts %Q{
    ID: #{person['id'].to_s}
    Name: #{person['name']}
    Job: #{person['job']}
    Gender: #{person['gender']}
    Age: #{person['age'].to_s}
  \n}
end

loop do
  puts %Q{Please select an option:\n
    1. Create people table
    2. Add a person
    3. Find person
    4. Quit}
  case gets.chomp
  when '1'
    create_table
  when '2'
    add_person
  when '3'
    find_person
  when '4'
    disconnect_and_quit
  end
end
