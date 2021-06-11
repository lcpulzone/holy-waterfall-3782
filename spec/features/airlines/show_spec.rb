require 'rails_helper'

RSpec.describe 'airline show page' do
  before :each do
    @hawk = Airline.create!(name: 'Hawk Express')
    @dalia = Airline.create!(name: 'Dalia Flights')

    @orange = @hawk.flights.create!(number: '7854', date: '05/13/2021', departure_city: 'San Fran', arrival_city: 'Orange County')
    @redmond = @dalia.flights.create!(number: '5913', date: '09/13/2021', departure_city: 'Portland', arrival_city: 'Redmond')
    @bend = @dalia.flights.create!(number: '0666', date: '04/01/2021', departure_city: 'Seattle', arrival_city: 'Bend')

    @nick = @redmond.passengers.create!(name: 'Nick Pulzone', age: 36)
    @annie = @redmond.passengers.create!(name: 'Annie Wesley', age: 18)
    @matt = @redmond.passengers.create!(name: 'Matt Rock', age: 12)

    @bend.passengers << @nick
    @bend.passengers << @matt
  end

  it 'can list only adult passengers that have flights on this airline with no duplicates' do
    visit "/airlines/#{@dalia.id}"

    expect(page).to have_content(@nick.name, count: 1)
    expect(page).to have_content(@annie.name)

    expect(page).to_not have_content(@matt.name)
  end

end
