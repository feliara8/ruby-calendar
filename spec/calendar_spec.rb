require_relative '../calendar'

RSpec.describe Calendar do
	context "with valid params" do
		it "create calendar entering a name" do
		  name = "test_name"
		  calendar = Calendar.new(name)
		  expect(calendar.name).to eq(name)
		end
	end

	context "with wrong params" do
		it "raises CalendarNameRequired with blank name or nil" do
		  name = ""
			expect { Calendar.new(name) }.to raise_error(CalendarNameRequiredError)
			expect { Calendar.new(nil) }.to raise_error(CalendarNameRequiredError)
		end
	end

	context "adding_events" do
		before(:each) do
			name = "test_calendar"
	    @calendar = Calendar.new(name)
	  end

		context "with valid params" do
			it "without optional location" do
				name = "test event"
				start_time = Time.new(2017, 8, 4, 20, 0)
				end_time = Time.new(2017, 8, 4, 22, 0)
			  @calendar.add_event(name, start_time: start_time, end_time: end_time)
			  expect(@calendar.event_list.length).to eq(1)
			end

			it "with all_day and without end time" do
				name = "test event"
				start_time = Time.new(2017, 8, 4, 20, 0)
				all_day = true
			  @calendar.add_event(name, all_day: true, start_time: start_time)
			  expect(@calendar.event_list.length).to eq(1)
			  expect(@calendar.event_list.first.end_time).to eq(start_time.end_of_day)
			end
		end

		context "with wrong params" do
			it "entering a colliding event raises ExistingEventInRangeError" do
				name = "test event 1"
				start_time = Time.new(2017, 8, 4, 20, 0)
				end_time = Time.new(2017, 8, 4, 22, 0)
			  @calendar.add_event(name, start_time: start_time, end_time: end_time)
			  expect {
			  	@calendar.add_event(name, start_time: start_time, end_time: end_time)
			  }.to raise_error(ExistingEventInRangeError)
			end
		end
	end

	context "removing and updating events" do
		before(:each) do
			name = "test_calendar"
	    @calendar = Calendar.new(name)
	    @event_name = "test event"
			start_time = Time.new(2017, 8, 4, 20, 0)
			end_time = Time.new(2017, 8, 4, 23, 0)
			@calendar.add_event(@event_name, start_time: start_time, end_time: end_time)
	  end

	  it "removing an event" do
	  	@calendar.remove_events(@event_name)
	  	expect(@calendar.event_list.length).to eq(0)
	  end

	  it "updates an event" do
	  	start_time = Time.new(2017, 8, 4, 22, 30)
	  	@calendar.update_events(@event_name, start_time: start_time)
	  	expect(@calendar.event_list.length).to eq(1)
	  	expect(@calendar.event_list.first.start_time).to eq(start_time)
	  end
	end
end