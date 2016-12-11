require 'rails_helper'

RSpec.describe FlightsController do
  describe 'GET #index' do
    let(:flight_attributes) { { origin_id: 1, destination_id: 2, takeoff: Time.now, duration: 100 } }
    let(:airport_attributes) { {code: 1} }

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns @airport_options' do
      Airport.create(airport_attributes)
      get :index
      expect(assigns(:airport_options).count).to eq(1)
    end
  end
end