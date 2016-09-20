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
  puts "-----------------------------------------------------------"
  puts "Welcome to the Student Directory. You look lovely today."
  puts "-----------------------------------------------------------"
  puts "Please make a choice from the following options:"
  puts
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to #{@default_filename}"
  puts "4. Load the list from #{@default_filename}"
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
    puts "\n*** Goodbye. Have a lovely day! ***"
    puts
    exit
  else
    puts "I'm sorry, I don't know what you meant. Please try again."
  end
end

def ask_for_student_name(occasion)
  if occasion == "first time"
    puts "\nPlease enter the name of the first student."
  elsif occasion == "post addition"
    puts
    puts "Great! Student added. Now please type in another name."
  end
    puts "Or hit return to go back to the main menu.\n"
  name = STDIN.gets.chomp
end

def input_students
  puts "\n*** You chose to input students ***\n"
  name = ask_for_student_name("first time")
  while !name.empty? do
    puts "\nPlease enter the month of the cohort which they'll be joining, e.g. November"
    cohort = seek_answer
    puts "\nWhat are their hobbies? (optional)"
    hobbies = seek_answer
    puts "\nAnd country of birth? (optional)"
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
    puts "\n#{prefix} we have #{@students.count} student."
  else
    puts "\n#{prefix} we have #{@students.count} students."
  end
end

def show_students
  puts "\n*** You chose to see the list of students ***"
  puts
  if @students.count > 0
    print_header
    print_by_cohort
    show_total_number_students("summary")
  else
    puts "Unfortunately you haven't entered any!"
    puts
  end
end

def save_students
  filename = prompt_filename("save")

  # Open the file for writing
  file = File.open(filename, "w")
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
  puts "\n*** Hooray! Successfully saved #{@students.count} students to #{filename} ***"
end

def load_students
  # Check first if filename was given from command line.
  if !ARGV.first.nil?
    filename = ARGV.first
  else
    filename = prompt_filename("load")
  end

  # Check file exists. If so, load data from it. If not, exit.
  if File.exists?(filename)
    file = File.open(filename, "r")
    file.readlines.each do |line|
      name, cohort, hobbies, country_of_birth = line.chomp.split(",")
      add_student_details(name, cohort, hobbies, country_of_birth)
    end
    file.close
    puts "\n*** Hooray! Successfully loaded #{@students.count} students from #{filename} ***"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def prompt_filename(occasion)

  if occasion == "save"
    prefix = "Save"
    from_or_to = "to"

  elsif occasion == "load"
    prefix = "Load"
    from_or_to = "from"
  end

  # Prompt user to confirm default file or enter a new one.
  puts "#{prefix} data #{from_or_to} #{@default_filename}? Type yes or no."
  response = STDIN.gets.chomp.downcase

  if response == "yes"
    filename = @default_filename

  elsif response == "no"
    puts "Please enter the name of the csv file you'd like to #{prefix.downcase} #{from_or_to} (including the .csv extension)"
    filename = STDIN.gets.chomp

    puts "Would you like us to make this the default file for student records? Type yes or no."
    change_default = STDIN.gets.chomp.downcase

    if change_default == "yes"
      @default_filename = filename
      puts "Thank you. The default filename is now #{@default_filename}."

    elsif change_default == "no"
      "Okay - we'll just do this as a one off then :)"
    end

  else
    puts "I'm sorry, I didn't understand what you typed."
    exit
  end

  return filename
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
    puts "Students in the #{cohort} cohort:"
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

load_students
interactive_menu
