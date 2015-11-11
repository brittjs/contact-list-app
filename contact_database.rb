## TODO: Implement CSV reading/writing
# require_relative 'contact_list'
# require_relative 'contact'
require 'csv'

# @@contacts = []


class ContactDatabase

  def initialize
    @current_id = 0  
  end

  def encode_phone_numbers(phone_numbers)
    #take hash of phone numbers and change to string with spaces seperating each entry
    #want format to look like mobile:7777777777|home:8888888888
    result = ""
    phone_numbers.each do |label, number|
      result += label + ":" + number + " "
    end
    result[-1, 1] = ""
    result
  end  

  def decode_phone_numbers(numbers_as_strings)
    result = {}
    temp_nums = numbers_as_strings.split(" ")
    temp_nums.each do |entry| 
      kv = entry.split(":") #this looks like [mobile, 77777] 
      label = kv[0]
      num = kv[1]
      result[label] = num
    end
    result
  end


  def write_contact_to_csv(contact, phone_numbers = {})
    CSV.open('contacts.csv','a') do |csv| 
      contact.unshift(@current_id)
      if phone_numbers.keys.any?
        contact << encode_phone_numbers(phone_numbers)
      end
      csv << contact 
      @current_id += 1
    end
  end

  def display_contacts
    CSV.foreach('contacts.csv') do |contact|
    puts contact.join(" ")
    end
  end

  def get_all_contacts
    CSV.read('contacts.csv')
  end


  def find_contact_with_id(id)
    CSV.foreach('contacts.csv') do |contact|
      if contact[0] == id
        return contact
      end  
    end 
    return nil
  end

  def find_contact_containing(search_term)
    CSV.foreach('contacts.csv') do |contact|
      if contact.join('').downcase.include?(search_term.downcase)
        return contact
      end  
    end 
    return nil
  end

end

