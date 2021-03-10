# frozen_string_literal: true

FactoryBot.define do
  factory :temperature do
    temp_type { :hot }
    value { 1.2 }
  end
end
