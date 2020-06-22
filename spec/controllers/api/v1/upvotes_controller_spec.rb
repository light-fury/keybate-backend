require 'rails_helper'

RSpec.describe Api::V1::UpvotesController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }
  let(:question) { create(:question, room: room, event: event) }
  let(:upvote) { create(:question_upvote, user: user, question: question) }
  before { sign_in(user) }

  describe 'POST #create' do
    before do
      post :create, params: {
        event_id: event.id,
        room_id: room.id,
        question_id: question.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: {
        event_id: event.id,
        room_id: room.id,
        question_id: question.id,
        id: upvote.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
