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
  puts "Enter fullname"
  name = STDIN.gets.chomp
  Contact.create(name, email)

elsif command == "list"
  Contact.all

elsif command == "show"
  id = ARGV[1]
  Contact.show(id)

elsif command == "find"
  search_term = ARGV[1]
  Contact.find(search_term)
end




  