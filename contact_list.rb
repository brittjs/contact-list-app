require_relative 'contact'
require 'csv'
require_relative 'contact_database'


# TODO: Implement command line interaction
# This should be the only file where you use puts and gets


def help
  
  "Here is a list of available commands:
    new  - Create a new contact
    list - List all contacts
    show - Show a contact
    find - Find a contact"

end

command = ARGV[0]
contact_database = ContactDatabase.new

if command == "help"
  puts help 

elsif command == "new"
  puts "Enter email" 
  email = STDIN.gets.chomp
  if Contact.email_exists?(email)
    puts "Email already exists"
    exit-program
  end  
  
  puts "Enter first name"
  firstname = STDIN.gets.chomp


  puts "Enter last name"
  lastname = STDIN.gets.chomp
  
  # puts "Enter phone number label (e.g. home, mobile)"
  # label = STDIN.gets.chomp
  numbers = {}
  loop do
    puts "Enter phone number label (e.g. home, mobile) or leave blank and press enter."
    label = STDIN.gets.chomp
    if label.empty?
      break
    end
    puts "Enter phone number"
    numbers[label] = STDIN.gets.chomp
  end
  contact = Contact.new(firstname, lastname, email) #deal with numbers later
  contact.save


elsif command == "list"
  Contact.all

elsif command == "show"
  id = ARGV[1]
  Contact.show(id)

elsif command == "find"
  search_term = ARGV[1]
  Contact.find(search_term)
end




  