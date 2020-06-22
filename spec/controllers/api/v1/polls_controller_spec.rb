require 'rails_helper'

RSpec.describe Api::V1::PollsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }
  let(:poll) { create(:poll, room: room, event: event) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { event_id: event.id, room_id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    before do
      get :show, params: { event_id: event.id, room_id: room.id, id: poll.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
