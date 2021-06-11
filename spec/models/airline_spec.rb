require 'rails_helper'

RSpec.describe Airline, type: :model do
  it { should have_many(:flights) }
end
