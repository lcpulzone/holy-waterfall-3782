require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe 'relationships' do
    it { should have_many(:trips) }
    it { should have_many(:flights).through(:trips) }
  end

  describe 'validations' do
    it { should validate_presence_of(:) }
  end

  before :each do

  end

  describe 'class methods' do
    describe '.' do
    end
  end

  describe 'instance methods' do
    describe '#' do
    end
  end
end
