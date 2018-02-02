class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer # NoMethodError
tv.model # It would call the instance method #model

Television.manufacturer # Calls the Class Method #self.manufacturer
Television.model # NoMethodError
