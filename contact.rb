

class Contact
 
  attr_accessor :name, :email

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
      new_contact = Contact.create(name, email)
      @@contacts << new_contact
    end
 
    def find(term)
      # TODO: Will find and return contacts that contain the term in the first name, last name or email
    end
 
    def all
      # TODO: Return the list of contacts, as is
      # CSV.foreach('contacts.csv') do |contact|
      #   puts contact.inspect
      # end
    end
    
    def show(id)
      # TODO: Show a contact, based on ID
    end
    
  end
 
end