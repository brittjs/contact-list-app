require_relative 'contact_database'
require_relative 'phone'
require 'pg'

class Contact
 
  attr_accessor :firstname, :lastname, :email, :phones
  attr_reader :id

  @@database = ContactDatabase.new


  def initialize(firstname, lastname, email, id = nil, phones = [])
    @firstname = firstname
    @lastname = lastname
    @email = email
    @phones = phones
    @id = id
  end

  def self.connection
    @@conn ||= PG::Connection.open(dbname: 'contact_list')
  end
 
  def to_s
    # TODO: return string representation of Contact
    "Name: #{name}, Email: #{email}"
  end

  def save
    # if Contact.email_exists?(email) == false
    if id
      # Updates a contact
      self.class.connection.exec_params('UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4;', [firstname, lastname, email, id])
    else
      # Creates a contact
      res = self.class.connection.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id;', [firstname, lastname, email])
      @id = res[0]['id']
    end
  end

  def destroy
    # Deletes a contact
    self.class.connection.exec_params('DELETE FROM contacts WHERE id = $1;', [id])
  end
 
  ## Class Methods
  class << self
  
    def email_exists?(email)
      contacts = @@database.get_all_contacts
      matching_emails = contacts.select {|c| c[2] == email}
      if matching_emails.empty?
        false
      else
        true
      end 
    end 

    def find_all_by_lastname(name)
      res = self.connection.exec_params('SELECT * FROM contacts WHERE lastname = $1;', [name])
      contacts = res.map {|c| Contact.new(c['firstname'], c['lastname'], c['email'], c['id'])}
      contacts
    end

    def find_all_by_firstname(name)
      res = self.connection.exec_params('SELECT * FROM contacts WHERE firstname = $1;', [name])
      contacts = res.map {|c| Contact.new(c['firstname'], c['lastname'], c['email'], c['id'])}
      contacts
    end

    def find_by_email(search_email)
      res = self.connection.exec_params('SELECT * FROM contacts WHERE email = $1;', [search_email])
      contacts = Contact.new(res[0]['firstname'], res[0]['lastname'], res[0]['email'], res[0]['id'])
      contacts
    end

    def find(id_num)
      # TODO: Will find and return contacts that have that id
      res = self.connection.exec_params('SELECT * FROM contacts WHERE id = $1;', [id_num])
      Contact.new(res[0]['firstname'],res[0]['lastname'],res[0]['email'],res[0]['id'])  
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



