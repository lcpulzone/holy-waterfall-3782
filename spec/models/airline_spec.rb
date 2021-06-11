require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it { should have_many(:flights) }
    it { should have_many(:passengers).through(:flights) }
  end

  describe '#instance methods' do
    it 'can show only adult passengers' do
      @hawk = Airline.create!(name: 'Hawk Express')
      @dalia = Airline.create!(name: 'Dalia Flights')

      @orange = @hawk.flights.create!(number: '7854', date: '05/13/2021', departure_city: 'San Fran', arrival_city: 'Orange County')
      @redmomd = @dalia.flights.create!(number: '5913', date: '09/13/2021', departure_city: 'Portland', arrival_city: 'Redmond')
      @bend = @dalia.flights.create!(number: '0666', date: '04/01/2021', departure_city: 'Seattle', arrival_city: 'Bend')

      @nick = @bend.passengers.create!(name: 'Nick Pulzone', age: 36)
      @annie = @bend.passengers.create!(name: 'Annie Wesley', age: 18)
      @matt = @bend.passengers.create!(name: 'Matt Rock', age: 12)

      expect(@dalia.adult_passengers).to eq([@nick, @annie])
    end
  end
end
