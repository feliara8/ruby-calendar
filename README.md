# ruby-calendar

### Setup

1. Clone this repo
2. bundle install
3. ruby main.rb

### Tests

1. run rspec in root folder

### features

Calendars support the following methods:

#add_event(name, params) – Adds an event to the calendar.
#events – Returns all events for the calendar.
#events_with_name(name) – Returns events matching the given name.
#events_for_date(date) – Returns events that occur during the given date.
#events_for_today – Returns events that occur today.
#events_for_this_week – Returns events that occur within the next 7 days.
#update_events(name, params) – For all calendar events matching the given name, then update the event's attributes based on the given params.
#remove_events(name) – Removes calendar events with the given name.
#save - Saves your current calendar in a json with the same name than the calendar with json extension

### Initialize the Calendar
```ruby
cal = Calendar.new("Greg's Calendar")
```

### Add Events to the Calendar
```ruby
cal.add_event("Greg's Party",             # name is required
  all_day: false,                          # all_day is optional (defaults to false)
  start_time: Time.new(2017, 8, 5, 20, 0), # start_time is required
  end_time: Time.new(2017, 8, 5, 23, 23),  # end_time is required UNLESS all_day is true
  location: {                              # location is optional
    name: 'Barcade',                         # name is required
    address: '148 W 24th St',                # address is optional
    city: 'New York',                        # city is optional
    state: 'NY',                             # state is optional
    zip: '10011'                             # zip is optional
  }
)


### Save the Calendar

cal.save

### Load the Calendar

cal = Calendar.load("Greg's calendar")

### Chronic

You can use chronic strings instead of Time.new, for example, 'this tuesday 5:00'

