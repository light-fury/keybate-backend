require 'rails_helper'

RSpec.describe Api::V1::EventsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
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

  describe 'GET #show' do
    before do
      get :show, params: { id: event.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #join' do
    before do
      post :join, params: { code: event.code }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
