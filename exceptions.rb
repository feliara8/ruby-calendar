class InvalidDateRangeError < StandardError
  def initialize(msg="Invalid date: start time can not be greater than end time")
    super(msg)
  end
end

class EndtimeRequiredError < StandardError
  def initialize(msg="Invalid date: end time required if its not all day")
    super(msg)
  end
end

class StarttimeRequiredError < StandardError
  def initialize(msg="Invalid date: start time is required")
    super(msg)
  end
end

class LocationMissingValuesError < StandardError
  def initialize(msg="Invalid location: name, address, city, state or zip missing")
    super(msg)
  end
end

class ExistingEventInRangeError < StandardError
  def initialize(msg="Invalid: there are events colling in that range", events: {})
  	values = events.map(&:name)
  	msg += msg + ": #{values}"
    super(msg)
  end
end

class EventNameRequiredError < StandardError
  def initialize(msg="Invalid event: name required")
    super(msg)
  end
end

class CalendarNameRequiredError < StandardError
  def initialize(msg="Invalid calendar: name required")
    super(msg)
  end
end
