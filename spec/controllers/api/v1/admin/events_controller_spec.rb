require 'rails_helper'

RSpec.describe Api::V1::Admin::EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }
  before { sign_in(user) }

  describe 'GET #index' do
    context 'with event code' do
      before do
        get :index, params: { code: event.code }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'without event code' do
      before do
        get :index, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before do
        post :create, params: attributes_for(:event), format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not created' do
      before do
        post :create, params: attributes_for(:event, :invalid), format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: event.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before do
        patch :update, params: { id: event.id, name: 'New name' } , format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not updated' do
      before do
        patch :update, params: { id: event.id, name: '' } , format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: event.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
