class Subclass < ApplicationRecord
  belongs_to :dnd_class
  has_many :subclass_levels, dependent: :destroy
end
