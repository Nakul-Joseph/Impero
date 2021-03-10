# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forecasts', type: :request do
  let(:hot) { create(:temperature, temp_type: :hot, value: 20.0) }
  let(:cold) { create(:temperature, temp_type: :cold, value: 5.0) }

  describe 'GET #index' do
    it 'responds with 200' do
      get '/'
      expect(response.code).to eq('200')
    end

    it 'responds with index template' do
      get '/'
      expect(response).to render_template(:index)
    end

    it 'shows assigned hot and cold values' do
      hot && cold
      get '/'
      expect(assigns(:hot).value).to eq(20.0)
      expect(assigns(:cold).value).to eq(5.0)
    end
  end

  describe 'POST #search' do
    context 'invalid postcode' do
      it "should respond with 'Invalid postcode provided.'" do
        post '/forecasts/search', params: { search: { postcode: '' } }
        expect(response.body).to include('Invalid postcode provided.')
      end

      it "should respond with 'No matching location found.'" do
        post '/forecasts/search', params: { search: { postcode: '123' } }
        expect(response.body).to include('No matching location found.')
      end

      it "should respond with 'Please enter a valid UK postcode.'" do
        post '/forecasts/search', params: { search: { postcode: '90011' } }
        expect(response.body).to include('Please enter a valid UK postcode.')
      end

      it "should respond with 'Cold temperature not defined.'" do
        hot
        post '/forecasts/search', params: { search: { postcode: 'EC2N' } }
        expect(response.body).to include('Cold temperature not defined.')
      end

      it "should respond with 'Hot temperature not defined.'" do
        cold
        post '/forecasts/search', params: { search: { postcode: 'EC2N' } }
        expect(response.body).to include('Hot temperature not defined.')
      end
    end

    context 'valid postcode' do
      it 'should assign todays weather' do
        hot && cold
        post '/forecasts/search', params: { search: { postcode: 'EC2N' } }
        expect(response.code).to eq('200')
        expect(assigns(:response).keys).to eq(%i[max_temp_c today])
      end
    end
  end
end
