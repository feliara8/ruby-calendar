require_relative '../event'
require_relative '../location'

RSpec.describe Event do
	context 'with valid params' do
		it 'create event entering all required params' do
		  name = 'test_name'
		  start_time = Time.new(2017, 8, 6, 11, 30)
		  end_time = Time.new(2017, 8, 6, 12, 30)
		  event = Event.new(name, start_time: start_time, end_time: end_time )
		  expect(event.name).to eq(name)
		end

		it 'create event entering all required params and location' do
		  name = "test_name"
		  start_time = Time.new(2017, 8, 6, 11, 30)
		  end_time = Time.new(2017, 8, 6, 12, 30)
		  location = {
		  	name: 'some location', address: 'some address',
		  	city: 'some city', state: 'some state', zip: 'some zip'
		  }
		  event = Event.new(name, start_time: start_time, end_time: end_time, location: location )
		  expect(event.name).to eq(name)
		end
	end

	context 'with wrong params' do
		it 'raises EventNameRequired with blank name or nil' do
		  name = ''
		  start_time = Time.new(2017, 8, 6, 11, 30)
		  end_time = Time.new(2017, 8, 6, 12, 30)
		  expect {
		  	Event.new(name, start_time: start_time, end_time: end_time )
		  }.to raise_error(EventNameRequiredError)
		end

		it 'raises StarttimeRequiredError without starttime' do
			name = 'test event'
		  end_time = Time.new(2017, 8, 6, 12, 30)
		  expect {
		  	Event.new(name, end_time: end_time )
		  }.to raise_error(StarttimeRequiredError)
		end

		it 'raises EndtimeRequiredError without endttime and if its not all day' do
			name = 'test event'
		  start_time = Time.new(2017, 8, 6, 12, 30)
		  expect {
		  	Event.new(name, start_time: start_time )
		  }.to raise_error(EndtimeRequiredError)
		end

		it 'raises InvalidDateRangeError with inconsistent range' do
			name = 'test event'
		  start_time = Time.new(2017, 8, 6, 12, 30)
		  end_time = Time.new(2017, 8, 5, 12, 30)
		  expect {
		  	Event.new(name, start_time: start_time, end_time: end_time )
		  }.to raise_error(InvalidDateRangeError)
		end
	end
end