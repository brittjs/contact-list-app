class Phone

  attr_accessor :contact, :type, :numbers

  def initialize(contact, type, numbers)
    @contact = contact
    @type = type
    @numbers = numbers
  end

end
