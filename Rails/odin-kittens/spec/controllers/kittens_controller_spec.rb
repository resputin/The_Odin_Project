require 'rails_helper'

RSpec.describe KittensController do
  describe 'GET#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'assigns kittens variable' do
      kitten = Kitten.create(name: 'Tim', age: 11, cuteness: 4, softness: 5)
      get :index
      expect(assigns(:kittens)).to eq( [kitten] )
    end
  end

  describe 'GET#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST#create' do
    let(:params) { { kitten: attributes} }

    context 'With valid attributes' do
      let(:attributes) { { name: 'Tim', age: 11, cuteness: 4, softness: 5} }

      it 'creates a new kitten' do
        post :create, params: params
        expect(Kitten.count).to eq(1)
      end

      it 'redirects to index' do
        post :create, params: params
        expect(response).to redirect_to('/kittens')
      end
    end

    context 'With invalid attributes' do
      let(:attributes) { {name: 'Tim', age: 11, cuteness: 4} }

      it 'does not create a new kitten' do
        post :create, params: params
        expect(Kitten.count).to eq(0)
      end

      it 'renders the new template' do
        post :create, params: params
        expect(response).to render_template('new')
      end
    end   
  end

  describe 'GET#show' do
    let(:params) { { kitten: attributes} }
    let(:attributes) { { name: 'Tim', age: 11, cuteness: 4, softness: 5} }


    it 'renders show' do
      kitten = Kitten.create(attributes)
      get :show, params: { id: 1 }
      expect(response).to render_template('show')
    end
  end
end