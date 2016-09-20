@students = []

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
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

def input_students
  puts "Please enter the names of the students. After each name we'll ask for some more detail."
  puts "To finish, just hit return twice"
  # create an empty array
  # get the first name
  # Could use gets.gsub(/\n/," ") instead of chomp
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do

    puts "Please enter the month of the cohort which they'll be joining, e.g. November?"
    cohort = gets.chomp
    if cohort == ""
      cohort = "None supplied"
    end

    puts "And what are their hobbies?"
    hobbies = gets.chomp
    if hobbies == ""
      hobbies = "None supplied"
    end

    puts "And country of birth?"
    country_of_birth = gets.chomp
    if country_of_birth == ""
      country_of_birth = "None supplied"
    end

    #add the student hash to the array
    @students << {
      name: name,
      cohort: cohort.to_sym,
      hobbies: hobbies.to_sym,
      country_of_birth: country_of_birth.to_sym,
    }

    if @students.count == 1
      puts "Now we have #{@students.count} student."
    else
      puts "Now we have #{@students.count} students."
    end
    # get another name from the user
    puts
    puts "Please type in another name, or press return to go back to the menu."
    name = gets.chomp
  end
end

def show_students
  if @students.count > 0
    print_header
    print_by_cohort
    print_footer
  else
    puts "You haven't entered any students."
    puts
  end
end

def save_students
  # Open the file for writing
  file = File.open("students.csv", "w")
  # Iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobbies], student[:country_of_birth]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort, hobbies, country_of_birth = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym, hobbies: hobbies.to_sym, country_of_birth: country_of_birth.to_sym}
  end
  file.close
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
end

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

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  elsif @students.count > 1
    puts "Overall, we have #{@students.count} great students"
  end
end

interactive_menu
