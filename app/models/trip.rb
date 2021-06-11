class Trip < ApplicationRecord
  belongs_to :flight
  belongs_to :passenger

  def remove
    
  end
end
