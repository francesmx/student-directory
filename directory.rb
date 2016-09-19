def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {
      name: name,
      cohort: :november,
      hobbies: :cookery,
      country_of_birth: :England,
      height: :sixfeet
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
    puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort) hobby: #{students[count][:hobbies]}, country of birth: #{students[count][:country_of_birth]}, height: #{students[count][:height]}"
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
