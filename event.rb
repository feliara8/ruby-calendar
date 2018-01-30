require_relative 'location'
require_relative 'exceptions'
require 'active_support'
require 'active_support/core_ext'
require 'date'

class Event
	attr_accessor :name, :all_day, :start_time, :end_time, :location

  def initialize(name, all_day: false, **args)
  	@name = name
  	@all_day = all_day
  	@start_time = args[:start_time]
  	@end_time = args[:end_time]
  	@location = Location.new(**args[:location]) if args[:location] && args[:location].present?
  	check_validations
  end

  def to_s
  	event = "# #{name}\n"
		event += "# ...Starts: #{start_time}\n"
		event += "# ...Ends: #{end_time}\n"
		event += "# ...Location: #{location.to_s}\n" unless location.nil?
  	event += "# ---------------------------------------------------------------------\n"
  end

  def check_validations
  	raise StarttimeRequiredError if @start_time.nil?
  	raise InvalidDateRangeError if @end_time && @start_time > @end_time
  	raise EndtimeRequiredError  if !@all_day and @end_time.nil?
  	raise EventNameRequiredError if @name.nil? || @name.blank?
  end
end
