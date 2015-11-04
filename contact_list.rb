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
  puts "Enter fullname"
  name = STDIN.gets.chomp
  puts "Enter email" 
  email = STDIN.gets.chomp
  contact = [name, email]
  contact_database.write_contact_to_csv(contact)
elsif command == "list"
  contact_database.display_contacts
elsif command == "show"
  id = ARGV[1]
  contact = contact_database.find_contact_with_id(id)
  if contact 
    puts contact
  else
    puts "Not found."
  end
end
# Contact.create(name, email)
# elsif command == "list"
#   Contact.all
# end


  