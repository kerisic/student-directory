
require 'csv'
@students = [] # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"  
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def enterstudents(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return" 
  puts "What is the student's name?"
  name = STDIN.gets.chomp
  while !name.empty? do
    puts "Which cohort?"
    cohort = STDIN.gets.chomp
    cohort = november if cohort.empty? == true
    enterstudents(name, cohort)
    if @students.length == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    puts "What is the student's name?"
    name = STDIN.gets.chomp
    if name.empty? == true
      break
    end
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
puts "The students of Villains Academy".center(70)
puts "-------------".center(70)
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(70)
end

def save_students
  puts "Which file would you like to save it to?"
  filename = gets.chomp
  filename = "students.csv" if filename.empty?
  # open the file for writing
  CSV.open(filename, "wb") do |csv|
  #iterate over the array of students
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  puts "Saved #{@students.count} to #{filename}"
  end
end

def load_students(filename="students.csv")
  puts "Which file would you like to load students' details from?"
  filename = gets.chomp
  if File.exists?(filename)
    CSV.foreach(filename) do |line|
    name, cohort = line
    enterstudents(name, cohort)
    end
  puts "Loaded #{@students.count} from #{filename}"
  end
end

def try_load_students
  filename = ARGV.first
  return if filename.nil? 
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu