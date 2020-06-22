require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:room) { create(:room, event: event) }
  let!(:event_user) { create(:event_user_example, event: event, user: user) }
  let!(:event_user_room) { create(:event_user_room_example, room: room, event_user: event_user) }
  let(:question) { create(:question, room: room, event: event) }
  before { sign_in(user) }

  describe 'GET #index' do
    before do
      get :index, params: { event_id: event.id, room_id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before do
        post :create, params: {
          event_id: event.id,
          room_id: room.id,
          message: 'New message'
        }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not created' do
      before do
        post :create, params: { event_id: event.id, room_id: room.id, message: '' }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { event_id: event.id, room_id: room.id, id: question.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before do
        patch :update, params: {
          event_id: event.id,
          room_id: room.id,
          id: question.id,
          message: 'Update message'
        }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not updated' do
      before do
        patch :update, params: {
          event_id: event.id,
          room_id: room.id,
          id: question.id,
          message: ''
        }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: {
        event_id: event.id,
        room_id: room.id,
        id: question.id
      }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
