class Quote < ActiveRecord::Base
  belongs_to :authors
  belongs_to :users
end
