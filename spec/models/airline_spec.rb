require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it { should have_many(:flights) }
    it { should have_many(:passengers).through(:flights) }
  end

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
  describe '#instance methods' do
    it 'can show only adult passengers' do
      expect(@dalia.adult_passengers).to eq([@nick, @annie])
    end


      it 'can sort adult passengers from most flights to least' do
        expect(@dalia.sorted_passengers).to eq([@nick, @annie])
      end
  end
end
