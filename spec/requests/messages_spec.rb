require 'rails_helper'

RSpec.describe "Make Conversations", type: :request do
  let!(:users) { create_list(:user, 2) }
  let(:headers) { { 'Authorization' => token_generator(users.first.id) } }

  describe "POST /messages" do
    let(:valid_attributes) do 
      { body: Faker::Lorem.paragraph, recipient_id: users.second.id.to_s }
    end

    context 'when the request is valid' do
      before { post '/messages', params: valid_attributes, headers: headers }

      it 'creates a message' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
        let(:invalid_attributes) { { recipient_id: users.second.id.to_s} }
        before { post '/messages', params: invalid_attributes, headers: headers }

        it 'returns status code 422' do
            expect(response).to have_http_status(422)
        end
    
        it 'returns a validation failure message' do
            expect(response.body)
              .to match(/Validation failed: Body can't be blank/)
        end
    end
  end

end
