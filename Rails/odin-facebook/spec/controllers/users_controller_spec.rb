require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET#index' do
    context 'with user signed in' do
      login_user
      
      it 'should have a current user' do
        expect(subject.current_user).to_not eq(nil)
      end
    
      it 'renders index template' do
        get :index
        expect(response).to render_template('index') 
      end

      it 'shows all other users' do
        get :index
        expect(assigns(:users)).to eq([subject.current_user])
      end
    end

    context 'with no signed in user' do
      it 'redirects to sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET#show' do
    context 'with user signed in' do
      login_user

      it 'shows the current users page' do
        get :show, params: { id: subject.current_user.id }
        expect(response).to render_template('show')

      end
    end
  end
end