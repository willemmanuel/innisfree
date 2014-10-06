class Resident < ActiveRecord::Base
  belongs_to :house, dependent: :destroy
end
