require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  let(:user) { create(:user) }
  let(:notification) { create(:notification, user: user) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: notification.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { id: notification.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #mark_as_read' do
    before do
      patch :mark_as_read, params: { id: notification.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
