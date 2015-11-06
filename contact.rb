require_relative 'contact_database'

class Contact
 
  attr_accessor :name, :email

  #class wide
  @@database = ContactDatabase.new

  def initialize(name, email)
    # TODO: assign local variables to instance variables
    @name = name
    @email = email
  end
 
  def to_s
    # TODO: return string representation of Contact
    "Name: #{name}, Email: #{email}"
  end
 
  ## Class Methods
  class << self
    def create(name, email)
      # TODO: Will initialize a contact as well as add it to the list of contacts
      if email_exists?(email) == false
        contact = [name, email]
        @@database.write_contact_to_csv(contact)
      end
    end
  
    def email_exists?(email)
      contacts = @@database.get_all_contacts
      matching_emails = contacts.select {|c| c[2] == email}
      if matching_emails.empty?
        false
      else
        true
      end 
    end 


    def find(search_term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
      contact = @@database.find_contact_containing(search_term)
      if contact
        puts contact
      else
        puts "Not found."
      end
    end
 
    def all
      # TODO: Return the list of contacts, as is
      @@database.display_contacts
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
      contact = @@database.find_contact_with_id(id)
      if contact 
        puts contact
      else
        puts "Not found."
      end
    end
    
  end
 
end



