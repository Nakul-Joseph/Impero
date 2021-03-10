require 'rails_helper'

RSpec.describe Temperature, type: :model do
  let(:temperature) { build(:temperature) }

  it 'has a valid factory' do
    expect(build(:temperature)).to be_valid
  end

  describe 'ActiveModel validations' do
    it { should validate_presence_of(:temp_type) }
    it { should define_enum_for(:temp_type).with_values([:hot, :cold]) }
    it { should validate_presence_of(:value) }
    it { should validate_numericality_of(:value) }
    it { should validate_inclusion_of(:value).in_range(-60.0..60.0)
                                             .with_message('should be between -60 and 60 degree celcius') }
  end
end
