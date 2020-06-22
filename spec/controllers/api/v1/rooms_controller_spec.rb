require 'rails_helper'

RSpec.describe Api::V1::RoomsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { event_id: event.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    before do
      get :show, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #join' do
    before do
      post :join, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
