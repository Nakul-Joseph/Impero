class Temperature < ApplicationRecord
  enum name: [:hot, :warm, :cold]
end
