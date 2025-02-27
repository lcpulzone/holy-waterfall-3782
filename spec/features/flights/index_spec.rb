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

  describe 'flight information' do
    it 'can show number of each flight, name of airline next to each flight number, and all passengers in flight' do
      within("#flight-numbers-#{@orange.id}") do
        expect(page).to have_content(@orange.number)
        expect(page).to have_content(@hawk.name)

        expect(page).to_not have_content(@redmomd.number)
        expect(page).to_not have_content(@dalia.name)
        expect(page).to_not have_content(@nick.name)
      end

      within("#flight-numbers-#{@redmomd.id}") do
        expect(page).to have_content(@dalia.name)
        expect(page).to have_content(@redmomd.number)

        expect(page).to_not have_content(@orange.number)
        expect(page).to_not have_content(@hawk.name)
        expect(page).to_not have_content(@annie.name)
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

  describe 'delete passenger' do
    it 'can delete a passenger from a flight but not from the passengers list' do
      within("#flight-numbers-#{@bend.id}") do
        expect(page).to have_button("Remove #{@nick.name}")

        click_button "Remove #{@nick.name}"

        expect(current_path).to eq("/flights")

        expect(page).to_not have_content(@nick.name)
      end
      
      visit "/passengers"

      expect(page).to have_content(@nick.name)
      expect(page).to have_content(@annie.name)
      expect(page).to have_content(@matt.name)
    end
  end
end
