require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:user_two) { create(:user) }
  let(:event) { create(:event) }
  let(:contact) { create(:contact_example, event: event, from_user: user, to_user: user_two) }
  let(:message) { create(:message, contact: contact) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { contact_id: contact.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before do
        post :create, params: { contact_id: contact.id, body: 'New message' }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not created' do
      before do
        post :create, params: { contact_id: contact.id, body: '' }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { contact_id: contact.id, id: message.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before do
        patch :update, params: {
          contact_id: contact.id,
          id: message.id,
          body: 'Update message'
        }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not updated' do
      before do
        patch :update, params: { contact_id: contact.id, id: message.id, body: '' }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { contact_id: contact.id, id: message.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #mark_as_read' do
    before do
      patch :mark_as_read, params: { contact_id: contact.id, id: message.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
