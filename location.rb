require_relative 'exceptions'

class Location
	attr_accessor :name, :address, :city, :state, :zip

  def initialize(**args)
  	@name = args[:name]
  	@address = args[:address]
  	@city = args[:city]
  	@state = args[:state]
  	@zip = args[:zip]
  	check_validations
  end

  def to_s
  	formatted_string = "#{name}"
  	['address', 'city', 'state', 'zip'].each { |variable|
  		instance_var = instance_variable_get("@"+variable)
  		formatted_string += ", #{instance_var}" if instance_var
  	}
  	formatted_string
  end

  def to_h
  	hash = {}
  	instance_variables.each {|var| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) }
  	hash
  end

  def check_validations
  	missing_values = @name.blank? || @address.blank? || @city.blank? || @state.blank? || @zip.blank?
  	raise LocationMissingValuesError if missing_values
  end
end