require 'rails_helper'

RSpec.describe Api::V1::ContactsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:event) { create(:event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let(:contact) { create(:contact, event: event, from_user: user, to_user: other_user) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    let(:other_user) { create(:user) }

    before do
      post :create, params: { event_id: event.id, to_user_id: other_user.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: contact.id, to_user_id: other_user.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #update' do
    let(:other_event) { create(:event) }

    before do
      patch :update, params: { id: contact.id, to_user_id: other_user.id, last_message_sent_at: DateTime.current }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: contact.id, to_user_id: other_user.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #block' do
    before do
      patch :block, params: { id: contact.id, to_user_id: other_user.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #unblock' do
    before do
      patch :unblock, params: { id: contact.id, to_user_id: other_user.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #with_messages' do
    before do
      get :with_messages, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
