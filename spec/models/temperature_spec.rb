# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Temperature, type: :model do
  let(:temperature) { build(:temperature) }

  it 'has a valid factory' do
    expect(build(:temperature)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:temp_type) }
    it { should define_enum_for(:temp_type).with_values(%i[hot cold]) }
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value) }
    it {
      should validate_inclusion_of(:value).in_range(-60.0..60.0)
                                          .with_message('should be between -60 and 60 degree celcius')
    }
  end

  describe 'Custom Validations' do
    let(:cold) { create(:temperature, temp_type: :cold, value: 5.0) }
    let(:hot) { create(:temperature, temp_type: :hot, value: 20.0) }

    before { cold && hot }

    it 'validates if hot value is greater than cold value' do
      hot.value = 4
      hot.valid?
      expect(hot.errors.full_messages.first).to eq("Value can't be lower or equal to cold value")
    end

    it 'validates if cold value is lesser than hot value' do
      cold.value = 22
      cold.valid?
      expect(cold.errors.full_messages.first).to eq("Value can't be greater or equal to hot value")
    end
  end
end
