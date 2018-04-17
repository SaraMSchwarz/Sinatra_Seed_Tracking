class Variety < ActiveRecord::Base
  validates_presence_of :name, :count
  belongs_to :seed
end
