require_relative 'event'
require_relative 'exceptions'
require 'active_support'
require 'active_support/core_ext'
require 'date'
require 'chronic'
require 'json'

class Calendar
  attr_accessor :name, :event_list

  def initialize(name_to_assign, event_list = [])
    @name = name_to_assign
    raise CalendarNameRequiredError if @name.nil? || @name.blank?
    @event_list = []
    event_list.each { |event| 
      location_hash = event['location'].inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo} if event['location']
      @event_list.push(Event.new(event['name'], start_time: event['start_time'],
                                 end_time: event['end_time'], all_day: event['all_day'],
                                 location: location_hash))
    }
  end

  def add_event(name, all_day: false, **args)
    start_time = parse_date_time(args[:start_time])
    end_time = parse_date_time(args[:end_time])
    end_time = start_time.to_date.end_of_day if all_day && start_time
    check_validations(start_time , end_time)
    event = Event.new( name, all_day: all_day,
                       start_time: start_time,
                       end_time: end_time, location: args[:location])
    event_list.push(event)
  rescue => e
    raise e
  end

  def events
    return 'Calendar has no events' if event_list.empty?
    event_list
  end

  def events_with_regexp(regexp)
    evts = event_list.select{ |event| 
      (event.name =~ regexp).present?
    }
  end

  def events_with_name(name)
    evts = event_list.select{ |event| event.name == name}
  end

  def events_for_date(date)
    evts = event_list.select{ |event| event.start_time.to_date == date}
  end

  def events_for_today
    evts = event_list.select{ |event| event.start_time.to_date == Date.today}
  end

  def events_for_this_week
    evts = event_list.select{ |event| 
      event.start_time.to_date >= Date.today && event.start_time.to_date <= Date.today + 7
    }
  end

  def events_in_range(start_date_time, end_date_time)
    event_list.select{ |event| 
      start_between = start_date_time >= event.start_time && start_date_time < event.end_time
      end_between = end_date_time > event.start_time && start_date_time <= event.end_time
      start_between || end_between
    }
  end

  def remove_events(name)
    event_list.delete_if { |event| event.name == name }
  end

  def update_events(name, **args)
    event_list.collect! { |event|
     hash_params = { 
       start_time: event.start_time, 
       end_time: event.end_time,
       all_day: event.all_day,
       location: event.location.to_h
     }
     merged_params = hash_params.merge(args)
     event.name == name ? Event.new(name, **merged_params) : event
    }
  end

  def to_s
    "Calendar: #{@name}"
  end

  def save
    File.open("#{@name}.json","w") do |f|
      f.write(to_json)
    end
  end

  def self.load(name_of_calendar)
    file = File.read("#{name_of_calendar}.json")
    calendar = JSON.parse(file)
    Calendar.new(name_of_calendar, calendar['event_list'])
  end

  protected

  def parse_date_time(date_time)
    date_time = Chronic.parse(date_time) if date_time.is_a? String
    date_time
  end

  def check_validations(start_time, end_time)
    evts_in_range = events_in_range(start_time, end_time)
    raise ExistingEventInRangeError.new(events: evts_in_range) unless evts_in_range.empty?
  end
end