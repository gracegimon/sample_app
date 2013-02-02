class User
  attr_accessor :name, :email 
  # attr_accessor Lets us create get and set methods
   
  def initialize(attributes = {})
   @name = attributes[:name] #A variable available anywhere inside the class
   @email = attributes[:email]
  end

  def formatted_email
   "#{@name} <#{@email}> "
  end



end
