def input_students
  puts "Please enter the names of the students. After each name we'll ask for some more detail."
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
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
    students << {
      name: name,
      cohort: cohort.to_sym,
      hobbies: hobbies.to_sym,
      country_of_birth: country_of_birth.to_sym,
    }

    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def interactive_menu
  students = []
  loop do
    # 1. Show the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    # 2. Read the input and save it into a variable
    selection = gets.chomp
    # 3. Do what the user has asked
    case selection
    when "1"
      students = input_students
    when "2"
      print_header(students)
      print_by_cohort(students)
      print_footer(students)
    when "9"
      exit
    else
      puts "I don't know what you meant. Try again."
    end
  end
end


def print_header students
  if students.length >= 1
    puts "The students of Villains Academy"
    puts "--------------------------------"
  end
end

def print(students)

  if students.length >= 1
    count = 0
    until count == students.length
      counter = "#{count + 1}."
      name = "#{students[count][:name]}"
      cohort = "#{students[count][:cohort]} cohort"
      hobby = "#{students[count][:hobbies]}"
      country = "#{students[count][:country_of_birth]}"
      puts counter.center(5) + name.center(15) + cohort.center(15) + hobby.center(15) + country.center(15)
      count += 1
    end
  else
    puts "You haven't entered any students."
  end
end

def print_by_cohort(students)
  if students.length >= 1
    # 1. Find all the cohorts in the array
    cohorts_list = []
    students.each do |student|
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
      students.each do |student|
        if student[:cohort].to_s == cohort
          name = "#{student[:name]}"
          hobby = "#{student[:hobbies]}"
          country = "#{student[:country_of_birth]}"

          puts name.center(20) + hobby.center(20) + country.center(20)
        end
      end
      puts
    end
  else
    puts "You haven't entered any students."
  end
end

def print_footer(students)
  if students.length >= 1
    if students.count == 1
      puts "Overall, we have #{students.count} great student"
    elsif students.count > 1
      puts "Overall, we have #{students.count} great students"
    end
  end
end

interactive_menu
