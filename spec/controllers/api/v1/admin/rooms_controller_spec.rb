require 'rails_helper'

RSpec.describe Api::V1::Admin::RoomsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let!(:event_moderator) { create(:event_moderator_example, event: event, user: user) }
  let(:room) { create(:room, event: event) }
  before { sign_in(user) }

  describe 'POST #create' do
    context 'when is successfully created' do
      before do
        post :create, params: { event_id: event.id, name: 'New name' }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not created' do
      before do
        post :create, params: { event_id: event.id, name: '' }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'PUT/PATCH #update' do
    context 'when is successfully updated' do
      before do
        patch :update, params: {
          event_id: event.id,
          id: room.id,
          name: 'Update name'
        }, format: :json
      end

      it { expect(response).to have_http_status(200) }
    end

    context 'when is not updated' do
      before do
        patch :update, params: { event_id: event.id, id: room.id, name: '' }, format: :json
      end

      it { expect(response).to have_http_status(422) }
    end
  end

  describe 'DELETE #destroy' do
    before do
      delete :destroy, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #clear_display' do
    before do
      patch :clear_display, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #hide_questions' do
    before do
      patch :hide_questions, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #show_questions' do
    before do
      patch :show_questions, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end

  describe 'PATCH #allow_microphone_requests' do
    before do
      patch :allow_microphone_requests, params: { event_id: event.id, id: room.id }, format: :json
    end

    it { expect(response).to have_http_status(200) }
  end
end
