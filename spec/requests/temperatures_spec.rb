# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Temperatures', type: :request do
  let(:hot) { create(:temperature, temp_type: :hot, value: 20.0) }
  let(:cold) { create(:temperature, temp_type: :cold, value: 5.0) }

  describe 'POST #create' do
    context 'Invalid params' do
      it "should respond with Value can't be blank" do
        post '/temperatures', params: { temperature: { temp_type: :hot, value: '' } }
        expect(assigns(:temp).errors.full_messages.first).to eq("Value can't be blank")
      end

      it "should respond with 'Value is not a number'" do
        post '/temperatures', params: { temperature: { temp_type: :hot, value: 'ad' } }
        expect(assigns(:temp).errors.full_messages.first).to eq('Value is not a number')
      end

      it 'should respond with Validation failed error message' do
        post '/temperatures', params: { temperature: { temp_type: :hot, value: '112' } }
        expect(assigns(:temp).errors.full_messages.first).to eq('Value should be between -60 and 60 degree celcius')
      end

      it 'should respond with error message if hot < cold' do
        cold
        post '/temperatures', params: { temperature: { temp_type: :hot, value: '4' } }
        expect(assigns(:temp).errors.full_messages.first).to eq("Value can't be lower or equal to cold value")
      end

      it 'should respond with error message if cold > hot' do
        hot
        post '/temperatures', params: { temperature: { temp_type: :cold, value: '21' } }
        expect(assigns(:temp).errors.full_messages.first).to eq("Value can't be greater or equal to hot value")
      end
    end

    context 'Valid params' do
      it 'should create a new Temperature' do
        post '/temperatures', params: { temperature: { temp_type: :cold, value: '6' } }
        expect(Temperature.count).to eq(1)
        expect(Temperature.last.temp_type).to eq('cold')
        expect(Temperature.last.value).to eq(6)
      end

      it 'should find and update existing temperature' do
        cold
        post '/temperatures', params: { temperature: { temp_type: :cold, value: '6' } }
        expect(Temperature.count).to eq(1)
        expect(Temperature.last.temp_type).to eq('cold')
        expect(Temperature.last.value).to eq(6)
      end
    end
  end
end
