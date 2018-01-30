require_relative '../location'

RSpec.describe Location do
	context 'with valid params' do
		it 'create location entering all required params' do
		  location_params = {
		  	name: 'some location', address: 'some address',
		  	city: 'some city', state: 'some state', zip: 'some zip'
		  }
		  location = Location.new(**location_params)
		  expect(location.name).to eq(location_params[:name])
		end
	end

	context "with wrong params" do
		it "raises CalendarNameRequired with blank name" do
		  location_params = {
		  	address: 'some address',
		  	city: 'some city', state: 'some state', zip: 'some zip'
		  }
			expect { Location.new(**location_params) }.to raise_error(LocationMissingValuesError)
		end
	end
end