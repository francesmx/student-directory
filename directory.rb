def input_students
  puts "Please enter the names of the students. After each name we'll ask for some more detail."
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
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
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "--------------------------------"
end

def print(students)
  count = 0
  until count == students.length
    counter = "#{count + 1}."
    name = "#{students[count][:name]}"
    cohort = "#{students[count][:cohort]} cohort"
    hobby = "#{students[count][:hobbies]}"
    country = "#{students[count][:country_of_birth]}"
    puts counter + name.center(20) + cohort.center(20) + hobby.center(20) + country.center(20)
    count += 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)
