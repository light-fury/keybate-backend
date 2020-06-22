require 'rails_helper'

RSpec.describe Api::V1::AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }
  let(:poll) { create(:poll, room: room, event: event) }
  let(:option) { create(:poll_option, poll: poll) }
  let(:answer) { create(:poll_answer, user: user, poll: poll) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: {
        event_id: event.id,
        room_id: room.id,
        poll_id: poll.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    before do
      post :create, params: {
        event_id: event.id,
        room_id: room.id,
        poll_id: poll.id,
        user_id: user.id,
        option_id: option.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #show' do
    before do
      get :show, params: {
        event_id: event.id,
        room_id: room.id,
        poll_id: poll.id,
        id: answer.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #update' do
    let(:other_option) { create(:poll_option, poll: poll) }

    before do
      patch :update, params: {
        event_id: event.id,
        room_id: room.id,
        poll_id: poll.id,
        user_id: user.id,
        option_id: other_option.id,
        id: answer.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: {
        event_id: event.id,
        room_id: room.id,
        poll_id: poll.id,
        id: answer.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
