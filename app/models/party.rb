class Party < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  def invited
    
  end
end
