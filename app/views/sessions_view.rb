class SessionsView
  def initialize
  end

  def ask_for_username
    puts "username?"
    gets.chomp
  end

  def ask_for_password
    puts "password?"
    gets.chomp
  end

  def print_wrong_credentials
    puts "Wrong username or password!Try again"
  end

    def display(employees)
    employees.each_with_index do |employee, index|
      puts "#{index + 1}. #{employee.username}"
    end
  end
end
