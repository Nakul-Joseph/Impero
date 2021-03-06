# frozen_string_literal: true

class Temperature < ApplicationRecord
  enum temp_type: %i[hot cold]

  validates :temp_type, presence: true,
                        inclusion: { in: temp_types.keys }
  validates :value, presence: true,
                    numericality: true,
                    inclusion: { in: -60.0..60.0, message: 'should be between -60 and 60 degree celcius' }

  validate :cold_temp_cannot_be_greater_than_hot_temp, if: :cold?
  validate :hot_temp_cannot_be_less_than_cold_temp, if: :hot?

  def cold?
    temp_type == 'cold'
  end

  def hot?
    temp_type == 'hot'
  end

  def self.hot
    find_by(temp_type: :hot)
  end

  def self.cold
    find_by(temp_type: :cold)
  end

  def cold_temp_cannot_be_greater_than_hot_temp
    hot = Temperature.hot
    if hot.present? && value.present? && (value >= hot.value)
      errors.add(:value, "can't be greater or equal to hot value")
    end
  end

  def hot_temp_cannot_be_less_than_cold_temp
    cold = Temperature.cold
    if cold.present? && value.present? && (value <= cold.value)
      errors.add(:value, "can't be lower or equal to cold value")
    end
  end
end
