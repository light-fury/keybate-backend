require 'rails_helper'

RSpec.describe Api::V1::Admin::AttendeesController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { event_id: event.id, room_id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
