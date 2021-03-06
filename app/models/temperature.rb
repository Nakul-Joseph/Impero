class Temperature < ApplicationRecord
  enum temp_type: [:hot, :cold]
  validates :temp_type, uniqueness: true
end
