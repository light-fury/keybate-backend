require 'rails_helper'

RSpec.describe Api::V1::Admin::QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }
  let(:question) { create(:question, room: room, event: event) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { event_id: event.id, room_id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #display' do
    before do
      patch :display, params: { event_id: event.id, room_id: room.id, id: question.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #hide' do
    before do
      patch :hide, params: { event_id: event.id, room_id: room.id, id: question.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #pin' do
    before do
      patch :pin, params: { event_id: event.id, room_id: room.id, id: question.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #remove' do
    before do
      patch :remove, params: { event_id: event.id, room_id: room.id, id: question.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #send_to_bottom' do
    before do
      patch :send_to_bottom, params: { event_id: event.id, room_id: room.id, id: question.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #call' do
    before do
      post :call, params: { event_id: event.id, room_id: room.id, id: question.id, data: {} }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
