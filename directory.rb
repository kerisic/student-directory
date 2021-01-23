@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return" 
  puts "What is the student's name?"
  name = gets.chomp
  while !name.empty? do
    puts "Which cohort?"
    cohort = gets.chomp
    cohort = :november if cohort.empty? == true
    puts "What is the student's hobby?"
    hobby = gets.chomp
    puts "What is the student's country of birth?"
    country = gets.chomp
    @students << {name: name, cohort: cohort, hobby: hobby, country: country}
    if @students.length == 1
      puts "Now we have 1 student"
    else
      puts "Now we have #{@students.count} students"
    end
    #get another name from the user
    puts "What is the student's name?"
    name = gets.chomp
    if name.empty? == true
      break
    end
  end
end

def print_header
puts "The students of Villains Academy".center(70)
puts "-------------".center(70)
end

def print_students_list
  index = 0
  while true do    
    puts "#{index + 1}. #{@students[index][:name]}, Hobby: #{@students[index][:hobby]}, #{@students[index][:country]} (#{@students[index][:cohort]} cohort)".center(70)
    index += 1
    if index >= @students.length
      break
    end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(70)
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"  
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(" , ")
    file.puts csv_line
  end
  file.close
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit#this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  @students = []
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
