@students = []
@default_filename = "students.csv"

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts
  puts "-------------------------------------------------------"
  puts "Welcome to the Student Directory. Please make a choice."
  puts "-------------------------------------------------------"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit the program"
  puts
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
    puts "I'm sorry, I don't know what you meant. Please try again."
  end
end

def ask_for_student_name(occasion)
  if occasion == "first time"
    puts "Please enter the names of the students. After each name we'll ask for some more detail."
    puts "To finish, just hit return twice"
  elsif occasion == "post addition"
    puts
    puts "Please type in another name, or press return to go back to the menu."
  end
  name = STDIN.gets.chomp
end

def input_students
  name = ask_for_student_name("first time")
  while !name.empty? do
    puts "Please enter the month of the cohort which they'll be joining, e.g. November"
    cohort = seek_answer
    puts "What are their hobbies? (optional)"
    hobbies = seek_answer
    puts "And country of birth? (optional)"
    country_of_birth = seek_answer
    add_student_details(name, cohort, hobbies, country_of_birth)
    show_total_number_students("added")
    name = ask_for_student_name("post addition")
  end
end

def seek_answer
  return answer_sought = STDIN.gets.chomp
  if answer_sought.empty?
    return answer_sought = "None supplied"
  end
end

def add_student_details(name, cohort, hobbies, country_of_birth)
  @students << {
    name: name,
    cohort: cohort.to_sym,
    hobbies: hobbies.to_sym,
    country_of_birth: country_of_birth.to_sym,
  }
end

def show_total_number_students(occasion)
  if occasion == "added"
    prefix = "Now"
  elsif occasion == "summary"
    prefix = "Overall"
  end
  if @students.count == 1
    puts "#{prefix} we have #{@students.count} student."
  else
    puts "#{prefix} we have #{@students.count} students."
  end
end

def show_students
  if @students.count > 0
    print_header
    print_by_cohort
    show_total_number_students("summary")
  else
    puts "You haven't entered any students."
    puts
  end
end

def save_students
  # Open the file for writing
  file = File.open(@default_filename, "w")
  # Iterate over the array of students
  @students.each do |student|
    student_data = [
      student[:name],
      student[:cohort],
      student[:hobbies],
      student[:country_of_birth]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = @default_filename )
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobbies, country_of_birth = line.chomp.split(",")
    add_student_details(name, cohort, hobbies, country_of_birth)
  end
  file.close
end

def try_load_students
  if !ARGV.first.nil?
    filename = ARGV.first
  else
    filename = @default_filename
  end
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
end

# This method is unused but I kept it in in case a different view was needed.
def print_students
  count = 0
  until count == @students.length
    counter = "#{count + 1}."
    name = "#{@students[count][:name]}"
    cohort = "#{@students[count][:cohort]} cohort"
    hobby = "#{@students[count][:hobbies]}"
    country = "#{@students[count][:country_of_birth]}"
    puts counter.center(5) + name.center(15) + cohort.center(15) + hobby.center(15) + country.center(15)
    count += 1
  end
end

def print_by_cohort
  puts
  # 1. Find all the cohorts in the array
  cohorts_list = []
  @students.each do |student|
    cohorts_list << student[:cohort].to_s
  end
  # 2. Remove duplicates
  cohorts_list = cohorts_list.uniq
  # 3. For each cohort, list the students in it
  cohorts_list.each do |cohort|
    puts "Students in the #{cohort} cohort: "
    puts
    puts "Name".center(20) + "Hobbies".center(20) + "Country".center(20)
    puts "-----------------------------------------------------------------"
    @students.each do |student|
      if student[:cohort].to_s == cohort
        name = "#{student[:name]}"
        hobby = "#{student[:hobbies]}"
        country = "#{student[:country_of_birth]}"
        puts name.center(20) + hobby.center(20) + country.center(20)
      end
    end
    puts
  end
end

try_load_students
interactive_menu
