## TODO: Implement CSV reading/writing
# require_relative 'contact_list'
# require_relative 'contact'
require 'csv'

# @@contacts = []


class ContactDatabase

  def initialize
    @current_id = 0  
  end

  #TODO get the last id from the csv
  def write_contact_to_csv(contact)
    CSV.open('contacts.csv','a') do |csv| 
      contact.unshift(@current_id)
      csv << contact 
      @current_id += 1
    end
  end

  def display_contacts
    CSV.foreach('contacts.csv') do |contact|
    puts contact.join(" ")
    end
  end

  def find_contact_with_id(id)
    CSV.foreach('contacts.csv') do |contact|
      if contact[0] == id
        return contact
      end  
    end 
    return nil
  end

end

# cd = ContactDatabase.new
# cd.display_contacts
