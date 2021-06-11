require 'rails_helper'

RSpec.describe 'flight index page' do
  before :each do
    @hawk = Airline.create!(name: 'Hawk Express')
    @dalia = Airline.create!(name: 'Dalia Flights')

    @orange = @hawk.flights.create!(number: '7854', date: '05/13/2021', departure_city: 'San Fran', arrival_city: 'Orange County')
    @redmomd = @dalia.flights.create!(number: '5913', date: '09/13/2021', departure_city: 'Portland', arrival_city: 'Redmond')
    @bend = @dalia.flights.create!(number: '0666', date: '04/01/2021', departure_city: 'Seattle', arrival_city: 'Bend')

    @nick = @bend.passengers.create!(name: 'Nick Pulzone', age: 36)
    @annie = @bend.passengers.create!(name: 'Annie Wesley', age: 18)
    @matt = @bend.passengers.create!(name: 'Matt Rock', age: 12)

    visit "/flights"
  end

  it 'can show name of airline next to each flight number' do
    within("#flight-numbers-#{@orange.id}") do
      expect(page).to have_content(@orange.number)
      expect(page).to have_content(@hawk.name)
      
      expect(page).to_not have_content(@redmomd.number)
      expect(page).to_not have_content(@dalia.name)
    end

    within("#flight-numbers-#{@redmomd.id}") do
      expect(page).to have_content(@dalia.name)
      expect(page).to have_content(@redmomd.number)

      expect(page).to_not have_content(@orange.number)
      expect(page).to_not have_content(@hawk.name)
    end

    within("#flight-numbers-#{@bend.id}") do
      expect(page).to have_content(@bend.number)
      expect(page).to have_content(@dalia.name)
      expect(page).to have_content(@nick.name)
      expect(page).to have_content(@annie.name)
      expect(page).to have_content(@matt.name)

      expect(page).to_not have_content(@redmomd.number)
      expect(page).to_not have_content(@hawk.name)
    end
  end
end
