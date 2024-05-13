require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  describe 'POST /signup' do
    scenario 'valid user attributes' do
      post user_registration_path, params: {
        user: {
          email: 'test@test.com',
          password: 'password',
          name: 'joe'
        }
      }

      # Add assertions here, for example:
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
    end
  end
end
RSpec.describe Users::SessionsController, type: :request do
  describe 'POST /login' do
    scenario 'valid user attributes' do
      user = User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'password')

      post user_session_path, params: {
        user: {
          email: 'john.doe@example.com',
          password: 'password',
        }
      }

      # Add assertions here, for example:
      expect(response).to have_http_status(:ok)
      expect(response.content_type).to include('application/json')
    end
  end
end